//
//  JLActivityAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/29.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLActivityAPI.h"

@implementation JLActivityAPI
+(instancetype)getActivityListWithSource:(NSString *)source SchoolId:(NSString *)school_id Page:(NSString *)page{
    JLActivityAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:source forKey:@"source"];
    [parameter setObject:school_id forKey:@"school_id"];
    [parameter setObject:page forKey:@"page"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/huodong/index"];
    api.parameters = parameter;
    return api;
}
@end
