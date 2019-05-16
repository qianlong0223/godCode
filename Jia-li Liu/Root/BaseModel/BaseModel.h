//
//  BaseModel.h
//  Polycloudbeauty
//
//  Created by jdlx on 2017/12/4.
//  Copyright © 2017年 jdlx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject



-(id)initWithDictionary:(NSDictionary*)dic;
-(void)setAttributes:(NSDictionary*)dic;



@property (nonatomic,copy) NSDictionary*map;


- (NSString *)getSourceRegexString:(NSString *)sourceString;




@end
