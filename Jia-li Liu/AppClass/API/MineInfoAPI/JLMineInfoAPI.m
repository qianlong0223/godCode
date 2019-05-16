//
//  JLMineInfoAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLMineInfoAPI.h"

@implementation JLMineInfoAPI
+(instancetype)getMineInfo{
    JLMineInfoAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/person/info_user"];
    api.parameters = parameter;
    return api;
}
@end
