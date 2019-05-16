//
//  BaseModel.m
//  Polycloudbeauty
//
//  Created by jdlx on 2017/12/4.
//  Copyright © 2017年 jdlx. All rights reserved.
//

#import "BaseModel.h"
/*
 1.设置key和属性名相同的变量
 2.拼接各个属性的 set方法名
 3.将字符串转换成方法 获得各个属性的set 方法
 4.判断是否相应此方法
 5.设置特殊属性名的set方法名 设置key和属性名不同的变量
 */
@implementation BaseModel



/*
 需要的所有的值都是字典中的元素  在此处传入字典来获取字典中的元素
 */
-(id)initWithDictionary:(NSDictionary*)dic{
    
    if (self = [super init]) {
        
        [self setAttributes:dic];
        
    }
    
    return self;
    
}


//为model中的属性赋值的方法 --> 设置set方法
-(void)setAttributes:(NSDictionary*)dic{
    
    //1.设置key和属性名相同的变量
    //将字典中的数据取出填充至model对象上
    for (NSString *key in dic) {
        
        //2.拼接各个属性的 set方法名
        NSString *a = [[key substringToIndex:1] uppercaseString];
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:",a,[key substringFromIndex:1]];
        
        //3.将字符串转换成方法 获得各个属性的set 方法
        SEL method = NSSelectorFromString(methodName);
        
        //4.判断是否相应此方法
        if ([self respondsToSelector:method]) {
            
            //一些非线程调用（NSObject的Category方法）即在当前线程执行，注意它们会阻塞当前线程（包括UI线程）：
            //            [self performSelector:method withObject:[dic objectForKey:key]];
            [self performSelectorOnMainThread:method
                                   withObject:[dic objectForKey:key]
                                waitUntilDone:[NSThread isMainThread]];
        }
    }
    
    
    //5.设置特殊属性名的set方法名 设置key和属性名不同的变量
    for (NSString*key in _map) {
        
        //        NSString*methodName = [_map objectForKey:key];
        
        NSString *value = [_map objectForKey:key];
        //拼接各个属性的 set方法名
        NSString *a = [[value substringToIndex:1] uppercaseString];
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:",a,[value substringFromIndex:1]];
        
        //3.将字符串转换成方法 获得各个属性的set 方法
        SEL method = NSSelectorFromString(methodName);
        
        
        if ([self respondsToSelector:method]) {
            
            //            [self performSelector:method withObject:[dic objectForKey:key]];
            /*
             [self performSelectorOnMainThread:<#(SEL)#> withObject:<#(id)#> waitUntilDone:<#(BOOL)#>]
             在主线程中运行方法，wait表示是否阻塞这个方法的调用，如果为YES则等待主线程中运行方法结束。一般可用于在子线程中调用UI方法。
             */
            [self performSelectorOnMainThread:method withObject:[dic objectForKey:key] waitUntilDone:[NSThread isMainThread]];
        }
    }
}


- (NSString *)getSourceRegexString:(NSString *)sourceString {
    
    // <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    
    //0.被解析的数据:sourceString
    
    if (sourceString.length > 0) {
        
        //1.命名一个解析规则
        NSString *regex = @">.+<";
        //2.初始化一个解析类
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
        
        //3.对字符串进行解析,@[NSTextCheckingResult,NSTextCheckingResult]
        NSArray *items = [regular matchesInString:sourceString options:NSMatchingReportProgress range:NSMakeRange(0, sourceString.length)];
        
        //NSTextCheckingResult:符合规则的字符串  在原始字符串中的位置属性
        for (NSTextCheckingResult *result in items) {
            
            NSRange range = result.range;
            
            range.location += 1;
            range.length -= 2;
            NSString *souceText = [sourceString substringWithRange:range];
            
            return souceText;
        }
        
    }
    
    return nil;
    
}








@end
