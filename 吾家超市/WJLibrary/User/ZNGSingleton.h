//
//  ZNGSingleton.h
//  单例模式
//  Created by iMac15 on 2017/1/13.
//  Copyright © 2017年 iMac15. All rights reserved.
//

#define ZNGSingletonH(name) + (instancetype)name;


#if  __has_feature(objc_arc)
#define ZNGSingletonM(name) \
static id _instance; \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
} \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#else
#define ZNGSingletonM(name) \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
} \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (NSUInteger)retainCount \
{ \
return 1; \
} \
\
- (id)retain \
{ \
return _instance; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (id)autorelease \
{ \
return _instance; \
}

#endif
