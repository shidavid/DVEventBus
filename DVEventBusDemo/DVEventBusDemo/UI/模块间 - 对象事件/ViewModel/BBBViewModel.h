//
//  BBBViewModel.h
//  DVEventBusDemo
//
//  Created by DV on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

kEVENT_VM_MODULE(BBB, RECEIVE_MESSAGE)

@interface BBBViewModel : NSObject <DVEventBusDelegate>

@property(nonatomic, copy) NSString *message;

- (void)sendMessageToAAA;

@end

NS_ASSUME_NONNULL_END
