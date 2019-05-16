//
//  JLProductClickMemberAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/3.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLProductClickMemberAPI : JLBaseAPI
+(instancetype)getProductDetailClickMemberWithPaintingId:(NSString *)paintingId;
@property (nonatomic, strong) NSArray *data;

@end

NS_ASSUME_NONNULL_END
