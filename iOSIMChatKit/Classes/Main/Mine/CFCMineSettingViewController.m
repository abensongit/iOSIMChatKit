
#import "CFCMineSettingViewController.h"

@interface CFCMineSettingViewController ()

@end

@implementation CFCMineSettingViewController


#pragma mark -
#pragma mark 加载视图
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(width * 0.25f, height * 0.5, width * 0.5f, 45);
    loginBtn.tag = 100;
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = loginBtn.frame.size.height/2;
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

-(void)buttonPressed:(UIButton *)sender
{
    [self alertPrompTitle:@"确认退出?"
                  message:@"\n退出登录后数据会保存"
        cancleActionTitle:@"取消"
        cancleActionBlock:nil
            okActionTitle:@"确认"
            okActionBlock:^(NSString *content) {
        [NOTIFICATION_DEF_CENTER postNotificationName:kNotificationUserLoginStatusChange object:@(NO)];
    }];
}

@end
