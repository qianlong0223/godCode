//
//  ZJImageMagnification.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/14.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJImageMagnification : NSObject
/**
 *  浏览大图
 *
 *  @param currentImageview 当前图片
 *  @param alpha            背景透明度
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
