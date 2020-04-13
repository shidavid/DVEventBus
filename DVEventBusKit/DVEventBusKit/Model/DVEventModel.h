//
//  DVEventModel.h
//  French
//
//  Created by DV on 2018/5/10.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVEventModel : NSObject

@property(nonatomic, copy)   NSString *eventName;
@property(nonatomic, weak)   id subscriber;
@property(nonatomic, assign) SEL selector;
@property(nonatomic, strong) NSMethodSignature *signature;

@end

NS_ASSUME_NONNULL_END
