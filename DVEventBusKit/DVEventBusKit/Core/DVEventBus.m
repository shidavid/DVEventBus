//
//  DVEventBus.m
//  French
//
//  Created by DV on 2018/5/10.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVEventBus.h"

@interface DVEventBus ()

@property(nonatomic, strong, readwrite) NSMutableDictionary<NSString *, DVEvent *> *priEventsDict;
@property(nonatomic, strong, readwrite) NSMutableDictionary<NSString *, DVEvent *> *gloEventsDict;

@end


@implementation DVEventBus

#pragma mark - <-- Instance -->
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static DVEventBus *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}



#pragma mark - <-- Property -->
- (NSMutableDictionary<NSString *, DVEvent *> *)priEventsDict {
    if (!_priEventsDict) {
        _priEventsDict = [NSMutableDictionary dictionary];
    }
    return _priEventsDict;
}

- (NSMutableDictionary<NSString *, DVEvent *> *)gloEventsDict {
    if (!_gloEventsDict) {
        _gloEventsDict = [NSMutableDictionary dictionary];
    }
    return _gloEventsDict;
}



#pragma mark - <-- Method -->

#pragma mark - <-- 注册 添加 移除 -->
- (void)registerEventBusiness:(NSDictionary<NSString *, NSString *> *)eventMethodMap
                    publisher:(id)publisher
                   subscriber:(id)subscriber
                   eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict {
    
    for (NSString *event in eventMethodMap.allKeys) {
        
        DVEvent *isaEvent = eventsDict[event];
        
        if (isaEvent == nil) {
            isaEvent = [[DVEvent alloc] initWithEventName:event];
            eventsDict[event] = isaEvent;
        }
        
        NSString *str_sels = eventMethodMap[event];
        
        NSArray<NSString *> *arr_sel = [str_sels componentsSeparatedByString:@","];
        
        for (int index = 0; index < arr_sel.count; ++index) {
            if ([arr_sel[index] isEqualToString:@""]) continue;
            [isaEvent addPublisher:publisher subscriber:subscriber action:NSSelectorFromString(arr_sel[index])];
        }
    }
}

- (void)unregisterEventBusiness:(NSDictionary<NSString *, NSString *> *)eventMethodMap
                      publisher:(id)publisher
                     subscriber:(id)subscriber
                     eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict {

    for (NSString *event in eventMethodMap.allKeys) {
        
        DVEvent *isaEvent = eventsDict[event];
        
        if (isaEvent == nil) {
            continue;
        }
        
        NSString *str_sels = eventMethodMap[event];
        
        NSArray<NSString *> *arr_sel = [str_sels componentsSeparatedByString:@","];
        
        for (int index = 0; index < arr_sel.count; ++index) {
            if ([arr_sel[index] isEqualToString:@""]) continue;
            [isaEvent removePublisher:publisher subscriber:subscriber action:NSSelectorFromString(arr_sel[index])];
        }
    }
}

- (void)addEvent:(NSString *)event
       publisher:(id)publisher
      subscriber:(id)subscriber
          action:(SEL)action
      eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict {
    
    DVEvent *isaEvent = eventsDict[event];
    
    if (isaEvent == nil) {
        isaEvent = [[DVEvent alloc] initWithEventName:event];
        [eventsDict setObject:isaEvent forKey:event];
    }
    
    [isaEvent addPublisher:publisher subscriber:subscriber action:action];
}

- (void)removeEvent:(NSString *)event
         eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict {
    
    DVEvent *isaEvent = eventsDict[event];
    
    if (isaEvent == nil) {
        return;
    }
    
    [isaEvent removeAll];
    [eventsDict removeObjectForKey:event];
}

- (void)removePublisher:(id)publisher eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict {
    
    for (NSString *event in eventsDict) {
        [eventsDict[event] removePublisher:publisher];
    }
}

- (void)removeEvent:(NSString *)event
          publisher:(id)publisher
         subscriber:(id)subscriber
             action:(SEL)action
         eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict {
    
    DVEvent *isaEvent = eventsDict[event];
    
    if (isaEvent == nil) {
        return;
    }
    
    [isaEvent removePublisher:publisher subscriber:subscriber action:action];
}



#pragma mark - <-- 获取请求 -->
- (NSArray<NSInvocation *> *)getInvocationsByEvent:(NSString *)event
                                         publisher:(id)publisher
                                        eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict {
    return [eventsDict[event] getInvocationsByPublisher:publisher];
}

- (void)setInvocationParams:(NSArray<NSInvocation *> *)invocations
                 fristParam:(id)fristParam
                  paramList:(va_list)paramList {
    
    if (fristParam) {
        
        for (NSInvocation *invocation in invocations) {
            
            NSUInteger index = 2;
            [invocation setArgument:&fristParam atIndex:index];
            
            va_list list = paramList;
            id arg;
         
            while ((arg = va_arg(list, id))) {
                index += 1;
                [invocation setArgument:&arg atIndex:index];
            }
        }
    }
}

- (void)setInvocationParams:(NSArray<NSInvocation *> *)invocations model:(__kindof NSObject *)model {
    
    if (model) {
        
        for (NSInvocation *invocation in invocations) {
            
            NSString *str_sel = NSStringFromSelector(invocation.selector);
            
            NSArray<NSString *> *str_params = [str_sel componentsSeparatedByString:@":"];
            
            if (str_params.count <= 1) {
                return;
            }
            
            NSString *str_head_param = str_params[0];
            
            NSUInteger index = 0;
            for (int i = (int)str_head_param.length - 1; i >= 0; --i) {
                const char c = [str_head_param characterAtIndex:i];
                if (c >= 'A' && c <= 'Z') {
                    index = (NSUInteger)i;
                    break;
                }
            }
            
            str_head_param = [[str_head_param substringFromIndex:index] lowercaseString];
            
            
            id param = [model valueForKey:str_head_param];
            [invocation setArgument:&param atIndex:2];
            
            for (NSUInteger index = 1; index < (str_params.count - 1); ++index) {
                id param = [model valueForKey:str_params[index]];
                [invocation setArgument:&param atIndex:index+2];
            }
        }
    }
}

- (void)setInvocationParams:(NSArray<NSInvocation *> *)invocations info:(NSDictionary *)info {
    
    if (info) {
        
        for (NSInvocation *invocation in invocations) {
            
            NSString *str_sel = NSStringFromSelector(invocation.selector);
            
            NSArray<NSString *> *str_params = [str_sel componentsSeparatedByString:@":"];
            
            if (str_params.count <= 1) {
                return;
            }
            
            NSString *str_head_param = str_params[0];
            
            NSUInteger index = 0;
            for (int i = (int)str_head_param.length - 1; i >= 0; --i) {
                const char c = [str_head_param characterAtIndex:i];
                if (c >= 'A' && c <= 'Z') {
                    index = (NSUInteger)i;
                    break;
                }
            }
            
            str_head_param = [[str_head_param substringFromIndex:index] lowercaseString];
            
            id param = info[str_head_param];
            [invocation setArgument:&param atIndex:2];
            
            for (NSUInteger index = 1; index < (str_params.count - 1); ++index) {
                id param = info[str_params[index]];
                [invocation setArgument:&param atIndex:index+2];
            }
        }
    }
}

- (nullable id)invokeEventWithInvocations:(NSArray<NSInvocation *> *)invocations {
    
    if (invocations.count == 1) {
        
        NSInvocation *invocation = invocations[0];
        [invocation invoke];
        
        if (strcmp(invocation.methodSignature.methodReturnType, "v") != 0) {
            id __unsafe_unretained result = nil;
            [invocation getReturnValue:&result];
            id value = result;
            return value;
        }
    }
    else {
        
        NSMutableArray *results = [NSMutableArray array];
        
        for (NSInvocation *invocation in invocations) {
            
            [invocation invoke];
            
            if (strcmp(invocation.methodSignature.methodReturnType, "v") != 0) {
                id __unsafe_unretained result = nil;
                [invocation getReturnValue:&result];
                id value = result;
                [results addObject:value];
            }
        }
        if (invocations.count > 0) {
            return [results copy];
        }
    }
    
    return nil;
}

@end
