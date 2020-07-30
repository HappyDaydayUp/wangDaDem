//
//  AppMacro.h
//  ZZArchitectureDemo
//
//  Created by oldliu on 2020/4/29.
//  Copyright © 2020 oldliu. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h



#define kKeyWindow          [UIApplication sharedApplication].delegate.window
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width //屏幕宽度
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height //屏幕高度

#define RGB(R, G, B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define isIPad ([[UIDevice currentDevice] userInterfaceIdiom]  == UIUserInterfaceIdiomPad)
#define kIs_iPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)//是否是iphone

#define SCREEN_MAX_LENGTH (MAX(kScreenWidth, kScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(kScreenWidth, kScreenHeight))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define kIs_iPhoneX (kIs_iPhone && (SCREEN_MAX_LENGTH == 812.0||SCREEN_MAX_LENGTH == 896.0))


//#define kSafeAreaTopHeight (kIs_iPhoneX?88 : 64)
#define kNavBarHeight 44 //导航栏高度44
#define kTabbarHeight 49 //导航栏高度44
#define kStatusHeight    (kIs_iPhoneX ? 44 : 20)//状态栏高度
#define kSafeAreaBottomHeight (kIs_iPhoneX? 34 : 0) //底部安全高度
#define KBottomBarHeight   (kIs_iPhoneX?(34+49):49) //tabbar + 底部安全高度
#define kTopBarHeight (kIs_iPhoneX ? 88 : 64) //导航栏 + 状态栏高度
#define kNavBarAndStatusBarHeight (kIs_iPhoneX ? 88 : 64)





#define kFont(x)   [UIFont boldSystemFontOfSize:x]
#define kFontBold(x)   [UIFont boldSystemFontOfSize:x]
#define kTitleColor [UIColor redColor]
#define kTintClolor [UIColor yellowColor]




//--------------沙盒目录文件路径---------------
// 获取沙盒主目录路径
#define LXSBPath_Home = NSHomeDirectory();
//获取沙盒 Document
#define LXSBPath_Document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Library
#define LXSBPath_Library [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//获取沙盒 Cache
#define LXSBPath_Cache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//获取temp
#define LXSBPath_Temp NSTemporaryDirectory()





//单例宏
#define OBJC_DEF_SINGLETON(className) \
+ (className*) shared##className ;\
+ (instancetype) alloc __attribute__((unavailable("alloc not available, call instance instead")));\
+ (instancetype) new __attribute__((unavailable("new not available, call instance instead")));


#define OBJC_IMPL_SINGLETON(className) \
\
+ (className *)shared##className  { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[super alloc] init]; \
}); \
return shared##className; \
}


//解决打印输出不全的问题
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);


#endif /* AppMacro_h */
