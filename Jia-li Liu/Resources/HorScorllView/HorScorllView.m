//
//  HorScorllView.m
//  CustomView
//
//  Created by Arthur on 2017/10/18.
//  Copyright © 2017年 Arthur. All rights reserved.
//

#import "HorScorllView.h"


#define ImageButtonWidth [UIScreen mainScreen].bounds.size.width / 5

@interface HorScorllView ()

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation HorScorllView
{
    UIScrollView *scrollView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    for (int i = 0; i < 12; i++) {
        self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.imageButton.frame = CGRectMake(i * 150*MYWIDTH, 0, 150*MYWIDTH, 180*MYWIDTH);
        ViewRadius(self.imageButton, 10.f);
        [self.imageButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.imageButton.tag = i + 100;

        self.imageButton.transform = CGAffineTransformMakeScale(0.92, 0.92);
        [self.imageButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [self.imageButton setBackgroundImage:[UIImage imageNamed:@"bowang"] forState:UIControlStateNormal];
        [scrollView addSubview:self.imageButton];

    }
    scrollView.contentSize = CGSizeMake(ImageButtonWidth *12, self.frame.size.height);
}

- (void)setImages:(NSArray *)images {
    _images = images;

    for (int i = 0; i < _images.count; i ++) {
        UIButton *imageButton = (UIButton *)[self viewWithTag:i + 100];
        [imageButton sd_setImageWithURL:_images[i] forState:UIControlStateNormal];
    }
    
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    for (int i = 0; i < _titles.count; i ++) {
        UILabel *textLabel = [self viewWithTag:i + 200];
        textLabel.text = _titles[i];
    }
    
}

- (void)clickAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(horImageClickAction:)]) {
        [self.delegate horImageClickAction:button.tag];
    }
}




@end
