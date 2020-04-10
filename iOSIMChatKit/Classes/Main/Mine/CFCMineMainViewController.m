
#import "CFCMineMainViewController.h"
#import "CFCMineSettingViewController.h"

@interface CFCMineMainViewController ()

@end

@implementation CFCMineMainViewController

#pragma mark -
#pragma mark 事件处理 - 设置按钮
- (void)pressNavBarRightButtonAction:(id)sender
{
    CFCMineSettingViewController *pushVC = [[CFCMineSettingViewController alloc] init];
    [self.navigationController pushViewController:pushVC animated:YES];
}

#pragma mark -
#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightButtonItem = [self createBarButtonItemWithTitle:@"设置"
                                                                   action:@selector(pressNavBarRightButtonAction:)];
    [self.navigationItem setRightBarButtonItem:rightButtonItem];
}

@end
