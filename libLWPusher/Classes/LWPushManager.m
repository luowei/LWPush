//
// Created by Luo Wei on 2017/5/18.
// Copyright (c) 2017 luowei. All rights reserved.
//

#import "LWPushManager.h"
#import "XGPush.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

#import <UserNotifications/UserNotifications.h>

@interface LWPushManager () <UNUserNotificationCenterDelegate,XGPushDelegate,XGPushTokenManagerDelegate>
@end

#endif

@implementation LWPushManager {

}

+ (id)shareManager {
    static LWPushManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


-(void)xg_push_test{
    //启动信鸽推送服务
    [[XGPush defaultManager] startXGWithAppID:2200331850 appKey:@"IG6KRRX2857P" delegate:self];

    //打开debug开关
    [[XGPush defaultManager] setEnableDebug:YES];

    //在通知消息中创建一个可以点击的事件行为
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionForeground];

    //创建分类对象，用以管理通知栏的Action对象
    XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];

    //管理推送消息通知栏的样式和特性
    XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];

    //上报地理位置信息，后续可以使用信鸽针对位置进行精准推送
    [[XGPush defaultManager] reportLocationWithLatitude:20.0 longitude:19.0];

    //调用此接口上报当前 App 角标数到信鸽服务器,客户端配置完成即可使用「iOS角标自动加1」的功能
    [[XGPush defaultManager] setBadge:7];

    //管理 App 显示的角标数量
    // 设置应用角标
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    // 获取应用角标
    NSInteger number = [[XGPush defaultManager] xgApplicationBadgeNumber];

    //查询设备 Token
    NSString *token = [[XGPushTokenManager defaultTokenManager] deviceTokenString];


    //绑定标签：
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"your tag" type:XGPushTokenBindTypeTag];

    //解绑标签
    [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:@"your tag" type:XGPushTokenBindTypeTag];

    //绑定账号：
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"your account" type:XGPushTokenBindTypeAccount];

    //解绑账号：
    [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:@"your account" type:XGPushTokenBindTypeAccount];

    ////批量操作接口
    //- (void)bindWithIdentifiers:(nonnull NSArray <NSString *> *)identifiers type:(XGPushTokenBindType)type
    //- (void)unbindWithIdentifers:(nonnull NSArray <NSString *> *)identifiers type:(XGPushTokenBindType)type;

    ////批量更新标签/账号
    //- (void)updateBindedIdentifiers:(nonnull NSArray <NSString *> *)identifiers bindType:(XGPushTokenBindType)type;

    ////清除全部标签/账号
    //- (void)clearAllIdentifiers:(XGPushTokenBindType)type;

    ////查询绑定的标签和账号
    //// 查询标签
    //[[XGPushTokenManager defaultTokenManager] identifiersWithType:XGPushTokenBindTypeTag];
    //// 查询账号
    //[[XGPushTokenManager defaultTokenManager] identifiersWithType:XGPushTokenBindTypeAccount];

    ////查询设备通知权限是否被用户允许
    //[[XGPush defaultManager] deviceNotificationIsAllowed:^(BOOL isAllowed) {
    //    <#code#>
    //}];

    //查询 SDK 版本
    //[[XGPush defaultManager] sdkVersion];

}



#pragma mark - Custom Method

-(void)startXGPush{
    //启动信鸽推送服务
    [[XGPush defaultManager] startXGWithAppID:2200331850 appKey:@"IG6KRRX2857P" delegate:self];

//    [[XGPush defaultManager] deviceNotificationIsAllowed:^(BOOL isAllowed) {
//        if(!isAllowed){
//            //启动信鸽推送服务
//            [[XGPush defaultManager] startXGWithAppID:2200331850 appKey:@"IG6KRRX2857P" delegate:self];
//        }else{
//            //todo:已经开启了推送
//        }
//    }];
}

-(void)stopXGPush{
    //终止信鸽推送服务
    [[XGPush defaultManager] stopXGNotification];
}

-(void)bindAccount:(NSString *)account{
    [[XGPush defaultManager] deviceNotificationIsAllowed:^(BOOL isAllowed) {

        if(!isAllowed){
            [self startXGPush];
        }else{
            if(![XGPushTokenManager defaultTokenManager].delegate){
                [XGPushTokenManager defaultTokenManager].delegate = self;
            }
            //绑定账号：
            if(account.length > 0){
                [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:account type:XGPushTokenBindTypeAccount];
            }
        }

    }];
}

-(void)unbindAccount:(NSString *)account{
    if(![XGPushTokenManager defaultTokenManager].delegate){
        [XGPushTokenManager defaultTokenManager].delegate = self;
    }
    //解绑账号：
    if(account.length > 0){
        [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:account type:XGPushTokenBindTypeAccount];
    }
}

//程序启动时处理推送
- (void)handPushInApplicationDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //启动信鸽推送服务
    [[XGPush defaultManager] startXGWithAppID:2200331850 appKey:@"IG6KRRX2857P" delegate:self];
    // 设置应用角标
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
}

//处理推送消息
- (void)handRemotePushNotificationWithUserInfo:(NSDictionary *)userInfo {
    NSString *urlString = userInfo[@"url"];
    if(urlString){
        NSURL *url = [NSURL URLWithString:urlString];
        [self openURL:url];
    }

}


#pragma mark - UNUserNotificationCenterDelegate

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}
#endif


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_12_0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}
#endif



#pragma mark - XGPushDelegate

- (void)xgPushDidReceiveRemoteNotification:(nonnull id)notification withCompletionHandler:(nullable void (^)(NSUInteger))completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)xgPushUserNotificationCenter:(nonnull UNUserNotificationCenter *)center willPresentNotification:(nullable UNNotification *)notification withCompletionHandler:(nonnull void (^)(UNNotificationPresentationOptions options))completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo]; //上报数据
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

- (void)xgPushUserNotificationCenter:(nonnull UNUserNotificationCenter *)center didReceiveNotificationResponse:(nullable UNNotificationResponse *)response withCompletionHandler:(nonnull void (^)(void))completionHandler {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
    [[XGPush defaultManager] reportXGNotificationResponse:response]; //上报数据
    completionHandler();
}
#endif

- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(nullable NSError *)error {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(nullable NSError *)error {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}



- (void)xgPushDidReportNotification:(BOOL)isSuccess error:(nullable NSError *)error {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

- (void)xgPushDidSetBadge:(BOOL)isSuccess error:(nullable NSError *)error {
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

- (void)xgPushDidRegisteredDeviceToken:(nullable NSString *)deviceToken error:(nullable NSError *)error {
    //hook 了 didRegisterForRemoteNotificationsWithDeviceToken
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
    PushLog(@"======= device token is %@", deviceToken);
}


#pragma mark - XGPushTokenManagerDelegate Implement

- (void)xgPushDidBindWithIdentifier:(nonnull NSString *)identifier type:(XGPushTokenBindType)type error:(nullable NSError *)error{
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}

- (void)xgPushDidUnbindWithIdentifier:(nonnull NSString *)identifier type:(XGPushTokenBindType)type error:(nullable NSError *)error{
    PushLog(@"--------%d:%s \n\n", __LINE__, __func__);
}


#pragma mark - Private Method


- (void)openURL:(NSURL *)url {
    if (@available(iOS 10.0,*)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
}


@end



