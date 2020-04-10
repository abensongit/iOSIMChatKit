//
//  AppDelegate+Options.m
//  iOSIMChatKit
//
//  Created by fangyuan on 2020/2/26.
//  Copyright © 2020 iosimkit. All rights reserved.
//

#import "AppDelegate+Options.h"
#import "AppViewController.h"

@implementation AppDelegate (Options)

- (BOOL)application:(UIApplication *)application didLaunchWithOptions:(NSDictionary *)launchOptions
{
    // 设置根部窗口
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    [self.window setBackgroundColor:COLOR_SYSTEM_MAIN_UI_BACKGROUND_DEFAULT];
    [self.window makeKeyAndVisible];
    
    // 根视图控制器
    [CFCRootManager shareRootManager:ManagerTypeAll];

    return YES;
}

@end

