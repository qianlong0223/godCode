//
//  JLProListModel.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/26.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLProListModel : BaseModel
@property (nonatomic, copy) NSString *totalPage;
@property (nonatomic, copy) NSMutableArray *list;
@end
@interface PsModel : BaseModel
@property(nonatomic,strong)NSString *paintingId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *praiseNum;
@property(nonatomic,strong)NSDictionary *sender;
@end
@interface SenderModel : BaseModel
@property(nonatomic,strong)NSString *headImage;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *school;
@end
NS_ASSUME_NONNULL_END
