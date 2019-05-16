//
//  JLProductDetailAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2019/1/2.
//  Copyright © 2019 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class productDetailSender;
@interface JLProductDetailAPI : JLBaseAPI
+(instancetype)getProductDetailWithPaintingId:(NSString *)paintingId;
@property (nonatomic, assign) NSString *paintingId;

@property (nonatomic, assign) NSString *source;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *sendTime;

@property (nonatomic, copy) NSString *praiseNum;

@property (nonatomic, copy) NSString *myPraise;

@property (nonatomic, copy) productDetailSender *sender;

@end
@interface productDetailSender : NSObject

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *school;
@end


NS_ASSUME_NONNULL_END
