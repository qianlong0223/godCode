//
//  JLExpandAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class expandList,expandSender;
@interface JLExpandAPI : JLBaseAPI
+(instancetype)getExpandListWithBanji_id:(NSString *)banji_id Page:(NSString *)page;
@property (nonatomic, assign) NSString *totalPage;

@property (nonatomic, strong) NSArray<expandList *> *list;
@end
@interface expandList : NSObject

@property (nonatomic, copy) NSString *expansionId;

@property (nonatomic, strong) NSString *sendTime;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *read;

@property (nonatomic, strong) expandSender *sender;

@end
@interface expandSender : NSObject

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, strong) NSString *name;

@end
NS_ASSUME_NONNULL_END
