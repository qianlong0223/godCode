//
//  JLMidAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class data;
@interface JLMidAPI : JLBaseAPI
+(instancetype)getMidHomeBannerWithSchoolId:(NSString *)school_id;
@property (nonatomic, strong) NSArray<data *> *data;

@end
@interface data : NSObject

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, assign) NSString *data;
@end
NS_ASSUME_NONNULL_END
