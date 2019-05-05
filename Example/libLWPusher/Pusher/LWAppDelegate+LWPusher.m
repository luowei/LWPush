//
// Created by luowei on 2019/5/5.
// Copyright (c) 2019 luowei. All rights reserved.
//

#import "LWAppDelegate+LWPusher.h"
#import "XGPush.h"


@implementation LWAppDelegate (LWPusher)

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
    //向信息注册设备号
//    NSString *deviceTokenStr = [XGPush registerDevice:deviceToken account:nil successCallback:^{
//        PushLog(@"XGPush registerDevice:%@ account:%@  Success", deviceToken, nil);
//    }                                   errorCallback:^{
//        PushLog(@"XGPush registerDevice:%@ account:%@  Faild", deviceToken, nil);
//    }];
//    NSLog(@"[APSPush] device token is %@", deviceTokenStr);
}

//收到静默推送的回调
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
    //清除角标
    application.applicationIconBadgeNumber = 0;

    //处理推送消息
    [[LWPushManager shareManager] handRemotePushNotificationWithUserInfo:userInfo];

    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];    //上报数据
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
    if (error.code == 3010) {
        PushLog(@"iOS Simulator 不支持远程推送消息");
    } else {
        PushLog(@"application:didFailToRegisterForRemoteNotificationsWithError:%@", error.localizedFailureReason);
    }
}


//handleAction
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

//本地通知 Local Notification
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

//收到远程通知的回调,iOS10 废弃的方法 Deprecated Message
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
    //清除角标
    application.applicationIconBadgeNumber = 0;

    //处理推送消息
    [[LWPushManager shareManager] handRemotePushNotificationWithUserInfo:userInfo];

    //推送反馈XG
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];    //上报数据
}

//收到本地通知的回调
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
    //清除角标
    application.applicationIconBadgeNumber = 0;
}


@end