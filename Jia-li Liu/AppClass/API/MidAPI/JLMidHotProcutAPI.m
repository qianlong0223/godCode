//
//  JLMidHotProcutAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLMidHotProcutAPI.h"

@implementation JLMidHotProcutAPI
+(instancetype)getMidHotProduct{
    JLMidHotProcutAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
//http://demo201.jiudianlianxian.com/app/index/zuopin
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/index/zuopin"];
    api.parameters = parameter;
    return api;
}
@end
