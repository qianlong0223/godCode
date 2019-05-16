//
//  JLProTypeAPI.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLProTypeAPI.h"

@implementation JLProTypeAPI
+(instancetype)getProductType{
    JLProTypeAPI *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/zuopin/fenlei"];
    api.parameters = parameter;
    return api;
}
@end
