//
//  DVRuntimeObjectModel.m
//  French
//
//  Created by DV on 2018/8/12.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVRuntimeObjectModel.h"

@implementation DVRuntimeObjectModel

- (NSString *)description {
    NSDictionary *dict = @{
                           @"name" : self.name,
                           @"value" : self.value != nil ? self.value : @"nil",
                           @"className" : self.className,
                           };
    
    return [dict description];
}

@end

