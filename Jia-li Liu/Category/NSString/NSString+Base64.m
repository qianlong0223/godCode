//
//  NSString+Base64.m
//  emeixian
//
//  Created by liyameng on 16/3/7.
//  Copyright © 2016年 美鲜冻品商城. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)

+ (NSString *)base64String:(UIImage *)image {


    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    float length = (float)(data.length)/1024/1024;
    
    
    if (length > 2.0) {
        NSData *datas = UIImageJPEGRepresentation(image, 0.5f);
        float length  = (datas.length)/1024/1024;
        if (length > 2.0) {
            NSData *datass = UIImageJPEGRepresentation(image, 0.3f);
            NSString *encodedImageStr = [datass base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            return encodedImageStr;
        }else{
         NSString *encodedImageStr = [datas base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        return encodedImageStr;
        }
    }else{
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    return encodedImageStr;
    }
}



@end
