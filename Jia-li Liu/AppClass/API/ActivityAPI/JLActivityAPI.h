//
//  JLActivityAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/29.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class activityList,activitySender;
@interface JLActivityAPI : JLBaseAPI
+(instancetype)getActivityListWithSource:(NSString *)source SchoolId:(NSString *)school_id Page:(NSString *)page;
@property (nonatomic, assign) NSString *totalPage;

@property (nonatomic, strong) NSArray<activityList *> *list;
@end
@interface activityList : NSObject

@property (nonatomic, copy) NSString *activityId;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *sendTime;

@property (nonatomic, strong) proSender *sender;


@end
@interface activitySender : NSObject

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, strong) NSString *name;


@end
NS_ASSUME_NONNULL_END
