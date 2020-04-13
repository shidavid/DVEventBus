//
//  DVEventPublisher.m
//  French
//
//  Created by DV on 2018/6/5.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVEventPublisher.h"
#import "DVEventBus.h"

@implementation DVEventPublisher

#pragma mark - <-- Private -->

+ (id)publishEvent:(NSString *)event {
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    NSArray<NSInvocation *> *invocations = [isaEventBus getInvocationsByEvent:event
                                                                    publisher:isaEventBus
                                                                   eventsDict:isaEventBus.priEventsDict];
    
    if (invocations.count == 0) {
        NSLog(@"[DVEventPublisher ERROR]: 该事件无订阅者 -> %@", event);
        return nil;
    }
    
    return [isaEventBus invokeEventWithInvocations:invocations];
}

+ (id)publishEvent:(NSString *)event params:(id)args, ... {
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    NSArray<NSInvocation *> *invocations = [isaEventBus getInvocationsByEvent:event
                                                                    publisher:isaEventBus
                                                                   eventsDict:isaEventBus.priEventsDict];
    
    if (invocations.count == 0) {
        NSLog(@"[DVEventPublisher ERROR]: 该事件无订阅者 -> %@", event);
        return nil;
    }
    
    va_list list;
    va_start(list, args);
    
    [isaEventBus setInvocationParams:invocations fristParam:args paramList:list];
    
    va_end(list);
    
    return [isaEventBus invokeEventWithInvocations:invocations];
}

+ (id)publishEvent:(NSString *)event model:(NSObject *)model {
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    NSArray<NSInvocation *> *invocations = [isaEventBus getInvocationsByEvent:event
                                                                    publisher:isaEventBus
                                                                   eventsDict:isaEventBus.priEventsDict];
    
    if (invocations.count == 0) {
        NSLog(@"[DVEventPublisher ERROR]: 该事件无订阅者 -> %@", event);
        return nil;
    }
    
    [isaEventBus setInvocationParams:invocations model:model];
    
    return [isaEventBus invokeEventWithInvocations:invocations];
}

+ (id)publishEvent:(NSString *)event dict:(NSDictionary<NSString *,id> *)dict {
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    NSArray<NSInvocation *> *invocations = [isaEventBus getInvocationsByEvent:event
                                                                    publisher:isaEventBus
                                                                   eventsDict:isaEventBus.priEventsDict];
    
    if (invocations.count == 0) {
        NSLog(@"[DVEventPublisher ERROR]: 该事件无订阅者 -> %@", event);
        return nil;
    }
    
    [isaEventBus setInvocationParams:invocations info:dict];
    
    return [isaEventBus invokeEventWithInvocations:invocations];
}

@end




@implementation DVEventPublisher (Class)

+ (id)publishClassEvent:(NSString *)event {
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    NSArray<NSInvocation *> *invocations = [isaEventBus getInvocationsByEvent:event
                                                                    publisher:isaEventBus
                                                                   eventsDict:isaEventBus.gloEventsDict];
    
    if (invocations.count == 0) {
        NSLog(@"[DVEventPublisher ERROR]: 该类事件无订阅者 -> %@", event);
        return nil;
    }
    
    return [isaEventBus invokeEventWithInvocations:invocations];
}

+ (id)publishClassEvent:(NSString *)event params:(id)args, ... {
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    NSArray<NSInvocation *> *invocations = [isaEventBus getInvocationsByEvent:event
                                                                    publisher:isaEventBus
                                                                   eventsDict:isaEventBus.gloEventsDict];
    
    if (invocations.count == 0) {
        NSLog(@"[DVEventPublisher ERROR]: 该类事件无订阅者 -> %@", event);
        return nil;
    }
    
    va_list list;
    va_start(list, args);
    
    [isaEventBus setInvocationParams:invocations fristParam:args paramList:list];
    
    va_end(list);
    
    return [isaEventBus invokeEventWithInvocations:invocations];
}

+ (id)publishClassEvent:(NSString *)event model:(NSObject *)model {
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    NSArray<NSInvocation *> *invocations = [isaEventBus getInvocationsByEvent:event
                                                                    publisher:isaEventBus
                                                                   eventsDict:isaEventBus.gloEventsDict];
    
    if (invocations.count == 0) {
        NSLog(@"[DVEventPublisher ERROR]: 该类事件无订阅者 -> %@", event);
        return nil;
    }
    
    [isaEventBus setInvocationParams:invocations model:model];
    
    return [isaEventBus invokeEventWithInvocations:invocations];
}

+ (id)publishClassEvent:(NSString *)event dict:(NSDictionary<NSString *,id> *)dict {
    
    DVEventBus *isaEventBus = [DVEventBus sharedInstance];
    NSArray<NSInvocation *> *invocations = [isaEventBus getInvocationsByEvent:event
                                                                    publisher:isaEventBus
                                                                   eventsDict:isaEventBus.gloEventsDict];
    
    if (invocations.count == 0) {
        NSLog(@"[DVEventPublisher ERROR]: 该类事件无订阅者 -> %@", event);
        return nil;
    }
    
    [isaEventBus setInvocationParams:invocations info:dict];
    
    return [isaEventBus invokeEventWithInvocations:invocations];
}

@end
