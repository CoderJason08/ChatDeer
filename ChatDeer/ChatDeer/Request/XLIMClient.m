//
//  XLIMClient.m
//  ChatDeer
//
//  Created by jhwy on 16/4/5.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "XLIMClient.h"

NSString *const XLIMClientUpdateConversationsNotification = @"XLIMClientUpdateConversationsNotification";

@interface XLIMClient ()
@end

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
    AVIMClient *client = [[self sharedClient] initWithClientId:clientId];
    [client openWithCallback:^(BOOL succeeded, NSError *error) {
        AVIMConversationQuery *query = [client conversationQuery];
        [query whereKey:@"m" containsAllObjectsInArray:@[clientId]];
        [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
            callBack(succeeded,error);
            [[XLIMClient sharedClient] setConversations:objects.mutableCopy];
            [[NSNotificationCenter defaultCenter] postNotificationName:XLIMClientUpdateConversationsNotification object:nil];
        }];
    }];
}

@end
