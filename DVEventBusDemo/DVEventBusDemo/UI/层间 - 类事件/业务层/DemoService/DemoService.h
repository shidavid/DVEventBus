//
//  DemoService.h
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoServiceEvent.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoService : NSObject <DVEventBusClassDelegate>

@end

NS_ASSUME_NONNULL_END
