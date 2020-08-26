//
//  DVEventBusKit.h
//  DVEventBusKit
//
//  Created by mlgPro on 2020/4/13.
//  Copyright © 2020 DVKit. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<DVEventBusKit/DVEventBusKit.h>)
//! Project version number for DVDataBindKit.
FOUNDATION_EXPORT double DVEventBusKitVersionNumber;

//! Project version string for DVDataBindKit.
FOUNDATION_EXPORT const unsigned char DVEventBusKitVersionString[];

#import <DVEventBusKit/DVEventBusDefine.h>
#import <DVEventBusKit/DVEventBusProtocol.h>
#import <DVEventBusKit/DVEventPublisher.h>
#import <DVEventBusKit/DVEventSubscriber.h>
#import <DVEventBusKit/NSString+DVEventBus.h>

#else

#import "DVEventBusDefine.h"
#import "DVEventBusProtocol.h"
#import "DVEventPublisher.h"
#import "DVEventSubscriber.h"
#import "NSString+DVEventBus.h"

#endif


