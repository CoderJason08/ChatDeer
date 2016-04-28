//
//  XLDateFormatter.m
//  ChatDeer
//
//  Created by Jason on 16/4/3.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLDateFormatter.h"

@implementation XLDateFormatter

+ (NSDateFormatter *)sharedDateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
    });
    return dateFormatter;
}

+ (NSString *)dateWithTimeStamp:(NSTimeInterval)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp / 1000];
    NSDateFormatter *formatter = [self sharedDateFormatter];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *today = [NSDate date];
    NSString *result;
    NSTimeInterval totalSecondByDay = 60 * 60 * 24;
    NSTimeInterval timeDifference = [today timeIntervalSinceDate:date];
    NSString *dayStr = [formatter stringFromDate:date];
    NSString *todayStr = [formatter stringFromDate:today];
    if ([dayStr isEqualToString:todayStr]) {
        /** HH:mm */
        formatter.dateFormat = @"HH:mm";
        result = [formatter stringFromDate:date];
    }else if (timeDifference <= 2 * totalSecondByDay) {
        /** 昨天 */
        result = @"昨天";
    }else if (timeDifference <= 7 * totalSecondByDay) {
        /** 星期X */
        formatter.dateFormat = @"EEEE";
        result = [formatter stringFromDate:date];
    }else {
        /** yyyy-MM-dd */
        formatter.dateFormat = @"yyyy-MM-dd";
        result = [formatter stringFromDate:date];
    }
    return result;
}

+ (NSString *)dateWithTimeStamp:(NSTimeInterval)timeStamp dateFormate:(NSString *)dateFormate {
    if (dateFormate.length == 0) {
        NSLog(@"日期格式化字符串非法");
        return nil;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp / 1000];
    NSDateFormatter *formatter = [self sharedDateFormatter];
    formatter.dateFormat = dateFormate;
    return [formatter stringFromDate:date];
}
@end
