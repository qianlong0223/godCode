//
//  ServiceCell.m
//  carEnergy
//
//  Created by qc on 2017/4/6.
//  Copyright © 2017年 新能源. All rights reserved.
//

#import "ServiceCell.h"

@implementation ServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
//        [self.contentView addSubview:_iconImageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17.0f];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}

@end
