//
//  JLHomeWorkAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"
@class homeWorkList,homeWorkSender;
NS_ASSUME_NONNULL_BEGIN

@interface JLHomeWorkAPI : JLBaseAPI
+(instancetype)getHomeWorkListWithBanji_id:(NSString *)banji_id Page:(NSString *)page;
@property (nonatomic, assign) NSString *totalPage;

@property (nonatomic, strong) NSArray<homeWorkList *> *list;
@end
@interface homeWorkList : NSObject

@property (nonatomic, copy) NSString *homeworkId;

@property (nonatomic, strong) NSString *sendTime;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *read;

@property (nonatomic, strong) homeWorkSender *sender;

@end
@interface homeWorkSender : NSObject

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, strong) NSString *name;

@end
NS_ASSUME_NONNULL_END
