//
//  PopupsView.h
//  Popups
//
//  Created by Arthur on 2018/5/30.
//  Copyright © 2018年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^CancelBlock)(NSString *imageName);

@interface PopupsViewBlock : UIView


@property (nonatomic, strong) void(^block)(NSString *,NSString *);
@property (nonatomic, strong) void(^selectItemBlock)(NSString *,NSString *,NSString *,NSMutableArray *);
- (instancetype)initWithItemArr:(NSArray *)itemArr;

- (void)showView;

-(void)dismissAlertView;

@end
