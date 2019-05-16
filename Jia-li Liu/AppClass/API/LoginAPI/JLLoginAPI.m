//
//  JLLoginAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLLoginAPI.h"

@implementation JLLoginAPI
+(instancetype)getLoginInfoWithUserPhone:(NSString *)phone Password:(NSString *)password{
    
    JLLoginAPI *api = [self new];
   NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:phone forKey:@"phone"];
    [parameter setObject:password forKey:@"password"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/login/login"];
    api.parameters = parameter;
    return api;
}
@end
