//
//  AppViewController.m
//  iOSIMChatKit
//
//  Created by fangyuan on 2020/2/26.
//  Copyright © 2020 iosimkit. All rights reserved.
//

#import "AppViewController.h"
#import "CFCMineMainViewController.h"
#import "CFCContactMainViewController.h"
#import "CFCMessageMainViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController

#pragma mark 添加子控制器
- (void)addChildControllers
{
    // 消息
    [self addChildNavigationController:[CFCNavigationController class]
                    rootViewController:[CFCMessageMainViewController class]
                       navigationTitle:STR_NAVIGATION_BAR_TITLE_MESSAGE
                       tabBarItemTitle:STR_TAB_BAR_ITEM_NAME_MESSAGE
                 tabBarNormalImageName:ICON_TAB_BAR_ITEM_MESSAGE_NORMAL
                 tabBarSelectImageName:ICON_TAB_BAR_ITEM_MESSAGE_SELECT
                     tabBarItemEnabled:YES];
    // 通讯录
    [self addChildNavigationController:[CFCNavigationController class]
                    rootViewController:[CFCContactMainViewController class]
                       navigationTitle:STR_NAVIGATION_BAR_TITLE_CONTACT
                       tabBarItemTitle:STR_TAB_BAR_ITEM_NAME_CONTACT
                 tabBarNormalImageName:ICON_TAB_BAR_ITEM_CONTACT_NORMAL
                 tabBarSelectImageName:ICON_TAB_BAR_ITEM_CONTACT_SELECT
                     tabBarItemEnabled:YES];
    
    // 我的
    [self addChildNavigationController:[CFCNavigationController class]
                    rootViewController:[CFCMineMainViewController class]
                       navigationTitle:STR_NAVIGATION_BAR_TITLE_MINE
                       tabBarItemTitle:STR_TAB_BAR_ITEM_NAME_MINE
                 tabBarNormalImageName:ICON_TAB_BAR_ITEM_MINE_NORMAL
                 tabBarSelectImageName:ICON_TAB_BAR_ITEM_MINE_SELECT
                     tabBarItemEnabled:YES];
}

@end
