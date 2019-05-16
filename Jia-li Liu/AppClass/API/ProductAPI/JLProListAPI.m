//
//  JLProListAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLProListAPI.h"

@implementation JLProListAPI
+(instancetype)getProListWithSource:(NSString *)source SchoolId:(NSString *)school_id Page:(NSString *)page{
    JLProListAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:source forKey:@"source"];
    [parameter setObject:school_id forKey:@"school_id"];
    [parameter setObject:page forKey:@"page"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/zuopin/index"];
    api.parameters = parameter;
    return api;
}
@end
