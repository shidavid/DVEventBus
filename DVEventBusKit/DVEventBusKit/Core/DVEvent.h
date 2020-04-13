//
//  DVEvent.h
//  French
//
//  Created by DV on 2018/5/10.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVEvent : NSObject

#pragma mark - <-- Property -->
@property(nonatomic, copy, readonly) NSString *eventName;


#pragma mark - <-- Instance -->
- (instancetype)initWithEventName:(NSString *)eventName;


#pragma mark - <-- Method -->
- (void)addPublisher:(id)publisher subscriber:(id)subscriber action:(SEL)action;

- (void)removePublisher:(id)publisher;

- (void)removePublisher:(id)publisher subscriber:(id)subscriber action:(SEL)action;

- (void)removeAll;

- (NSArray<NSInvocation *> *)getInvocationsByPublisher:(id)publisher;

@end

NS_ASSUME_NONNULL_END
