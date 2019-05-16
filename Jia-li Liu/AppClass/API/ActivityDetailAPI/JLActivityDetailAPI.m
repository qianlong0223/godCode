//
//  JLActivityDetailAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLActivityDetailAPI.h"

@implementation JLActivityDetailAPI
+(instancetype)getActivityDetailWithActivityId:(NSString *)activityId{
    JLActivityDetailAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:activityId forKey:@"activityId"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/huodong/info"];
    api.parameters = parameter;
    return api;
}
@end
