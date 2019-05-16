//
//  JLMidHotProcutAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class datas;
@interface JLMidHotProcutAPI : JLBaseAPI
+(instancetype)getMidHotProduct;
@property (nonatomic, strong) NSArray<datas *> *data;

@end

@interface datas : NSObject

@property (nonatomic, copy) NSString *paintingId;

@property (nonatomic, strong) NSString *image;

@end

NS_ASSUME_NONNULL_END
