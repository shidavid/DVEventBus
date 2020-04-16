### 1.前言:
现在模块间很多用事件总线解耦。以往的事件总线都是单向传递数据, 返回数据只能异步回调; 有时我想发送一个数据到某模块处理完返回结果才进行下一步骤, 如果一个地方出现多次请求数据，异步嵌套代码可读性很低;  想用 'performSelector' 来解耦函数调用，但有参数限制, 然后发现NSInvocation更加强大，所以选用NSInvocation来实现事件总线。

|区别| NSInvocation | performSelector | NSNotification |
|---| --- | --- | --- |
|参数| 可多参数 | 限制参数数量 |用userInfo传入参数|
|返回结果| 有, 同步 | 有, 同步 | 单向传递, 无 |
|调用耗时| 0.006ms | 0.005ms |  |
|返回结果耗时|0.007ms|0.003ms||



***
### 2.用法
>1) 支持多参数传递，同步返回结果，耗时与直接调用该方法相差无几
>2) 支持订阅对象方法和类方法
>3) 无需手动注销订阅

#### 1.定义事件: 
```
// 在'DVEventBusDefine.h' 或者 'PCH'文件 自定义个人喜好事件格式
#define kEVENT(event) static NSString *const kEVENT_##event = @"kEVENT_"#event;

#define kEVENT_MODULE(module,event) kEVENT(module##_##event)
#define kEVENT_GLOBAL_MODULE(module,event) kEVENT(GLOBAL_##module##_##event)
#define kEVENT_SERVICE_MODULE(module,event) kEVENT(SERVICE_##module##_##event)
#define kEVENT_DAO_MODULE(module,event) kEVENT(DAO_##module##_##event)
#define kEVENT_VM_MODULE(module,event) kEVENT(VM_##module##_##event)


// 创建 'DemoEvent.h' 自定义事件
kEVENT(DEMO)                            // 等于 kEVENT_DEMO
kEVENT_MODULE(DEMO, GET_DATA)           // 等于 kEVENT_DEMO_GET_DATA
kEVENT_SERVICE_MODULE(DEMO, GET_DATA)   // 等于 kEVENT_SERVICE_DEMO_GET_DATA
kEVENT_DAO_MODULE(DEMO, GET_DATA)       // 等于 kEVENT_DAO_DEMO_GET_DATA

```

---
#### 2. 订阅和发布 类事件
##### 2.1 订阅类事件 : 类事件是绑定类方法
```
@interface DemoService() <DVEventBusClassDelegate> // 继承 'DVEventBusClassDelegate'

@end


@implementation DemoService

/**
    类事件 绑定 类方法
    实现 'DVEventBusClassDelegate' 的 'event_classMethod_map' 方法
*/
+ (NSDictionary<NSString *,NSString *> *)event_classMethod_map {
    return @{
        kEVENT_SERVICE_DEMO_ADD          : _sel(@selector(addWithA:b:)),
        kEVENT_SERVICE_DEMO_GET_STRING   : _sel(@selector(getString)),
        kEVENT_SERVICE_DEMO_GET_OBJECT   : _sel(@selector(getObject)),
        kEVENT_SERVICE_DEMO_LOGIN        : _sel(@selector(loginWithUserName:password:success:)),
        kEVENT_SERVICE_DEMO_MUTIL_METHOD : _sel(@selector(mutilMethod1)) // 一个事件绑定多个方法, 顺序执行
                                          ._sel(@selector(mutilMethod2))
                                          ._sel(@selector(mutilMethod3))
    };
}


/*
    传入数字类型必须是'NSNumber'类型，返回数字类型也是'NSNumber'类型
*/
+ (NSNumber *)addWithA:(NSNumber *)a b:(NSNumber *)b {
    int ret = [a intValue] + [b intValue];
    return @(ret);
}

+ (NSString *)getString {
    return @"Hello world";
}

+ (UserModel *)getObject {
    UserModel *model = [[UserModel alloc] init];
    model.userName = @"David";
    model.password = @"123456";
    return model;
}

+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password success:(void(^)(BOOL status))success {
    NSLog(@"[DemoService LOG]: 登录成功, userName-> %@, password-> %@", userName, password);
    success(YES);
}

+ (void)mutilMethod1 {
    NSLog(@"[DemoService LOG]: 触发方法1");
}

+ (void)mutilMethod2 {
    NSLog(@"[DemoService LOG]: 触发方法2");
}

+ (void)mutilMethod3 {
    NSLog(@"[DemoService LOG]: 触发方法3");
}

@end
```

##### 2.2.1 注册类事件: 
```
// 用这个方法注册, 类必须继承'DVEventBusClassDelegate' 和 实现'event_classMethod_map'
[DVEventSubscriber registerClassEvents:[DemoService class]];
```

##### 2.2.2 第二种订阅类事件方法: 
##### 也可以用下面方法订阅类事件，类不用继承'DVEventBusClassDelegate'， 如果事件多还是建议使用上面方法
```
[DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_LOGIN subscriber:[DemoService class] action:@selector(loginWithUserName:password:success:)];
[DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_ADD subscriber:[DemoService class] action:@selector(addWithA:b:)];
[DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_GET_STRING subscriber:[DemoService class] action:@selector(getString)];
[DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_GET_OBJECT subscriber:[DemoService class] action:@selector(getObject)];
[DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_MUTIL_METHOD subscriber:[DemoService class] action:@selector(mutilMethod1)];
[DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_MUTIL_METHOD subscriber:[DemoService class] action:@selector(mutilMethod2)];
[DVEventSubscriber addClasslEvent:kEVENT_SERVICE_DEMO_MUTIL_METHOD subscriber:[DemoService class] action:@selector(mutilMethod3)];
```

##### 2.3 发布类事件 ：发布类事件是执行类方法
``` 
/*
    发送事件可以同步返回结果, 跟直接调用方法耗时差不多
    多参数传入, 结尾必须加 nil
*/
NSNumber *count = [DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_ADD params:@(1), @(2), nil];

NSString *string = [DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_GET_STRING];

UserModel *user = [DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_GET_OBJECT];


// 发送事件异步回调结果
void(^successBlock)(BOOL) = ^(BOOL status) {
    // 处理程序    
};
[DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_LOGIN params:@"Hello", @"654321", successBlock, nil];


// 发布一个类事件可以顺序执行多个类方法
[DVEventPublisher publishClassEvent:kEVENT_SERVICE_DEMO_MUTIL_METHOD];
```

---
#### 3. 订阅和发布 对象事件 (跟类事件使用方法差不多)
##### 3.1 订阅对象事件 : 事件绑定已实例化后的对象方法
```
@interface Demo() <DVEventBusDelegate> // 继承 'DVEventBusDelegate'

@end


@implementation Demo

/**
    事件 绑定 对象方法
    实现 'DVEventBusDelegate' 的 'event_method_map' 方法
*/
- (NSDictionary<NSString *,NSString *> *)event_method_map {
    return @{
        kEVENT_DEMO_ADD : _sel(@selector(addWithA:b:)),
    };
}


- (NSNumber *)addWithA:(NSNumber *)a b:(NSNumber *)b {
    int ret = [a intValue] + [b intValue];
    return @(ret);
}

@end
```

##### 3.2.1 注册对象事件
```
// 用这个方法注册, 对象必须继承'DVEventBusDelegate' 和 实现'event_method_map'
[DVEventSubscriber registerEvents:object];
```

##### 3.2.2 第二种订阅对象事件方法: 
##### 也可以用下面方法订阅对象事件，对象不用继承'DVEventBusDelegate'， 如果事件多还是建议使用上面方法
```
[DVEventSubscriber addEvent:kEVENT_DEMO_ADD subscriber:object action:@selector(addWithA:b:)];
```

##### 3.3 发布对象事件 ：发布对象事件是执行对象方法
```
// 同步返回结果, 若有参数, 结尾要nil
NSNumber *count = [DVEventPublisher publishEvent:kEVENT_DEMO_ADD params:@(1), @(2), nil];
```


---
### 3.如何导入项目
1. 编译DVEventBusKitShell


![](https://user-gold-cdn.xitu.io/2020/4/16/17180fe91e6c9c85?w=381&h=42&f=png&s=9663)

2. 生成Framework拖入项目

![](https://user-gold-cdn.xitu.io/2020/4/16/1718104a7cf1b929?w=588&h=110&f=png&s=14248)

3. 项目 Target -> Build Settings -> Linking ->Other Linker Flags 添加参数:  -all_load  -ObjC
![](https://user-gold-cdn.xitu.io/2020/3/19/170f094060959da9?w=800&h=186&f=png&s=22698)

4. 在PCH文件导入
```
#import <DVEventBusKit/DVEventBusKit.h>
```




*** 
### 4.结语: 
> github地址: https://github.com/shidavid/DVEventBus   
谢谢大家观看,有兴趣麻烦点个星星关注下 😁😁😁
