//
//  JLMessageListAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLMessageListAPI.h"

@implementation JLMessageListAPI
+(instancetype)getMessageListWithSchoolId:(NSString *)school_id Page:(NSString *)page{
    JLMessageListAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:school_id forKey:@"school_id"];
    [parameter setObject:page forKey:@"page"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/news/index"];
    api.parameters = parameter;
    return api;
}
@end
