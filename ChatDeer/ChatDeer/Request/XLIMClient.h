//
//  XLIMClient.h
//  ChatDeer
//
//  Created by jhwy on 16/4/5.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <AVOSCloudIM/AVOSCloudIM.h>

@interface XLIMClient : AVIMClient
+ (instancetype)sharedClient;
+ (void)confirmIMClientWithClientId:(NSString *)clientId openCallBack:(void(^)(BOOL isSucceed, NSError *error))callBack;
@end
