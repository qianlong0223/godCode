//
//  JLUpdatePswAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLUpdatePswAPI.h"

@implementation JLUpdatePswAPI
+(instancetype)updatePasswordWithOldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword{
    JLUpdatePswAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:oldPassword forKey:@"oldPassword"];
    [parameter setObject:newPassword forKey:@"newPassword"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/person/uppassword"];
    api.parameters = parameter;
    return api;
}
@end
