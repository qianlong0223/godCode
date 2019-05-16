//
//  JLMineProAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"
@class mineProList;
NS_ASSUME_NONNULL_BEGIN

@interface JLMineProAPI : JLBaseAPI
+(instancetype)getProListWithPage:(NSString *)page;
@property (nonatomic, assign) NSString *totalPage;

@property (nonatomic, strong) NSArray<mineProList *> *list;
@end
@interface mineProList : NSObject

@property (nonatomic, copy) NSString *paintingId;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *praiseNum;

@property (nonatomic, strong) NSString *myPraise;

@property (nonatomic, strong) NSString *status;
@end
NS_ASSUME_NONNULL_END
