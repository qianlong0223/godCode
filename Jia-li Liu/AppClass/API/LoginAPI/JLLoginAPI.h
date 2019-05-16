//
//  JLLoginAPI.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLLoginAPI : JLBaseAPI
+(instancetype)getLoginInfoWithUserPhone:(NSString *)phone Password:(NSString *)password;
@property (nonatomic, assign) NSString *userId;

@property (nonatomic, assign) NSString *sessionId;

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *studentId;

@property (nonatomic, copy) NSString *schoolId;

@property (nonatomic, copy) NSString *schoolName;

@property (nonatomic, copy) NSString *classId;

@property (nonatomic, copy) NSString *className;

@end

NS_ASSUME_NONNULL_END
