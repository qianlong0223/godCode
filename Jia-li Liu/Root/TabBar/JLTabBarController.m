//
//  JLTabBarController.m
//  KLIANS
//
//  Created by KLIANS  bo on 16/5/28.
//  Copyright © 2016年 KLIANS  bo. All rights reserved.
//

#import "JLTabBarController.h"

#import "JLTabBar.h"
#import "UIImage+Image.h"
#import "MidVC.h"
#import "JLProductVC.h"
#import "JLSquareVC.h"
#import "JLActivityVC.h"
#import "JLMineVC.h"
#import "JLPublishVC.h"

@interface JLTabBarController ()<JLTabBarDelegate>

@end

@implementation JLTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [UITabBar appearance].translucent = NO;
    [self setUpAllChildVc];

//    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
//    JLTabBar *tabbar = [[JLTabBar alloc] init];
//    tabbar.myDelegate = self;
//    //kvc实质是修改了系统的_tabBar
//    [self setValue:tabbar forKeyPath:@"tabBar"];


}


#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{


    JLProductVC *HomeVC = [[JLProductVC alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"zuopin_normal" selectedImage:@"zuopin_highlight" title:@"作品"];

    JLSquareVC *FishVC = [[JLSquareVC alloc] init];
    [self setUpOneChildVcWithVc:FishVC Image:@"tuozhan_normal" selectedImage:@"tuozhan_highlight" title:@"拓展"];
    
    MidVC *midVc = [[MidVC alloc] init];
    JTNavigationController *nav = [[JTNavigationController alloc] initWithRootViewController:midVc];
    UIImage *myImage = [UIImage imageNamed:@"主页"];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    midVc.tabBarItem.image = myImage;
//    UIImage *mySelectedImage = [UIImage imageNamed:@"message_highlight"];
//    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    midVc.tabBarItem.selectedImage = mySelectedImage;
    midVc.tabBarItem.title = @"";
    midVc.navigationItem.title = @"";
   
    midVc.tabBarItem.imageInsets = UIEdgeInsetsMake(10*MYWIDTH, 0, -10*MYWIDTH, 0);
    [self addChildViewController:nav];
    
    JLActivityVC *ss = [[JLActivityVC alloc] init];
    [self setUpOneChildVcWithVc:ss Image:@"huodong_normal" selectedImage:@"huodong_highlight" title:@"活动"];

    JLMineVC *MineVC = [[JLMineVC alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"my_normal" selectedImage:@"my_highlight" title:@"我的"];
    self.selectedIndex = 2;

}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    JTNavigationController *nav = [[JTNavigationController alloc] initWithRootViewController:Vc];
    //Vc.view.backgroundColor = [self randomColor];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;

    Vc.navigationItem.title = title;
    
    
    [self addChildViewController:nav];
    
}



#pragma mark - ------------------------------------------------------------------
#pragma mark - JLTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(JLTabBar *)tabBar
{
//    JLPublishVC *plusVC = [[JLPublishVC alloc] init];
//
//    JTNavigationController *navVc = [[JTNavigationController alloc] initWithRootViewController:plusVC];
//    [self presentViewController:navVc animated:YES completion:nil];
    MidVC * midvc = [[MidVC alloc]init];
    JTNavigationController * nav = [[JTNavigationController alloc]initWithRootViewController:midvc];
    
    
    [self presentViewController:nav animated:YES completion:nil];

}

//随机生成颜色
- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];

}

@end
