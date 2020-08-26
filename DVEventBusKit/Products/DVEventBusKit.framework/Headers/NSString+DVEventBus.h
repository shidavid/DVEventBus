//
//  NSString+EventBus.h
//  French
//
//  Created by DV on 2018/5/10.
//  Copyright © 2018 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - <-------------------- Function -------------------->
NSString * _sel(SEL sel);

/// app version : 1.0.2 - 1.2
NSString * _sel_v(SEL sel, NSString *_Nullable originVersion, NSString *_Nullable lastVersion);


#pragma mark - <-------------------- Class -------------------->
@interface NSString (DVEventBus)

- (NSString *(^)(SEL sel))_sel;
- (NSString *(^)(SEL sel, NSString *_Nullable originVersion, NSString *_Nullable lastVersion))_sel_v;

@end

NS_ASSUME_NONNULL_END
