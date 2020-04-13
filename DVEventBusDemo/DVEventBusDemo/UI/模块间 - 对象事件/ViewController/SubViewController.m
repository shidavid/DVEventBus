//
//  SubViewController.m
//  DVEventBusDemo
//
//  Created by mlgPro on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "SubViewController.h"
#import "BaseViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SubViewController";
    
    
}


- (IBAction)onClickForSendMessageToBase:(UIButton *)sender {
    NSLog(@"[SubViewController LOG]: SubVC 发送信息给 BaseVC");
    [DVEventPublisher publishEvent:kEVENT_BASE_VC_RECEIVE_MESSAGE params:@"Hello Base", nil];
}

@end
