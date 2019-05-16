//
//  JLProductClickMemberAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/3.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLProductClickMemberAPI.h"

@implementation JLProductClickMemberAPI
+(instancetype)getProductDetailClickMemberWithPaintingId:(NSString *)paintingId{
    JLProductClickMemberAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:paintingId forKey:@"paintingId"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/zuopin/clickmember"];
    api.parameters = parameter;
    return api;
}
@end
