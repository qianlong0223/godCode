//
//  ProductCell.h
//  Jia-li Liu
//
//  Created by jdlx on 2018/12/24.
//  Copyright © 2018 KLIANS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductCell : UICollectionViewCell
@property (nonatomic,strong)void(^zanBtnBlcok)();
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIButton *zanBtn;
@property (strong, nonatomic) UILabel *count;
@property (nonatomic,strong)NSDictionary * dic;

@end

NS_ASSUME_NONNULL_END
