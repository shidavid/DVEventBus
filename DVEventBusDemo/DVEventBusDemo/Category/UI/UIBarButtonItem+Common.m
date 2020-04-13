//
//  UIBarButtonItem+Common.m
//  French
//
//  Created by DV on 2018/3/29.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "UIBarButtonItem+Common.h"

@implementation UIBarButtonItem (Common)

+ (instancetype)spaceItem {
    return [[self alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

@end
