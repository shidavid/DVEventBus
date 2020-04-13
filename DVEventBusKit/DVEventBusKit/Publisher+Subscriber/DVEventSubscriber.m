//
//  DVEventSubscriber.m
//  French
//
//  Created by DV on 2018/6/5.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVEventSubscriber.h"
#import "DVEventBus.h"

@implementation DVEventSubscriber

#pragma mark - <-- Private -->
+ (void)registerEvents:(id<DVEventBusDelegate>)delegate {
    
    if (![delegate respondsToSelector:@selector(event_method_map)]) {
        NSLog(@"[DVEventSubscriber ERROR]: 注册失败,没实现 \"event_method_map\" 方法 -> %@", delegate);
        return;
    }
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    
    [isaEventBus registerEventBusiness:[delegate event_method_map]
                             publisher:isaEventBus
                            subscriber:delegate
                            eventsDict:isaEventBus.priEventsDict];
}

+ (void)unregisterEvents:(id<DVEventBusDelegate>)delegate {
    
    if (![delegate respondsToSelector:@selector(event_method_map)]) {
        NSLog(@"[DVEventSubscriber ERROR]: 注销失败,没实现 \"event_method_map\" 方法 -> %@", delegate);
        return;
    }
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    
    [isaEventBus unregisterEventBusiness:[delegate event_method_map]
                               publisher:isaEventBus
                              subscriber:delegate
                              eventsDict:isaEventBus.priEventsDict];
}

+ (void)addEvent:(NSString *)event subscriber:(id)subscriber action:(SEL)action {
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    [isaEventBus addEvent:event
                publisher:isaEventBus
               subscriber:subscriber
                   action:action
               eventsDict:isaEventBus.priEventsDict];
}

+ (void)removeEvent:(NSString *)event {
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    [isaEventBus removeEvent:event eventsDict:isaEventBus.priEventsDict];
}

+ (void)removeEvent:(NSString *)event subscriber:(id)subscriber action:(SEL)action {
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    [isaEventBus removeEvent:event
                   publisher:isaEventBus
                  subscriber:subscriber
                      action:action
                  eventsDict:isaEventBus.priEventsDict];
}




#pragma mark - <-- Class -->
+ (void)registerClassEvents:(Class<DVEventBusClassDelegate>)delegate {
    
    if (![delegate respondsToSelector:@selector(event_classMethod_map)]) {
        NSLog(@"[DVEventSubscriber ERROR]: 注册失败,没实现 \"event_classMethod_map\" 方法 -> %@", NSStringFromClass(delegate));
        return;
    }
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    [isaEventBus registerEventBusiness:[delegate event_classMethod_map]
                             publisher:isaEventBus
                            subscriber:delegate
                            eventsDict:isaEventBus.gloEventsDict];
}

+ (void)unregisterClassEvents:(Class<DVEventBusClassDelegate>)delegate {
    
    if (![delegate respondsToSelector:@selector(event_classMethod_map)]) {
        NSLog(@"[DVEventSubscriber ERROR]: 注销失败,没实现 \"event_classMethod_map\" 方法 -> %@", NSStringFromClass(delegate));
        return;
    }
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    [isaEventBus unregisterEventBusiness:[delegate event_classMethod_map]
                               publisher:isaEventBus
                              subscriber:delegate
                              eventsDict:isaEventBus.gloEventsDict];
}

+ (void)addClasslEvent:(NSString *)event subscriber:(Class)subscriber action:(SEL)action {
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    [isaEventBus addEvent:event
                publisher:isaEventBus
               subscriber:subscriber
                   action:action
               eventsDict:isaEventBus.gloEventsDict];
}

+ (void)removeClassEvent:(NSString *)event {
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    [isaEventBus removeEvent:event eventsDict:isaEventBus.gloEventsDict];
}

+ (void)removeClassEvent:(NSString *)event subscriber:(Class)subscriber action:(SEL)action {
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    [isaEventBus removeEvent:event
                   publisher:isaEventBus
                  subscriber:subscriber
                      action:action
                  eventsDict:isaEventBus.gloEventsDict];
}

@end
