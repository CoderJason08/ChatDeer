//
//  APIConstants.h
//  MyV2EX
//
//  Created by 格式化油条 on 15/12/27.
//  Copyright © 2015年 XQBoy. All rights reserved.
//


#define DEBUG_HTTP NO
#define DEBUG_ANALYTICS NO

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define debugLog(...)
#define debugMethod()
#define NSLog(...)
#endif

