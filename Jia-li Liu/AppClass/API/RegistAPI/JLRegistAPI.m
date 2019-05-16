//
//  JLRegistAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLRegistAPI.h"

@implementation JLRegistAPI
+(instancetype)getRegistInfoWithUserPhone:(NSString *)phone Password:(NSString *)password ParentsName:(NSString *)parentsName ActivationCode:(NSString *)activationCode{
    JLRegistAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:phone forKey:@"phone"];
    [parameter setObject:password forKey:@"password"];
    [parameter setObject:parentsName forKey:@"parentsName"];
    [parameter setObject:activationCode forKey:@"activationCode"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/login/reg"];
    api.parameters = parameter;
    return api;
}
@end
