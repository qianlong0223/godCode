//
//  JLActivityDetailAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class activityDetailSender;
@interface JLActivityDetailAPI : JLBaseAPI
+(instancetype)getActivityDetailWithActivityId:(NSString *)activityId;
@property (nonatomic, assign) NSString *activityId;

@property (nonatomic, assign) NSString *contactName;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *sendTime;

@property (nonatomic, copy) NSString *contactNumber;

@property (nonatomic, copy) NSString *registrationEmail;

@property (nonatomic, copy) NSString *registrationTime;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *result;

@property (nonatomic, copy) NSString *registrationNumber;

@property (nonatomic, copy) activityDetailSender *sender;
@end
@interface activityDetailSender : NSObject

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, strong) NSString *name;

@end
NS_ASSUME_NONNULL_END
