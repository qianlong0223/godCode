//
//  JLMineInfoAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLMineInfoAPI : JLBaseAPI
+(instancetype)getMineInfo;
@property (nonatomic, copy) NSString *data;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *type;
@end

NS_ASSUME_NONNULL_END
