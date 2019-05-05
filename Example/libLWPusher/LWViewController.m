//
//  LWViewController.m
//  libLWPusher
//
//  Created by luowei on 05/05/2019.
//  Copyright (c) 2019 luowei. All rights reserved.
//

#import "LWViewController.h"
#import "LWPushManager.h"

@interface LWViewController ()
@property(weak, nonatomic) IBOutlet UITextField *accountField;

@end

@implementation LWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bindAction:(UIButton *)sender {
    NSString *account = self.accountField.text ?: [@"test_user_" stringByAppendingFormat:@"%d",arc4random_uniform(1000)];
    [[LWPushManager shareManager] bindAccount:account];
    [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"kPushBindAccount"];

    PushLog(@"=========bindAccount:%@",account);
}

- (IBAction)unbindAction:(UIButton *)sender {
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:@"kPushBindAccount"];
    if(account.length > 0){
        [[LWPushManager shareManager] unbindAccount:account];
    }

    PushLog(@"=========unbindAccount:%@",account);
}

@end
