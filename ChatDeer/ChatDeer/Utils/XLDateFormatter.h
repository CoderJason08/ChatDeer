//
//  XLDateFormatter.h
//  ChatDeer
//
//  Created by Jason on 16/4/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLDateFormatter : NSObject
// 根据默认规则返回对应的日期
+ (NSString *)dateWithTimeStamp:(NSTimeInterval)timeStamp;
+ (NSString *)dateWithTimeStamp:(NSTimeInterval)timeStamp dateFormate:(NSString *)dateFormate;
+ (NSString *)dateStrWithDate:(NSDate *)date;
@end
