//
//  JLSupportVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLSupportVC.h"
#import "CollectionViewCell.h"
#import "TZImagePickerController.h"
@interface JLSupportVC ()<TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,JLDataHandlerProtocol>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *photosArray;
@property (nonatomic ,strong) NSMutableArray *assestArray;
@property BOOL isSelectOriginalPhoto;
@end

@implementation JLSupportVC
{
    UITextView * tv;
    UILabel * line2;
    CGFloat _itemWH;
    CGFloat _margin;
    NSString * _imageUp_url;
    NSMutableArray * _imageUrlArr;
    NSString * _imageUrl;
    NSMutableArray * _imageArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
//    _dataArr = [[NSMutableArray alloc]init];
    _imageArr = [[NSMutableArray alloc]init];
    _imageUrl = @"";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setUI];
}
//-(void)commitSurpport{
//    [[[JLSurpportAPI commitSurpportWithContent:tv.text image:_imageUrl] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
//}
-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    
    if ([responseObject isKindOfClass:[JLSurpportAPI class]]) {
        JLSurpportAPI *api = responseObject;
        [StateView showSuccessInfo:api.info];
    }
    
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    
}
-(void)setUI{
    UIView * bgview = [[UIView alloc]init];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    bgview.sd_layout.topSpaceToView(self.view, 10).leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).heightIs(ScreenHeight*0.8);
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setBackgroundColor:UIColorFromRGB(0x5251F5)];
    [commitBtn addTarget:self action:@selector(commitBtnClciked) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [self.view addSubview:commitBtn];
    commitBtn.sd_layout.bottomSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).heightIs(50);
    tv = [[UITextView alloc]init];
    tv.placeholderStr = @"请写下您的功能建议或发现的系统的问题";
    tv.font = FONT(15);
    [bgview addSubview:tv];
    tv.sd_layout.topSpaceToView(bgview, 5).leftSpaceToView(bgview, 10).rightSpaceToView(bgview, 10).heightIs(180*MYWIDTH);
    line2 = [[UILabel alloc]init];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgview addSubview:line2];
    line2.sd_layout.topSpaceToView(tv, 10).leftSpaceToView(bgview, 0).rightSpaceToView(bgview, 0).heightIs(8);
    UIImageView * imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"图片"];
    [bgview addSubview:imageV];
    imageV.sd_layout.topSpaceToView(line2, 10).leftSpaceToView(bgview, 10).widthIs(16).heightIs(12);
    UILabel * addLabel = [[UILabel alloc]init];
    addLabel.text = @"添加图片";
    addLabel.font = FONT(14);
    addLabel.textColor = kBlackColor;
    [bgview addSubview:addLabel];
    addLabel.sd_layout.centerYEqualToView(imageV).leftSpaceToView(imageV,5).widthIs(60).heightIs(20);
    UILabel * line3 = [[UILabel alloc]init];
    line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgview addSubview:line3];
    line3.sd_layout.topSpaceToView(addLabel, 10).leftSpaceToView(bgview, 0).rightSpaceToView(bgview, 0).heightIs(1);
    _margin = 4;
    _itemWH = (bgview.width - 2 * _margin - 4) / 3 - _margin;
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    flowLayOut.itemSize = CGSizeMake((ScreenWidth - 50)/ 4, (ScreenWidth - 50)/ 4);
    flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayOut];
    _collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [bgview addSubview:self.collectionView];
    self.collectionView.sd_layout.topSpaceToView(line3, 10).leftSpaceToView(bgview, 10).rightSpaceToView(bgview, 10).heightIs(208);
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}
- (NSMutableArray *)photosArray{
    if (!_photosArray) {
        self.photosArray = [NSMutableArray array];
    }
    return _photosArray;
}

- (NSMutableArray *)assestArray{
    if (!_assestArray) {
        self.assestArray = [NSMutableArray array];
    }
    return _assestArray;
}
- (void)checkLocalPhoto{
    
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [imagePicker setSortAscendingByModificationDate:NO];
    imagePicker.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePicker.selectedAssets = _assestArray;
    imagePicker.allowPickingVideo = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    for (UIImage * image in photos) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            NSString * baseImage = [NSString base64String:image];
            _imageUrl = baseImage;
//            [_imageArr addObject:baseImage];
//            _imageUrl = [_imageArr componentsJoinedByString:@","];
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.photosArray = [NSMutableArray arrayWithArray:photos];
                self.assestArray = [NSMutableArray arrayWithArray:assets];
                _isSelectOriginalPhoto = isSelectOriginalPhoto;
                [_collectionView reloadData];
            });
            
        });
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _photosArray.count) {
        [self checkLocalPhoto];
    }else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_assestArray selectedPhotos:_photosArray index:indexPath.row];
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _photosArray = [NSMutableArray arrayWithArray:photos];
            _assestArray = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_photosArray.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _photosArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == _photosArray.count) {
        cell.imagev.image = [UIImage imageNamed:@"AlbumAddBtn@2x"];
        //        cell.imagev.backgroundColor = [UIColor redColor];
        cell.deleteButton.hidden = YES;
        
    }else{
        cell.imagev.image = _photosArray[indexPath.row];
        //        cell.deleteButton.hidden = NO;
        cell.deleteButton.hidden = YES;
    }
    cell.deleteButton.tag = 100 + indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deletePhotos:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)deletePhotos:(UIButton *)sender{
    [_photosArray removeObjectAtIndex:sender.tag - 100];
    [_assestArray removeObjectAtIndex:sender.tag - 100];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag-100 inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}
-(void)commitBtnClciked{
    if ([tv.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请输入您的建议"];
        return;
    }
    if (_imageUrl.length == 0) {
        [StateView showWarningInfo:@"请选择图片"];
        return;
    }
    if (_imageArr.count>5) {
        [StateView showWarningInfo:@"最多选择5张图片"];
        return;
    }
    [self uploadProInfoWithImage:_imageUrl];
}
-(void)uploadProInfoWithImage:(NSString *)image{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:image forKey:@"image"];
    [parameter setObject:tv.text forKey:@"content"];
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/config/index"] parameters:parameter progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功---%@---%@--%@",responseObject,[responseObject class],dic);
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             [StateView showSuccessInfo:[dic objectForKey:@"info"]];
             [self.navigationController popViewControllerAnimated:YES];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"请求失败--%@",error);
     }];
}
@end
