//
//  JLPraiseAPl.m
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLPraiseAPl.h"

@implementation JLPraiseAPl
+(instancetype)getProListWithPaintingId:(NSString *)paintingId SchoolId:(NSString *)school_id{
    JLPraiseAPl *api = [self new];
    NSMutableDictionary * parameter = [BoolJudge configPublicParameter];
    [parameter setObject:paintingId forKey:@"paintingId"];
    [parameter setObject:school_id forKey:@"school_id"];
    api.subUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/app/zuopin/click"];
    api.parameters = parameter;
    return api;
}
@end
