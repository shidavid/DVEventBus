//
//  DVEventBusDefine.h
//  DVEventBus
//
//  Created by David on 2020/4/13.
//  Copyright © 2020 DVUntilKit. All rights reserved.
//

#ifndef DVEventBusDefine_h
#define DVEventBusDefine_h

#define kEVENT(event) static NSString *const kEVENT_##event = @"kEVENT_"#event;

#define kEVENT_MODULE(module,event) kEVENT(module##_##event)
#define kEVENT_GLOBAL_MODULE(module,event) kEVENT(GLOBAL_##module##_##event)
#define kEVENT_SERVICE_MODULE(module,event) kEVENT(SERVICE_##module##_##event)
#define kEVENT_DAO_MODULE(module,event) kEVENT(DAO_##module##_##event)
#define kEVENT_VM_MODULE(module,event) kEVENT(VM_##module##_##event)

#endif /* DVEventBusDefine_h */
