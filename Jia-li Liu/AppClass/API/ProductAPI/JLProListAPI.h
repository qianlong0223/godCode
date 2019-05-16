//
//  JLProListAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class proList,proSender;
@interface JLProListAPI : JLBaseAPI
+(instancetype)getProListWithSource:(NSString *)source SchoolId:(NSString *)school_id Page:(NSString *)page;
@property (nonatomic, assign) NSString *totalPage;

@property (nonatomic, strong) NSArray<proList *> *list;

@end
@interface proList : NSObject

@property (nonatomic, copy) NSString *paintingId;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *praiseNum;

@property (nonatomic, strong) NSString *myPraise;

@property (nonatomic, strong) proSender *sender;

@end
@interface proSender : NSObject

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *school;

@end
NS_ASSUME_NONNULL_END
