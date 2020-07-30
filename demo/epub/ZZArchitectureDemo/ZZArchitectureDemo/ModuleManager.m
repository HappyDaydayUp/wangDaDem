#import "ModuleManager.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
#define ALL_MODULE [[ModuleManager sharedInstance] allModules]
#define SWIZZLE_METHOD(m) swizzleMethod(class, @selector(m),@selector(module_##m));

@interface ModuleManager ()

@property (nonatomic, strong) NSMutableArray<id<ModuleProtocol>> *modules;
@end

@implementation ModuleManager

+ (instancetype)sharedInstance {
    static ModuleManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}
- (NSMutableArray<id<ModuleProtocol>> *)modules {
    if (!_modules) {
        _modules = [[NSMutableArray alloc]init];
    }
    return _modules;
    
}
- (void)addModule:(id<ModuleProtocol>) module {
    [self.modules addObject:module];
    
}
- (void)loadModulesWithPlistFile:(NSString *)plistFile {
    
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistFile];
    for (NSString * str in array) {
        id module = [[NSClassFromString(str) alloc]init];
        [self addModule:module];
    }
    
}
- (NSArray<id<ModuleProtocol>> *)allModules {
    return self.modules;
}

@end


@implementation AppDelegate (Module)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SWIZZLE_METHOD(application:willFinishLaunchingWithOptions:);
        SWIZZLE_METHOD(application:didFinishLaunchingWithOptions:);
    });
}

static inline void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method newMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, newMethod);
    
}

- (BOOL)module_application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BOOL result = [self module_application:application willFinishLaunchingWithOptions:launchOptions];
    for (id<ModuleProtocol> module in ALL_MODULE) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }
    return result;
}

- (BOOL)module_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BOOL result = [self module_application:application didFinishLaunchingWithOptions:launchOptions];
    for (id<ModuleProtocol> module in ALL_MODULE) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return result;
}

@end
