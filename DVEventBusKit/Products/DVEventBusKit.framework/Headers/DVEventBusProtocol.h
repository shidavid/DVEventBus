//
//  DVEventBusProtocol.h
//  French
//
//  Created by DV on 2018/5/10.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DVEventBusDelegate <NSObject>

- (NSDictionary<NSString *,NSString *> *)event_method_map;

@end



@protocol DVEventBusClassDelegate <NSObject>

+ (NSDictionary<NSString *,NSString *> *)event_classMethod_map;

@end

NS_ASSUME_NONNULL_END
