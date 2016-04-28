//
//  XLIMClient.h
//  ChatDeer
//
//  Created by jhwy on 16/4/5.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <AVOSCloudIM/AVOSCloudIM.h>

extern NSString *const XLIMClientUpdateConversationsNotification;

@interface XLIMClient : AVIMClient
@property (nonatomic, strong) NSMutableArray *conversations;

+ (instancetype)sharedClient;
/** 配置会话信息 */
+ (void)confirmIMClientWithClientId:(NSString *)clientId openCallBack:(void(^)(BOOL isSucceed, NSError *error))callBack;
@end
