//
//  JLMineProAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLMineProAPI.h"

@implementation JLMineProAPI
+(instancetype)getProListWithPage:(NSString *)page{
    JLMineProAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:page forKey:@"page"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/person/index"];
    api.parameters = parameter;
    return api;
}
@end
