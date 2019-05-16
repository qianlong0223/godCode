//
//  JLExpandAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLExpandAPI.h"

@implementation JLExpandAPI
+(instancetype)getExpandListWithBanji_id:(NSString *)banji_id Page:(NSString *)page{
    JLExpandAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:page forKey:@"page"];
    [parameter setObject:banji_id forKey:@"banjiid"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/tuozhan/index"];
    api.parameters = parameter;
    return api;
}
@end
