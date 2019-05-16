//
//  JLMidActivityAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLMidActivityAPI.h"

@implementation JLMidActivityAPI
+(instancetype)getMidActivityRecommend{
    JLMidActivityAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/index/huodong"];
    api.parameters = parameter;
    return api;
}
@end
