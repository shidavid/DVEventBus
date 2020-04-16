//
//  BBBViewModel.m
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "BBBViewModel.h"
#import "AAAViewModel.h"

@implementation BBBViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [DVEventSubscriber registerEvents:self];
    }
    return self;
}

- (NSDictionary<NSString *,NSString *> *)event_method_map {
    return @{
        kEVENT_VM_BBB_RECEIVE_MESSAGE : _sel(@selector(receiveMessage:)),
    };
}

- (void)receiveMessage:(NSString *)message {
    NSLog(@"[BBBViewModel LOG]: 收到消息 -> %@", message);
    self.message = message;
}


#pragma mark - <-- Method -->
- (void)sendMessageToAAA {
    NSLog(@"[BBBViewModel LOG]: BBB 发送信息给 AAA");
    [DVEventPublisher publishEvent:kEVENT_VM_AAA_RECEIVE_MESSAGE params:@"Hello AAA", nil];
}

@end
