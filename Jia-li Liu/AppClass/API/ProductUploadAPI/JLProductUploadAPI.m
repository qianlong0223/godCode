//
//  JLProductUploadAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLProductUploadAPI.h"

@implementation JLProductUploadAPI
+(instancetype)uploadHeadImageWithBaseHeadImage:(NSString *)image TypeId:(NSString *)typeId Title:(NSString *)title Content:(NSString *)content{
    JLProductUploadAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:typeId forKey:@"typeId"];
    [parameter setObject:image forKey:@"image"];
    [parameter setObject:title forKey:@"title"];
    [parameter setObject:content forKey:@"content"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/person/save"];
    api.parameters = parameter;
    return api;
}
@end
