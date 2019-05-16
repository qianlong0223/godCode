//
//  UITabBar+badge.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/10.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
