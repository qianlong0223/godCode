//
//  JLUploadHeadAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLUploadHeadAPI.h"

@implementation JLUploadHeadAPI
+(instancetype)uploadHeadImageWithBaseHeadImage:(NSString *)headImage{
    JLUploadHeadAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:headImage forKey:@"headImage"];
    NSString * url = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/person/saveimg"];
    api.subUrl = url;
    api.parameters = parameter;
    return api;
}
@end
