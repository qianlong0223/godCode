//
//  JLMessageListAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/4.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class messageList;
@interface JLMessageListAPI : JLBaseAPI
+(instancetype)getMessageListWithSchoolId:(NSString *)school_id Page:(NSString *)page;
@property (nonatomic, assign) NSString *totalPage;

@property (nonatomic, strong) NSArray<messageList *> *list;

@end

@interface messageList : NSObject

@property (nonatomic, copy) NSString *noticeId;

@property (nonatomic, strong) NSString *jianjie;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *sendTime;

@property (nonatomic, strong) NSString *read;

@end
NS_ASSUME_NONNULL_END
