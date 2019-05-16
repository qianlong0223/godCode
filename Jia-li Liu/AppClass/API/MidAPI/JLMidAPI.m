//
//  JLMidAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLMidAPI.h"

@implementation JLMidAPI
+(instancetype)getMidHomeBannerWithSchoolId:(NSString *)school_id{
    JLMidAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:school_id forKey:@"school_id"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/index/banner"];
    api.parameters = parameter;
    return api;
}
@end
