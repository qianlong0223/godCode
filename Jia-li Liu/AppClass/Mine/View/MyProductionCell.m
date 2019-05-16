//
//  MyProductionCell.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/20.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "MyProductionCell.h"
#import "CGQCollectionViewCell.h"
#import "JLProductDetailVC.h"
@interface MyProductionCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionReusableView *headerView;
@property (nonatomic,strong)UILabel *label;
@end
@implementation MyProductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"MyProductionCell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor redColor];
        [self creatSubViews];
    }
    return self;
}
-(void)setArray:(NSMutableArray *)array{
    _array = array;
    [self.collectionView reloadData];
}
- (void)creatSubViews{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;
    CGFloat width = ScreenWidth;
    flowLayout.itemSize = CGSizeMake(width/3-20, width/3-20);
    flowLayout.headerReferenceSize = CGSizeMake(width, 40);
//    CGFloat collectionHeight = (dataArray.count/3+1)*80;
   self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width,500) collectionViewLayout:flowLayout];
    self.collectionView.enablePlaceHolderView = YES;
    [self addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CGQCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CGQCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGQCollectionViewCell *cell = (CGQCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CGQCollectionViewCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,_array[indexPath.item][@"image"]]] placeholderImage:[UIImage imageNamed:@"picture_home"]];
    NSString * status = [NSString stringWithFormat:@"%@",_array[indexPath.item][@"status"]];
    NSString * praiseNum = [NSString stringWithFormat:@"%@",_array[indexPath.item][@"praiseNum"]];
    if ([status isEqualToString:@"1"]) {
        cell.redBgView.hidden = YES;
        cell.state.hidden = NO;
        cell.state.backgroundColor = kGrayColor;
        cell.state.text = @"未审核";
    }if ([status isEqualToString:@"2"]) {
        cell.state.hidden = YES;
        cell.redBgView.hidden = NO;
        cell.zanImage.image = [UIImage imageNamed:@"heart"];
        cell.count.text = praiseNum;
    }
    ViewRadius(cell.state, 8.f);
    ViewRadius(cell.redBgView, 8.f);
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10.0;
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor=[[UIColor blackColor]CGColor];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        _headerView.backgroundColor =[UIColor whiteColor];
        [_headerView addSubview:self.label];
         _label.text=@"   我的作品";
        return _headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerView.backgroundColor =[UIColor grayColor];
        UILabel *footerlabel = [[UILabel alloc] initWithFrame:footerView.bounds];
        footerlabel.text=@"footerview";
        footerlabel.textAlignment = NSTextAlignmentCenter;
        footerlabel.font = [UIFont systemFontOfSize:20];
        [footerView addSubview:footerlabel];
        
        return footerView;
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 13, 10, 13);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)indexPath.row);
    NSString * paintId = _array[indexPath.item][@"paintingId"];
    NSString * status = [NSString stringWithFormat:@"%@",_array[indexPath.item][@"status"]];
    JLProductDetailVC * vc = [[JLProductDetailVC alloc]init];
    vc.paintId = paintId;
//    if ([status isEqualToString:@"1"]) {
//        [StateView showWarningInfo:@"未审核"];
//        return;
//    }else{
//        [self.zyviewController.navigationController pushViewController:vc animated:YES];
//    }
    [self.zyviewController.navigationController pushViewController:vc animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:_headerView.bounds];
        [_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        _label.textAlignment = NSTextAlignmentLeft;
    }
    return _label;
}
@end
