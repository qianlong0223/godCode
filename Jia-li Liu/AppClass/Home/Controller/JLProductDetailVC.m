//
//  JLProductDetailVC.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/25.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLProductDetailVC.h"
#import "YHPhotoBrowser.h"
#import  "YYWebImage.h"
@interface JLProductDetailVC ()<JLDataHandlerProtocol,UIGestureRecognizerDelegate>

@property (nonatomic,strong)UIScrollView * mainsrcollview;
@property (nonatomic,strong)UIView * contrainerview;
@property (nonatomic,strong)UIView * bgViewone;
@property (nonatomic,strong)UIImageView * picture;
@property (nonatomic,strong)UILabel * product;
@property (nonatomic,strong)UILabel * zancount;
@property (nonatomic,strong)UIButton * zanbtn;
@property (nonatomic,strong)UIView * bgViewTwo;
@property (nonatomic,strong)UIImageView * userImageView;
@property (nonatomic,strong)UILabel * teacherName;
@property (nonatomic,strong)UILabel * schoolTime;
@property (nonatomic,strong)UILabel * introduce;


@end

@implementation JLProductDetailVC
{
    CGSize _labelSize;
    NSMutableArray * _imageArr;
    NSString * _pr;
    NSString * _imageString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"作品详情";
    _imageArr = [[NSMutableArray alloc]init];
    [self requestProductDetailClickMemberData];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    
    self.navigationItem.leftBarButtonItem.tintColor =  self.navigationItem.rightBarButtonItem.tintColor = AppNavTitleColor;
 self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}

-(void)bigMap:(UIGestureRecognizer * )tap{
    
    NSArray *srcStringArray = @[_imageString];
    YHPhotoBrowser *photoView=[[YHPhotoBrowser alloc]init];
    photoView.sourceView=self.view;         // 图片所在的父容器
    photoView.urlImgArr = srcStringArray;           //网络链接图片的数组
    photoView.sourceRect= _picture.frame;   // 图片的frame
    photoView.indexTag=0;                      //初始化进去显示的图片下标
    [photoView show];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _mainsrcollview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-44*MYWIDTH);
    _mainsrcollview.contentSize = CGSizeMake(ScreenWidth, ScreenHeight+160*MYWIDTH);
    
}
- (void)testaction {
    NSString * schoolId = [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolId"];
    [[[JLPraiseAPl getProListWithPaintingId:self.paintId SchoolId:schoolId] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
}

-(void)requestProductDetailClickMemberData{
    
    [[[JLProductClickMemberAPI getProductDetailClickMemberWithPaintingId:self.paintId] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}
-(void)requestProductDetailData{
   
    [[[JLProductDetailAPI getProductDetailWithPaintingId:self.paintId] netWorkClient] getRequestInView:self.view networkCodeTypeSuccessDataHandler:self isCache:NO];
    
}

-(void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject{
    if ([responseObject isKindOfClass:[JLProductDetailAPI class]]) {
        
        JLProductDetailAPI *api = responseObject;
        
        [self initUIWithAPI:api];
        
    }
    if ([responseObject isKindOfClass:[JLProductClickMemberAPI class]]) {
        JLProductClickMemberAPI *api = responseObject;
        [_imageArr removeAllObjects];
        NSString * result;
        for (NSString * image in api.data) {
            
            if ([[NSString emptyStr:image] isEqualToString:@""]) {
                result = [NSString stringWithFormat:@"%@%@",BaseUrl,@""];
            }else{
                result = [NSString stringWithFormat:@"%@%@",BaseUrl,image];
            }
            [_imageArr addObject:result];
        }
        NSString * count;
        if (_imageArr.count == 0) {
            [_imageArr removeAllObjects];
        }else{
            count = [NSString stringWithFormat:@"%ld赞",_imageArr.count];
            [_imageArr addObject:count];
        }
        [self requestProductDetailData];
    }
    if ([responseObject isKindOfClass:[JLPraiseAPl class]]) {
        JLPraiseAPl* api = responseObject;
        [StateView showSuccessInfo:[NSString stringWithFormat:@"%@成功",api.state]];
        if ([api.state isEqualToString:@"1"]) {
            [StateView showSuccessInfo:@"取消点赞"];
            [_zanbtn setImage:[UIImage imageNamed:@"nonpraise"] forState:UIControlStateNormal];
        }else{
            [StateView showSuccessInfo:@"点赞成功"];
            [_zanbtn setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
        }
        _pr = api.state;
        [self requestProductDetailClickMemberData];
    }
}

-(void)netWorkCodeFailureDealWithResponseObject:(id)responseObject{
    CLog(@"%@",responseObject);
    
}
-(void)initUIWithAPI:(JLProductDetailAPI *)api{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _mainsrcollview = [[UIScrollView alloc]init];
    [self.view addSubview:_mainsrcollview];
_mainsrcollview.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).bottomEqualToView(self.view);
    _contrainerview = [[UIView alloc]init];
    _contrainerview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ViewRadius(_contrainerview, 8.f);
    [_mainsrcollview addSubview:_contrainerview];
    _contrainerview.sd_layout.leftEqualToView(_mainsrcollview).rightEqualToView(_mainsrcollview).topEqualToView(_mainsrcollview).heightIs(8000);
    _bgViewone = [[UIView alloc]init];
    _bgViewone.backgroundColor = kWhiteColor;
    ViewRadius(_bgViewone, 8.f);
    [self.contrainerview addSubview:_bgViewone];
    CGSize imageSize = [UIImage getImageSizeWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,api.image]]];
    if (imageSize.height>500) {
        _bgViewone.sd_layout.leftSpaceToView(self.contrainerview, 6).rightSpaceToView(self.contrainerview, 6).topSpaceToView(self.contrainerview,10).heightIs(500*MYWIDTH);
    }else{
        
        _bgViewone.sd_layout.leftSpaceToView(self.contrainerview, 6).rightSpaceToView(self.contrainerview, 6).topSpaceToView(self.contrainerview,10).heightIs(ScreenWidth/(imageSize.width/imageSize.height));
    }
    _product = [[UILabel alloc]init];
    [_bgViewone addSubview:_product];
    _product.text = api.title;
    _product.textColor = [UIColor blackColor];
    _product.font = FONT(15*MYWIDTH);
    _product.textAlignment = 0;
    _product.sd_layout.leftSpaceToView(_bgViewone, 5).topSpaceToView(_bgViewone, 8).widthIs(200).heightIs(20);
    _zancount = [[UILabel alloc]init];
    [_bgViewone addSubview:_zancount];
    if ([api.praiseNum isEqualToString:@"0"]) {
        _zancount.text = @"赞";
    }else{
        _zancount.text = api.praiseNum;
    }
//    _zancount.text = [NSString stringWithFormat:@"%@",api.praiseNum];
    _zancount.textColor = [UIColor blackColor];
    _zancount.font = FONT(13*MYWIDTH);
    _zancount.textAlignment = 0;
    CGSize size = CGSizeMake(100, MAXFLOAT);//设置高度宽度的最大限度
    CGRect rect = [_zancount.text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12*MYWIDTH]} context:nil]; _zancount.sd_layout.centerYEqualToView(_product).rightSpaceToView(_bgViewone, 6).widthIs(rect.size.width).heightIs(20);

    _zanbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_zanbtn addTarget:self action:@selector(testaction) forControlEvents:UIControlEventTouchUpInside];
    [_bgViewone addSubview:_zanbtn];
    _zanbtn.sd_layout.rightSpaceToView(_zancount, 2).centerYEqualToView(_product).widthIs(15).heightIs(15);
    //这是一层透明的butoon 为了增大点赞按钮的接触面
    UIButton * coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [coverBtn addTarget:self action:@selector(testaction) forControlEvents:UIControlEventTouchUpInside];
    [_bgViewone addSubview:coverBtn];
    coverBtn.sd_layout.rightSpaceToView(_bgViewone, 0).centerYEqualToView(_product).widthIs(ScreenWidth).heightIs(30);
    _picture = [[UIImageView alloc]init];
    [_bgViewone addSubview:_picture];
    if (imageSize.width>imageSize.height) {
        _picture.contentMode = UIViewContentModeScaleAspectFill;
    }
    if (imageSize.width<imageSize.height) {
        _picture.contentMode = UIViewContentModeScaleToFill;
    }
    _picture.sd_layout.leftSpaceToView(_bgViewone, 8).topSpaceToView(_product, 8).rightSpaceToView(_bgViewone, 8).bottomSpaceToView(_bgViewone, 10);
    ViewRadius(_picture, 20.f);
    _picture.userInteractionEnabled = YES;
    [_picture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,api.image]] placeholderImage:[UIImage imageNamed:@"123"]];
    _imageString = [NSString stringWithFormat:@"%@%@",BaseUrl,api.image];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigMap:)];
    recognizer.delegate = self;
    [_picture addGestureRecognizer:recognizer];
    if ([api.myPraise isEqualToString:@"1"]) {
        [_zanbtn setImage:[UIImage imageNamed:@"nonpraise"] forState:UIControlStateNormal];
    }else{
        [_zanbtn setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
    }
    _bgViewTwo = [[UIView alloc]init];
    _bgViewTwo.backgroundColor = kWhiteColor;
    ViewRadius(_bgViewTwo, 8.f);
    [self.contrainerview addSubview:_bgViewTwo];
//    _bgViewTwo.sd_layout.leftSpaceToView(self.contrainerview, 6).rightSpaceToView(self.contrainerview, 6).topSpaceToView(_bgViewone,10).heightIs(300*MYWIDTH);
    _bgViewTwo.sd_layout.leftSpaceToView(self.contrainerview, 6).rightSpaceToView(self.contrainerview, 6).topSpaceToView(_bgViewone,10).heightIs(0);
    _userImageView = [[UIImageView alloc]init];
    [_bgViewTwo addSubview:_userImageView];
    _userImageView.sd_layout.leftSpaceToView(_bgViewTwo, 8).topSpaceToView(_bgViewTwo, 8).widthIs(40*MYWIDTH).heightIs(40*MYWIDTH);
    ViewRadius(_userImageView, 20.f*MYWIDTH);
    NSDictionary * sendDic = [NSDictionary dictionaryWithDictionary:api.sender];
    _userImageView.image = [UIImage imageNamed:@"123"];
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,sendDic[@"headImage"]]] placeholderImage:[UIImage imageNamed:@"123"]];
    
    _teacherName = [[UILabel alloc]init];
    [_bgViewTwo addSubview:_teacherName];
    _teacherName.text = sendDic[@"name"];
    _teacherName.textColor = [UIColor blackColor];
    _teacherName.font = FONT(15*MYWIDTH);
    _teacherName.textAlignment = 0;
    _teacherName.sd_layout.leftSpaceToView(_userImageView, 5).topSpaceToView(_bgViewTwo, 8).rightSpaceToView(_bgViewTwo, 10).heightIs(20*MYWIDTH);
    
    _schoolTime = [[UILabel alloc]init];
    [_bgViewTwo addSubview:_schoolTime];
    NSString * date = [NSString convertToDateTimer:api.sendTime];
    _schoolTime.text = [NSString stringWithFormat:@"%@ %@",sendDic[@"school"],date];
    _schoolTime.textColor = kGrayColor;
    _schoolTime.font = FONT(12*MYWIDTH);
    _schoolTime.textAlignment = 0;
    _schoolTime.sd_layout.leftSpaceToView(_userImageView, 5).topSpaceToView(_teacherName, 0).rightSpaceToView(_bgViewTwo, 10).heightIs(20*MYWIDTH);
    
    _introduce = [[UILabel alloc]init];
    [_bgViewTwo addSubview:_introduce];
    _introduce.text = api.content;
    _introduce.textColor = kGrayColor;
    _introduce.font = FONT(13*MYWIDTH);
    _introduce.numberOfLines = 0;
    _introduce.textAlignment = 0;
    _introduce.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(ScreenWidth-20, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [_introduce sizeThatFits:maximumLabelSize];
    _labelSize = expectSize;
   //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    _introduce.sd_layout.leftSpaceToView(_bgViewTwo, 10).topSpaceToView(_userImageView, 3).widthIs(expectSize.width).heightIs(expectSize.height);
    UILabel * linee = [[UILabel alloc]init];
    [_bgViewTwo addSubview:linee];
    linee.backgroundColor = [UIColor groupTableViewBackgroundColor];
    linee.sd_layout.leftSpaceToView(_bgViewTwo, 0).rightSpaceToView(_bgViewTwo, 0).topSpaceToView(_introduce,8).heightIs(1);
    
    UIView * imageBG = [[UIView alloc]init];
    imageBG.backgroundColor = kWhiteColor;
    ViewRadius(imageBG, 8.f);
    [_bgViewTwo addSubview:imageBG];
    imageBG.sd_layout.leftSpaceToView(_bgViewTwo, 8).rightSpaceToView(_bgViewTwo, 8).topSpaceToView(linee,8).heightIs(100*MYWIDTH);
    
    int totalloc = 10;
    CGFloat imageVW = 20*MYWIDTH; //宽
    CGFloat imageVH = 20*MYWIDTH; //高
    CGFloat margin = 10*MYWIDTH; //间距
    int count =(int)_imageArr.count;
    for (int i=0;i<count;i++){
        int row =i/totalloc;  //行号
        int loc =i%totalloc;  //列号
        CGFloat imageVX =margin+(margin +imageVW)*loc; //x
        CGFloat imageVY =1*MYWIDTH+(margin +imageVH)*row; //y
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(imageVX, imageVY, imageVW, imageVH);
        [btn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_imageArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"123"]];
        [btn addTarget:self action:@selector(testaction) forControlEvents:UIControlEventTouchUpInside];
//        UIImageView *hdiamge = [[UIImageView alloc]initWithFrame:CGRectMake(imageVX, imageVY, imageVW, imageVH)];
//        [hdiamge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_imageArr[i]]] placeholderImage:[UIImage imageNamed:@"123"]];
        ViewRadius(btn, 10*MYWIDTH);
        [imageBG addSubview:btn];
        NSString * laststring = [NSString stringWithFormat:@"%@",_imageArr.lastObject];
        NSRange range = [laststring rangeOfString:@"赞"];
        if (range.length>0) {
            btn.titleLabel.font = FONT(10*MYWIDTH);
            [btn setTitle:_imageArr.lastObject forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    int row = count/totalloc+1;
    _bgViewTwo.sd_layout.leftSpaceToView(self.contrainerview, 6).rightSpaceToView(self.contrainerview, 6).topSpaceToView(_bgViewone,10).heightIs(50*MYWIDTH+_labelSize.height+row*45*MYWIDTH);
}
-(void)didTapBackButton{
    if (_zanBlock) {
        self.zanBlock(_pr);
    }
    [self.navigationController popViewControllerAnimated:YES];

}
@end
