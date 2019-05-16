//
//  JLProductDetailAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLProductDetailAPI.h"

@implementation JLProductDetailAPI
+(instancetype)getProductDetailWithPaintingId:(NSString *)paintingId{
    JLProductDetailAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:paintingId forKey:@"paintingId"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/zuopin/info"];
    api.parameters = parameter;
    return api;
}
@end
