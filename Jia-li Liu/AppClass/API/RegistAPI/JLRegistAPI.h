//
//  JLRegistAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLRegistAPI : JLBaseAPI
+(instancetype)getRegistInfoWithUserPhone:(NSString *)phone Password:(NSString *)password ParentsName:(NSString *)parentsName ActivationCode:(NSString *)activationCode;
@property (nonatomic, assign) NSString *code;

@property (nonatomic, assign) NSString *data;


@end

NS_ASSUME_NONNULL_END
