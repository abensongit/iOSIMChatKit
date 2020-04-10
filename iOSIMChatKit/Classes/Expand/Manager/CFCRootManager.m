
#import "CFCRootManager.h"
#import "AppDelegate.h"
#import "AppViewController.h"
#import "CFCAccountManager.h"
#import "CFCLoginViewController.h"


@implementation CFCRootManager

+ (instancetype)shareRootManager:(CFCRootManagerType)type
{
    switch (type) {
        case ManagerTypeAll: {
            return [CFCRootAllOfManager shareRootAllOfManager];
        }
            break;
        case ManagerTypePart: {
            return [CFCRootPartOfManager shareRootPartOfManager];
        }
            break;
        default: {
            return nil;
        }
    }
}

@end


/**
 * 全部界面需要显示
 */
@implementation CFCRootAllOfManager

+ (CFCRootAllOfManager *)shareRootAllOfManager
{
    static CFCRootAllOfManager *allRootInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        allRootInstance = [[CFCRootAllOfManager alloc] init];
    });
    return allRootInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [NOTIFICATION_DEF_CENTER addObserver:self
                                    selector:@selector(loginStateChange:)
                                        name:kNotificationUserLoginStatusChange
                                      object:nil];
        
        CFCAccountModel *model = [CFCAccountManager shareAccountManager].accountModel;
        if(model.account.length && model.password.length){
            [self initalizeRootController:YES];
        } else {
            [self initalizeRootController:NO];
        }
    }
    return self;
}

- (void)loginStateChange:(NSNotification *)noti
{
    BOOL isLogin = [noti.object boolValue];
    [self initalizeRootController:isLogin];
}

- (void)initalizeRootController:(BOOL)isLogin
{
    if(isLogin == NO) {
        [CFCAccountManager shareAccountManager].accountModel = nil;
        CFCLoginViewController *viewContrller = [CFCLoginViewController new];
        viewContrller.rootManagerType = ManagerTypeAll;
        CFCNavigationController *rootViewController = [[CFCNavigationController alloc] initWithRootViewController:viewContrller];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.window.rootViewController = rootViewController;
    } else {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        AppViewController *rootViewController = [AppViewController new];
        appDelegate.window.rootViewController = rootViewController;
    }
}

@end


/**
 * 部分界面需要登录显示
 */
@implementation CFCRootPartOfManager
+ (CFCRootPartOfManager *)shareRootPartOfManager
{
    static CFCRootPartOfManager *partRootInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        partRootInstance = [[CFCRootPartOfManager alloc]init];
    });
    return partRootInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [NOTIFICATION_DEF_CENTER addObserver:self
                                    selector:@selector(loginStateChange:)
                                        name:kNotificationUserLoginStatusChange
                                      object:nil];
        
        AppViewController *rootViewController = [AppViewController new];
        rootViewController.delegate = self;
        rootViewController.selectedIndex = self.selectedIndex;
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.window.rootViewController = rootViewController;
    }
    return self;
}

- (void)setAuthIndexs:(NSArray *)authIndexs
{
    [super setAuthIndexs:authIndexs];
    
    [self setSelectedViewController:self.selectedIndex authIndexs:authIndexs];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    
    [self setSelectedViewController:selectedIndex authIndexs:self.authIndexs];
}

- (void)setSelectedViewController:(NSUInteger)selectedIndex authIndexs:(NSArray *)authIndexs
{
    NSMutableArray<NSNumber *> *indexs = [NSMutableArray<NSNumber *> array];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UITabBarController *rootViewController = (UITabBarController *)appDelegate.window.rootViewController;
    for (NSInteger index = 0; index < rootViewController.viewControllers.count; index ++) {
        NSNumber *obj = [NSNumber numberWithInteger:index];
        if (![authIndexs containsObject:obj]) {
            [indexs addObject:obj];
        }
    }
    
    if ([indexs containsObject:[NSNumber numberWithInteger:self.selectedIndex]]) {
        rootViewController.selectedIndex = self.selectedIndex;
    } else {
        rootViewController.selectedIndex = indexs.firstObject.integerValue;
    }
}

/**
 * 这类界面不一定在登出后做这样的处理 大家可以根据实际app的设计情况控制
 * 我这边是直接全部重新加载主体界面 有些app登出后并不是展示到首页的
 */
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL isLogin = [notification.object boolValue];
    if(isLogin == NO) {
        [CFCAccountManager shareAccountManager].accountModel = nil;
        AppViewController *rootViewController = [AppViewController new];
        rootViewController.delegate = [[self class] shareRootPartOfManager];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.window.rootViewController = rootViewController;
        [self setSelectedViewController:self.selectedIndex authIndexs:self.authIndexs];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger selectIndex = [tabBarController.viewControllers indexOfObject:viewController];
    CFCAccountModel *accountModel = [CFCAccountManager shareAccountManager].accountModel;
    NSInteger content = -1;
    
    for(NSNumber *value in self.authIndexs){
        NSInteger index = value.integerValue;
        if(selectIndex == index){
            content = index;
            break;
        }
    }
    
    if(content != -1 && !(accountModel.account.length && accountModel.password.length)){
        CFCLoginViewController *viewController = [CFCLoginViewController new];
        viewController.rootManagerType = ManagerTypePart;
        CFCNavigationController *authVC = [[CFCNavigationController alloc] initWithRootViewController:viewController];
        [tabBarController presentViewController:authVC animated:YES completion:nil];
        return  NO;
    } else {
        return YES;
    }
}

@end

