//
//  JLSurpportAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/5.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLSurpportAPI.h"

@implementation JLSurpportAPI
+(instancetype)commitSurpportWithContent:(NSString *)content image:(NSString *)image{
    JLSurpportAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:image forKey:@"image"];
    [parameter setObject:content forKey:@"content"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/config/index"];
    api.parameters = parameter;
    return api;
}
@end
