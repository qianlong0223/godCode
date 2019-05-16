//
//  JLHomeWorkAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLHomeWorkAPI.h"

@implementation JLHomeWorkAPI
+(instancetype)getHomeWorkListWithBanji_id:(NSString *)banji_id Page:(NSString *)page{
    JLHomeWorkAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:banji_id forKey:@"banjiid"];
    [parameter setObject:page forKey:@"page"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/zuoye/index"];
    api.parameters = parameter;
    return api;
}
@end
