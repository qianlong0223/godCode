//
//  DefaultView.m
//  PlaceHolderView
//
//  Created by yh on 17/5/16.
//  Copyright © 2017年 yh. All rights reserved.
//

#import "DefaultView.h"

@implementation DefaultView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        imageView.image = [UIImage imageNamed:@"空白页"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.center = self.center;
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无内容";
        label.center = CGPointMake(self.center.x, self.center.y+120);
        [self addSubview:label];
    }
    return self;
}

@end
