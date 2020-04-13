//
//  DVEventSubscriber.h
//  French
//
//  Created by DV on 2018/6/5.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVEventBusProtocol.h"

NS_ASSUME_NONNULL_BEGIN


#pragma mark - <-------------------- Event -------------------->
@interface DVEventSubscriber : NSObject

/// 注册事件业务
+ (void)registerEvents:(id<DVEventBusDelegate>)delegate;

/// 注销事件业务 (自动注销，无需手动注销)
+ (void)unregisterEvents:(id<DVEventBusDelegate>)delegate;


+ (void)addEvent:(NSString *)event subscriber:(id)subscriber action:(SEL)action;

+ (void)removeEvent:(NSString *)event;

+ (void)removeEvent:(NSString *)event subscriber:(id)subscriber action:(SEL)action;

@end



#pragma mark - <-------------------- Class Event -------------------->
@interface DVEventSubscriber (ClassEvent)

/// 注册类事件业务
+ (void)registerClassEvents:(Class<DVEventBusClassDelegate>)delegate;

/// 注销类事件业务 (自动注销，无需手动注销)
+ (void)unregisterClassEvents:(Class<DVEventBusClassDelegate>)delegate;


+ (void)addClasslEvent:(NSString *)event subscriber:(Class)subscriber action:(SEL)action;

+ (void)removeClassEvent:(NSString *)event;

+ (void)removeClassEvent:(NSString *)event subscriber:(Class)subscriber action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
