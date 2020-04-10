//
//  AppDelegate.m
//  iOSIMChatKit
//
//  Created by fangyuan on 2020/2/25.
//  Copyright © 2020 iosimkit. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Options.h"
#import "SSChatIMEmotionModel.h"

@interface AppDelegate ()

@property(nonatomic,strong)SSChartEmotionImages *emotion;

@end

@implementation AppDelegate

#pragma mark -
#pragma mark 初始化配置
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CFCLog(@"程序开始");

    // 聊天表情
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.emotion = [SSChartEmotionImages ShareSSChartEmotionImages];
        [self.emotion initEmotionImages];
        [self.emotion initSystemEmotionImages];
    });
    
    return [self application:application didLaunchWithOptions:launchOptions];
}

@end
