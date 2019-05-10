//
// Created by Luo Wei on 2017/5/18.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define PushLog(fmt, ...) NSLog((@"%s [Line %d]\n" fmt @"\n\n\n"), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define PushLog(...)
#endif

@interface LWPushManager : NSObject

@property(nonatomic) uint32_t appID;

@property(nonatomic, copy) NSString *appKey;

+ (instancetype)shareManager;

-(instancetype)configAppID:(uint32_t)appID appKey:(NSString *)appKey;

-(void)startXGPush;
-(void)stopXGPush;
-(void)bindAccount:(NSString *)account;
-(void)unbindAccount:(NSString *)account;

//程序启动时处理推送
- (void)handPushInApplicationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

//处理推送消息
-(void)handRemotePushNotificationWithUserInfo:(NSDictionary *)userInfo;

@end
