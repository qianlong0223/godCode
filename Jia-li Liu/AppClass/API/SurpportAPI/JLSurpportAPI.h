//
//  JLSurpportAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/5.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLSurpportAPI : JLBaseAPI
+(instancetype)commitSurpportWithContent:(NSString *)content image:(NSString *)image;
@end

NS_ASSUME_NONNULL_END
