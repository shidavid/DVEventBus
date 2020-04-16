//
//  BaseViewController.m
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "BaseViewController.h"
#import "SubViewController.h"
#import "AAAViewModel.h"
#import "BBBViewModel.h"

@interface BaseViewController () <DVEventBusDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblMessageA;
@property (weak, nonatomic) IBOutlet UILabel *lblMessageB;
@property (weak, nonatomic) IBOutlet UILabel *lblMessageBase;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIButton *btnBase;

@property(nonatomic, strong) AAAViewModel *aaaViewModel;
@property(nonatomic, strong) BBBViewModel *bbbViewModel;

@end

@implementation BaseViewController

#pragma mark - <-- ViewLife -->
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BaseViewController";
    
    // 注册事件
    [DVEventSubscriber registerEvents:self];
    
    [self initModels];
    [self bindViewModel];
}


#pragma mark - <-- Init -->
- (void)initModels {
    self.aaaViewModel = [[AAAViewModel alloc] init];
    self.bbbViewModel = [[BBBViewModel alloc] init];
}

- (void)bindViewModel {
    
    // 数据双向绑定
    DVDataBind
    ._inout(self.lblMessageA, @"text")
    ._inout(self.aaaViewModel, @"message");
    
    DVDataBind
    ._inout(self.lblMessageB, @"text")
    ._inout(self.bbbViewModel, @"message");
    
    // Button绑定方法
    [self.btnA addTarget:self.aaaViewModel action:@selector(sendMessageToBBB) forControlEvents:UIControlEventTouchUpInside];
    [self.btnB addTarget:self.bbbViewModel action:@selector(sendMessageToAAA) forControlEvents:UIControlEventTouchUpInside];
    [self.btnBase addTarget:self action:@selector(onClickForPushSubViewController) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - <-- Action -->
- (void)onClickForPushSubViewController {
    SubViewController *vc = [[SubViewController alloc] init];
    [self pushViewController:vc animated:YES];
}


#pragma mark - <-- Method -->
// 事件绑定函数
- (NSDictionary<NSString *,NSString *> *)event_method_map {
    return @{
        kEVENT_BASE_VC_RECEIVE_MESSAGE : _sel(@selector(receiveMessage:)),
    };
}

- (void)receiveMessage:(NSString *)message {
    NSLog(@"[BaseViewController LOG]: 收到消息 -> %@", message);
    self.lblMessageBase.text = message;
}

@end
