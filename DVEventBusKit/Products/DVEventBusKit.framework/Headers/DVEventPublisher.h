//
//  DVEventPublisher.h
//  French
//
//  Created by DV on 2018/6/5.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - <-------------------- Event -------------------->
@interface DVEventPublisher : NSObject

+ (nullable id)publishEvent:(NSString *)event;
+ (nullable id)publishEvent:(NSString *)event params:(id)args,... NS_REQUIRES_NIL_TERMINATION;
+ (nullable id)publishEvent:(NSString *)event model:(NSObject *)model;
+ (nullable id)publishEvent:(NSString *)event dict:(NSDictionary<NSString *, id> *)dict;

@end


#pragma mark - <-------------------- Class Event -------------------->
@interface DVEventPublisher (Class)

+ (nullable id)publishClassEvent:(NSString *)event;
+ (nullable id)publishClassEvent:(NSString *)event params:(id)args,... NS_REQUIRES_NIL_TERMINATION;
+ (nullable id)publishClassEvent:(NSString *)event model:(NSObject *)model;
+ (nullable id)publishClassEvent:(NSString *)event dict:(NSDictionary<NSString *, id> *)dict;

@end

NS_ASSUME_NONNULL_END
