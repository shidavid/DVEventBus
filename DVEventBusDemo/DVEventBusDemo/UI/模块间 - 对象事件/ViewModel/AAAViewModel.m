//
//  AAAViewModel.m
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "AAAViewModel.h"
#import "BBBViewModel.h"

@implementation AAAViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [DVEventSubscriber registerEvents:self];
    }
    return self;
}

- (NSDictionary<NSString *,NSString *> *)event_method_map {
    return @{
        kEVENT_VM_AAA_RECEIVE_MESSAGE : _sel(@selector(receiveMessage:)),
    };
}

- (void)receiveMessage:(NSString *)message {
    NSLog(@"[AAAViewModel LOG]: 收到消息 -> %@", message);
    self.message = message;
}


#pragma mark - <-- Method-->
- (void)sendMessageToBBB {
    NSLog(@"[AAAViewModel LOG]: AAA 发送信息给 BBB");
    [DVEventPublisher publishEvent:kEVENT_VM_BBB_RECEIVE_MESSAGE params:@"Hello BBB", nil];
}

@end
