//
//  JLPraiseAPl.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLPraiseAPl : JLBaseAPI
+(instancetype)getProListWithPaintingId:(NSString *)paintingId SchoolId:(NSString *)school_id;
@property (nonatomic, assign) NSString *state;
@end

NS_ASSUME_NONNULL_END
