//
//  JLUpdatePswAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLUpdatePswAPI : JLBaseAPI
+(instancetype)updatePasswordWithOldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword;
@end

NS_ASSUME_NONNULL_END
