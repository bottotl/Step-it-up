//
//  NSObject+Common.h
//  Step-it-up
//
//  Created by syfll on 15/8/2.
//  Copyright © 2015年 JFT0M. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName;
//创建缓存文件夹
+ (BOOL) createDirInCache:(NSString *)dirName;
@end
