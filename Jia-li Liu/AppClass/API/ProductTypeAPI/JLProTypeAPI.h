//
//  JLProTypeAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/28.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN
@class typedata;
@interface JLProTypeAPI : JLBaseAPI
+(instancetype)getProductType;
@property (nonatomic, strong) NSArray<typedata *> *data;


@end
@interface typedata : NSObject

@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *name;
@end
NS_ASSUME_NONNULL_END
