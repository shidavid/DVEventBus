//
//  DVEventBus.h
//  French
//
//  Created by DV on 2018/5/10.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVEvent.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - <-------------------- Class -------------------->
@interface DVEventBus : NSObject

#pragma mark - <-- Property -->
@property(nonatomic, strong, readonly) NSMutableDictionary<NSString *, DVEvent *> *priEventsDict;
@property(nonatomic, strong, readonly) NSMutableDictionary<NSString *, DVEvent *> *gloEventsDict;


#pragma mark - <-- Instance -->
+ (instancetype)sharedInstance;


#pragma mark - <-- Method -->
- (void)registerEventBusiness:(NSDictionary<NSString *, NSString *> *)eventMethodMap
                    publisher:(id)publisher
                   subscriber:(id)subscriber
                   eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict;


- (void)unregisterEventBusiness:(NSDictionary<NSString *, NSString *> *)eventMethodMap
                      publisher:(id)publisher
                     subscriber:(id)subscriber
                     eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict;


- (void)addEvent:(NSString *)event
       publisher:(id)publisher
      subscriber:(id)subscriber
          action:(SEL)action
      eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict;


- (void)removeEvent:(NSString *)event
         eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict;


- (void)removePublisher:(id)publisher
             eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict;


- (void)removeEvent:(NSString *)event
          publisher:(id)publisher
         subscriber:(id)subscriber
             action:(SEL)action
         eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict;


#pragma mark - <-- Method Invocation -->
/// 获取请求
- (NSArray<NSInvocation *> *)getInvocationsByEvent:(NSString *)event
                                         publisher:(id)publisher
                                        eventsDict:(NSMutableDictionary<NSString *, DVEvent *> *)eventsDict;

/// 设置参数
- (void)setInvocationParams:(NSArray<NSInvocation *> *)invocations fristParam:(id)fristParam paramList:(va_list)paramList;

/// 设置参数 Model
- (void)setInvocationParams:(NSArray<NSInvocation *> *)invocations model:(__kindof NSObject *)model;

/// 设置参数 字典
- (void)setInvocationParams:(NSArray<NSInvocation *> *)invocations info:(NSDictionary *)info;

/// 执行请求
- (nullable id)invokeEventWithInvocations:(NSArray<NSInvocation *> *)invocations;

@end

NS_ASSUME_NONNULL_END
