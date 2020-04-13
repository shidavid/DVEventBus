//
//  NSString+EventBus.m
//  French
//
//  Created by DV on 2018/5/10.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "NSString+DVEventBus.h"

NSString * _sel(SEL sel) {
    return NSStringFromSelector(sel);
}

NSString * _sel_v(SEL sel, NSString *_Nullable originVersion, NSString *_Nullable lastVersion) {
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSArray<NSString *> *curVerArray = [currentVersion componentsSeparatedByString:@"."];
    
    BOOL ret = YES;
    
    if (originVersion) {
        NSArray<NSString *> *oriVerArray = [originVersion componentsSeparatedByString:@"."];
        int count = (int)MIN(oriVerArray.count, curVerArray.count);
        for (int i = 0; i < count; i++) {
            if ([oriVerArray[i] isEqualToString:@""]) break;
            
            int oriNum = oriVerArray[i].intValue;
            int curNum = curVerArray[i].intValue;
            
            if (oriNum < curNum) {
                break;
            } else if (oriNum > curNum) {
                ret = NO;
                break;
            }
        }
    }
    
    if (ret && lastVersion) {
        NSArray<NSString *> *lastVerArray = [lastVersion componentsSeparatedByString:@"."];
        int count = (int)MIN(curVerArray.count, lastVerArray.count);
        for (int i = 0; i < count; i++) {
            if ([lastVerArray[i] isEqualToString:@""]) break;
            
            int curNum = curVerArray[i].intValue;
            int lastNum = lastVerArray[i].intValue;
            
            if (curNum < lastNum) {
                break;
            } else if (curNum > lastNum) {
                ret = NO;
                break;
            }
        }
    }
    
    return ret ? NSStringFromSelector(sel) : @"";
}



@implementation NSString (DVEventBus)

- (NSString *(^)(SEL))_sel {
    return ^NSString *(SEL sel){
        return [self stringByAppendingFormat:@",%@",NSStringFromSelector(sel)];
    };
}

- (NSString * _Nonnull (^)(SEL _Nonnull, NSString * _Nullable, NSString * _Nullable))_sel_v {
    return ^NSString *(SEL sel, NSString *_Nullable originVersion, NSString *_Nullable lastVersion) {
        
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        NSArray<NSString *> *curVerArray = [currentVersion componentsSeparatedByString:@"."];
        
        BOOL ret = YES;
        
        if (originVersion) {
            NSArray<NSString *> *oriVerArray = [originVersion componentsSeparatedByString:@"."];
            int count = (int)MIN(oriVerArray.count, curVerArray.count);
            for (int i = 0; i < count; i++) {
                if ([oriVerArray[i] isEqualToString:@""]) break;
                
                int oriNum = oriVerArray[i].intValue;
                int curNum = curVerArray[i].intValue;
                
                if (oriNum < curNum) {
                    break;
                } else if (oriNum > curNum) {
                    ret = NO;
                    break;
                }
            }
        }
        
        if (ret && lastVersion) {
            NSArray<NSString *> *lastVerArray = [lastVersion componentsSeparatedByString:@"."];
            int count = (int)MIN(curVerArray.count, lastVerArray.count);
            for (int i = 0; i < count; i++) {
                if ([lastVerArray[i] isEqualToString:@""]) break;
                
                int curNum = curVerArray[i].intValue;
                int lastNum = lastVerArray[i].intValue;
                
                if (curNum < lastNum) {
                    break;
                } else if (curNum > lastNum) {
                    ret = NO;
                    break;
                }
            }
        }
        
        return ret ? [self stringByAppendingFormat:@",%@",NSStringFromSelector(sel)] : self;
    };
}

@end

