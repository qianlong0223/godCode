//
//  JLMidActivityAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class acDatas,acSender;
@interface JLMidActivityAPI : JLBaseAPI
+(instancetype)getMidActivityRecommend;
@property (nonatomic, strong) NSArray<acDatas *> *data;
@end
@interface acDatas : NSObject

@property (nonatomic, copy) NSString *activityId;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) acSender *sender;

@end
@interface acSender : NSObject

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, strong) NSString *name;
@end
NS_ASSUME_NONNULL_END
