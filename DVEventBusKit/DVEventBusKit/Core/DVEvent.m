//
//  DVEvent.m
//  French
//
//  Created by DV on 2018/5/10.
//  Copyright © 2018 iOS. All rights reserved.
//

#import "DVEvent.h"
#import "DVEventModel.h"

@interface DVEvent ()

@property(nonatomic, copy, readwrite) NSString *eventName;

//TODO: publisher主动释放内存
@property(nonatomic, strong) NSMapTable<id, NSMutableArray<DVEventModel *> *> *mapEventModelForPublisher;

@end

@implementation DVEvent

- (instancetype)initWithEventName:(NSString *)eventName {
    self = [super init];
    if (self) {
        self.eventName = eventName;
        self.mapEventModelForPublisher = [NSMapTable weakToStrongObjectsMapTable];
    }
    return self;
}



- (void)dealloc {
    if (_mapEventModelForPublisher) {
        [_mapEventModelForPublisher removeAllObjects];
        _mapEventModelForPublisher = nil;
    }
}

#pragma mark - <-- Method -->
#pragma mark - <-- 增加 删除 -->
- (void)addPublisher:(id)publisher subscriber:(id)subscriber action:(SEL)action {
    
    NSMutableArray<DVEventModel *> *isaEventModels = [self.mapEventModelForPublisher objectForKey:publisher];
    
    if (isaEventModels == nil) {
        isaEventModels = [NSMutableArray array];
        [self.mapEventModelForPublisher setObject:isaEventModels forKey:publisher];
    }
    
    NSMutableArray<DVEventModel *> *crashModels = [NSMutableArray array];
    BOOL isRepeat = NO;
    for (DVEventModel *aEventModel in isaEventModels) {
        if (aEventModel.subscriber == nil) {
            [crashModels addObject:aEventModel];
            continue;
        }
        
        if (aEventModel.subscriber == subscriber && aEventModel.selector == action) {
            isRepeat = YES;
        }
    }
    [isaEventModels removeObjectsInArray:crashModels];
    
    if (isRepeat == YES) return; // 重复注册
    
    DVEventModel *eventModel = [[DVEventModel alloc] init];
    eventModel.subscriber = subscriber;
    eventModel.selector = action;
    eventModel.eventName = self.eventName;
    
    [isaEventModels addObject:eventModel];
}

- (void)removePublisher:(id)publisher {
    [self.mapEventModelForPublisher removeObjectForKey:publisher];
}

- (void)removePublisher:(id)publisher subscriber:(id)subscriber action:(SEL)action {
    
    NSMutableArray<DVEventModel *> *isaEventModels = [self.mapEventModelForPublisher objectForKey:publisher];
    
    if (isaEventModels == nil) {
        return;
    }
    
    NSMutableIndexSet *mutIndexSet = [NSMutableIndexSet indexSet];
    
    for (int index = 0; index < isaEventModels.count; ++index) {
        
        DVEventModel *isaEventModel = isaEventModels[index];
        
        if (([isaEventModel.subscriber isEqual:subscriber]) && (isaEventModel.selector == action)) {
            [mutIndexSet addIndex:index];
        }
    }
    
    [isaEventModels removeObjectsAtIndexes:mutIndexSet];

//    NSMapRemove(<#NSMapTable * _Nonnull table#>, <#const void * _Nullable key#>)
}

- (void)removeAll {
    [self.mapEventModelForPublisher removeAllObjects];
}


#pragma mark - <-- 获取请求 -->
- (NSArray<NSInvocation *> *)getInvocationsByPublisher:(id)publisher {
    
    NSMutableArray<DVEventModel *> *isaEventModels = [self.mapEventModelForPublisher objectForKey:publisher];
    
    if (isaEventModels == nil || isaEventModels.count == 0) {
        return @[];
    }
    
    if (isaEventModels.count == 1) {
        NSInvocation *invocation = [self getInvocationWithEventModel:isaEventModels[0]];
        return invocation != nil ? @[invocation] : @[];
    }
    
    NSMutableArray *mutInvocations = [NSMutableArray array];
    
    for (DVEventModel *eventModel in isaEventModels) {
        NSInvocation *invocation = [self getInvocationWithEventModel:eventModel];
        
        if (invocation) {
            [mutInvocations addObject:invocation];
        }
    }
    
    return [mutInvocations copy];
}

- (NSInvocation * _Nullable)getInvocationWithEventModel:(DVEventModel *)eventModel {

    SEL selector = eventModel.selector;
    __strong __typeof(eventModel.subscriber)strongSubscriber = eventModel.subscriber;
    NSMethodSignature *signature = (eventModel.signature != nil
                                    ? eventModel.signature
                                    : [strongSubscriber methodSignatureForSelector:selector]);

    if (signature == nil) {
        return nil;
    }

    eventModel.signature = signature;

    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:strongSubscriber];
    [invocation setSelector: selector];

    return invocation;
}

@end
