//
//  UserModel.m
//  DVEventBusDemo
//
//  Created by mlgPro on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"userName->%@, password->%@", self.userName, self.password];
}

@end
