//
//  XLIMClient.m
//  ChatDeer
//
//  Created by jhwy on 16/4/5.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLIMClient.h"

@implementation XLIMClient
+ (instancetype)sharedClient {
    static XLIMClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [self new];
    });
    return client;
}

+ (void)confirmIMClientWithClientId:(NSString *)clientId openCallBack:(void (^)(BOOL, NSError *))callBack {
    [[[self sharedClient] initWithClientId:clientId] openWithCallback:callBack];
}

@end
