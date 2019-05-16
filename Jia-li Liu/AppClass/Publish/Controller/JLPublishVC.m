//
//  SYPublishVC.m
//  Jia-li Liu
//
//  Created by KLIANS on 2017/4/27.
//  Copyright © 2017年 KLIANS. All rights reserved.
//

#import "JLPublishVC.h"
#import "CollectionViewCell.h"
#import "TZImagePickerController.h"
@interface JLPublishVC ()<TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,JLDataHandlerProtocol,UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *photosArray;
@property (nonatomic ,strong) NSMutableArray *assestArray;
@property BOOL isSelectOriginalPhoto;

@end

@implementation JLPublishVC
{
    CGFloat _itemWH;
    CGFloat _margin;
    NSString * _imageUp_url;
    NSMutableArray * _imageUrlArr;
    UITextField * titTf;
    UITextView * tv;
    UILabel * line2;
    NSMutableArray * _dataArr;
    NSString * _typeId;
    NSString * _imageUrl;
    NSMutableArray * _imageArr;
    UILabel * flLabel;
    UIImageView * addImage;
    ImagePicker *imagePicker;
}
#pragma mark - ################################# 生命周期 #################################

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _dataArr = [[NSMutableArray alloc]init];
    _imageArr = [[NSMutableArray alloc]init];
    _imageUrl = @"";
    _typeId = @"";
    //初始化UI
    imagePicker = [ImagePicker sharedManager];
    [self setUI];
    [self getProductTypeInfo];
}
-(void)getProductTypeInfo{
    [_dataArr removeAllObjects];
    
    [[[JLProTypeAPI getProductType] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}
-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[JLProTypeAPI class]]) {
        JLProTypeAPI *api = responseObject;
        [_dataArr addObjectsFromArray:api.data];
        
    }
    if ([responseObject isKindOfClass:[JLUploadHeadAPI class]]) {
        JLUploadHeadAPI *api = responseObject;
        [StateView showSuccessInfo:api.info];
    }
    
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
/**
 初始化UI
 */
- (void)setUI{
    self.title = @"上传";
    UIView * bgview = [[UIView alloc]init];
    bgview.backgroundColor = [UIColor whiteColor];
    ViewRadius(bgview, 8.f);
    [self.view addSubview:bgview];
    bgview.sd_layout.topSpaceToView(self.view, 10).leftSpaceToView(self.view, 10).rightSpaceToView(self.view, 10).heightIs(ScreenHeight*0.6);
    UIButton * uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [uploadBtn setBackgroundImage:[UIImage imageNamed:@"loginBG"] forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(uploadBtnClciked) forControlEvents:UIControlEventTouchUpInside];
    [uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    [self.view addSubview:uploadBtn];
    uploadBtn.sd_layout.topSpaceToView(bgview, 30).leftSpaceToView(self.view, 60).rightSpaceToView(self.view, 60).heightIs(40);
    
    titTf = [[UITextField alloc]init];
    titTf.placeholder = @"添加标题...";
    titTf.borderStyle = UITextBorderStyleNone;
    titTf.returnKeyType = UIReturnKeyDone;
    titTf.delegate = self;
    [bgview addSubview:titTf];
    titTf.sd_layout.topSpaceToView(bgview, 10).leftSpaceToView(bgview, 10).rightSpaceToView(bgview, 10).heightIs(40);
    UILabel * line1 = [[UILabel alloc]init];
    line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgview addSubview:line1];
    line1.sd_layout.topSpaceToView(titTf, 10).leftSpaceToView(bgview, 10).rightSpaceToView(bgview, 10).heightIs(1);
    tv = [[UITextView alloc]init];
    tv.placeholderStr = @"作品说明(默认第一张为封面)";
    tv.font = FONT(15);
    tv.delegate = self;
    tv.returnKeyType = UIReturnKeyDone;
    [bgview addSubview:tv];
    tv.sd_layout.topSpaceToView(line1, 5).leftSpaceToView(bgview, 10).rightSpaceToView(bgview, 10).heightIs(100);
    line2 = [[UILabel alloc]init];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgview addSubview:line2];
    line2.sd_layout.topSpaceToView(tv, 10).leftSpaceToView(bgview, 10).rightSpaceToView(bgview, 10).heightIs(1);
    addImage = [[UIImageView alloc]init];
    addImage.image = JLGetImage(@"AlbumAddBtn.png");
    [bgview addSubview:addImage];
    addImage.sd_layout.leftSpaceToView(bgview, 10).topSpaceToView(line2, 10).widthIs(80).heightIs(80);
    addImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageAction)];
    recognizer.delegate = self;
    [addImage addGestureRecognizer:recognizer];
//    _margin = 4;
//    _itemWH = (bgview.width - 2 * _margin - 4) / 3 - _margin;
//    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
//    flowLayOut.itemSize = CGSizeMake((ScreenWidth - 50)/ 4, (ScreenWidth - 50)/ 4);
//    flowLayOut.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayOut];
//    _collectionView.backgroundColor = [UIColor clearColor];
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    [bgview addSubview:self.collectionView];
//    self.collectionView.sd_layout.topSpaceToView(line2, 10).leftSpaceToView(bgview, 10).rightSpaceToView(bgview, 10).heightIs(215);
//    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    UILabel * line3 = [[UILabel alloc]init];
    line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bgview addSubview:line3];
    line3.sd_layout.topSpaceToView(addImage, 25).leftSpaceToView(bgview, 10).rightSpaceToView(bgview, 10).heightIs(1);
    UIImageView * imge = [[UIImageView alloc]init];
    imge.image = [UIImage imageNamed:@"详细分类"];
    [bgview addSubview:imge];
    imge.sd_layout.topSpaceToView(line3, 6).leftSpaceToView(bgview, 10).widthIs(18).heightIs(16);
    UILabel * fenlei = [[UILabel alloc]init];
    fenlei.textColor = [UIColor grayColor];
    fenlei.font = FONT(14);
    fenlei.text = @"作品分类";
    [bgview addSubview:fenlei];
    fenlei.sd_layout.topSpaceToView(line3, 5).leftSpaceToView(imge, 5).widthIs(60).heightIs(20);
    flLabel = [[UILabel alloc]init];
    flLabel.textColor = [UIColor grayColor];
    flLabel.text = @"选择";
    flLabel.font = FONT(14);
    flLabel.textAlignment = NSTextAlignmentRight;
    [bgview addSubview:flLabel];
    flLabel.sd_layout.centerYEqualToView(fenlei).rightSpaceToView(bgview, 10).widthIs(60).heightIs(20);
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, line3.bottom, ScreenWidth, 30);
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:button];
    button.sd_layout.rightSpaceToView(bgview, 0).leftSpaceToView(bgview, 0).topSpaceToView(line3, 5).heightIs(30);
    [self setLeftNav];
    
}
-(void)uploadBtnClciked{
    
    if ([titTf.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请添加标题"];
        return;
    }
    if ([tv.text isEqualToString:@""]) {
        [StateView showWarningInfo:@"请填写作品说明"];
        return;
    }
    if ([[NSString emptyStr:_typeId] integerValue] == 0) {
        [StateView showWarningInfo:@"请选择作品分类"];
        return;
    }
    if ([_imageUrl isEqualToString:@""]) {
        [StateView showWarningInfo:@"请选择上传的图片"];
        return;
    }
    if (_imageArr.count>5) {
        [StateView showWarningInfo:@"最多选择1张图片"];
        return;
    }
    [self uploadProInfoWithImage:_imageUrl];
//     [[[JLProductUploadAPI uploadHeadImageWithBaseHeadImage:_imageUrl TypeId:_typeId Title:titTf.text Content:tv.text] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
}
-(void)uploadProInfoWithImage:(NSString *)image{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:_typeId forKey:@"typeId"];
    [parameter setObject:image forKey:@"image"];
    [parameter setObject:titTf.text forKey:@"title"];
    [parameter setObject:tv.text forKey:@"content"];
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/person/save"] parameters:parameter progress:nil success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"请求成功---%@---%@--%@",responseObject,[responseObject class],dic);
         if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
             [StateView showSuccessInfo:[dic objectForKey:@"info"]];
             [self.navigationController dismissViewControllerAnimated:YES completion:nil];
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"请求失败--%@",error);
     }];
}
-(void)typeBtnClick:(UIButton *)sender{
    PopupsViewBlock *view = [[PopupsViewBlock alloc] initWithItemArr:_dataArr];
    [view showView];
    [view setBlock:^(NSString *name, NSString *typeid) {
        flLabel.text = name;
        _typeId = typeid;
    }];
}
-(void)setLeftNav{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitle:@"关闭" forState:(UIControlStateNormal)
     ];
    [button setTitleColor:AppNavTitleColor forState:(UIControlStateNormal)];
    button.titleLabel.font = FONT(15);
    [button addTarget:self action:@selector(didTap) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)didTap{
    [self dismissViewControllerAnimated:YES completion:nil];
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
-(void)addImageAction{
    //设置主要参数
    [imagePicker dwSetPresentDelegateVC:self SheetShowInView:self.view InfoDictionaryKeys:(long)nil];
    
    //回调
    [imagePicker dwGetpickerTypeStr:^(NSString *pickerTypeStr) {
        
        NSLog(@"-----%@",pickerTypeStr);
        
    } pickerImagePic:^(UIImage *pickerImagePic) {
        addImage.image = pickerImagePic;
        NSString * baseImage = [NSString base64String:pickerImagePic];
        _imageUrl = baseImage;
//        //这里执行上传图片的网络请求
//        [self uploadImageInfoWithBaseImage:encodedImageStr];
    }];
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
    addImage.image = photos[0];
    for (UIImage * image in photos) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
//            [self upHeadPhotoFileWithImage:image];
            NSString * baseImage = [NSString base64String:image];
            _imageUrl = baseImage;
//            [_imageArr addObject:baseImage];
//            _imageUrl = [_imageArr componentsJoinedByString:@","];
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.photosArray = [NSMutableArray arrayWithArray:photos];
                self.assestArray = [NSMutableArray arrayWithArray:assets];
                _isSelectOriginalPhoto = isSelectOriginalPhoto;
//                [_collectionView reloadData];
//                addImage.image = image;
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [textField resignFirstResponder];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}
@end
