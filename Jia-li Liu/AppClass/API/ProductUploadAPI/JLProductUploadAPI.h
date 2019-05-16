//
//  JLProductUploadAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLProductUploadAPI : JLBaseAPI
+(instancetype)uploadHeadImageWithBaseHeadImage:(NSString *)image TypeId:(NSString *)typeId Title:(NSString *)title Content:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
