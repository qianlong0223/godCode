//
//  JLProductDetailVC.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/25.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "JLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLProductDetailVC : JLBaseViewController
@property(nonatomic,strong)void(^zanBlock)(NSString *);
@property (nonatomic,copy)NSString * paintId;
@property (nonatomic,copy)NSMutableArray * imageArr;
@end

NS_ASSUME_NONNULL_END
