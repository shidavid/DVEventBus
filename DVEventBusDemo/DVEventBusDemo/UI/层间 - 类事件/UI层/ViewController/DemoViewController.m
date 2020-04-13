//
//  DemoViewController.m
//  DVEventBusDemo
//
//  Created by mlgPro on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoService.h"
#import "DemoOtherService.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 注册类事件，一般在APP启动时注册
    [DVEventSubscriber registerClassEvents:[DemoService class]];
    [DVEventSubscriber registerClassEvents:[DemoOtherService class]];
}


#pragma mark - <-- ACTION -->
- (IBAction)onClickForLogin:(UIButton *)sender {
    // 发送类事件 kEVENT_SERVICE_DEMO_LOGIN
    void(^success)(BOOL) = ^(BOOL status) {
        NSLog(@"[DemoViewController LOG]: status -> %@", status ? @"YES" : @"NO");
    };
    NSLog(@"发送 kEVENT_SERVICE_DEMO_LOGIN");
    [DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_LOGIN params:@"Hello", @"654321", success, nil];
}

- (IBAction)onClickForAdd:(UIButton *)sender {
    NSNumber *ret = [DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_ADD params:@(1), @(2), nil];
    NSLog(@"发送 kEVENT_SERVICE_DEMO_ADD, 结果为 %d", ret.intValue);
}

- (IBAction)onClickForGetString:(UIButton *)sender {
    NSString *ret = [DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_GET_STRING];
    NSLog(@"发送 kEVENT_SERVICE_DEMO_GET_STRING, 结果为 %@", ret);
}

- (IBAction)onClickForGetObject:(UIButton *)sender {
    UserModel *user = [DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_GET_OBJECT];
    NSLog(@"发送 kEVENT_SERVICE_DEMO_GET_OBJECT, 结果为 %@", user);
}

- (IBAction)onClickForMutilMethod:(UIButton *)sender {
    NSLog(@"发送 kEVENT_SERVICE_DEMO_MUTIL_METHOD");
    [DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_MUTIL_METHOD];
}

@end
