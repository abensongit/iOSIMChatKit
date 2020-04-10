

#import "CFCLoginViewController.h"

@interface CFCLoginViewController () <UITextFieldDelegate> {
    UIView *textFieldContainers[2];
    UITextField *textFieldArray[2];
}
@end

@implementation CFCLoginViewController

#pragma mark -
#pragma mark 事件处理 - 登录按钮
- (void)pressLoginButtonAction:(id)sender
{
    CFCAccountModel *model = [CFCAccountModel new];
    model.account = @"13540033103";
    model.password = @"aaaa1111";
    [CFCAccountManager shareAccountManager].accountModel = model;
    
    // 框架类型
    if(self.rootManagerType == ManagerTypeAll){
        [NOTIFICATION_DEF_CENTER postNotificationName:kNotificationUserLoginStatusChange
                                               object:@(YES)];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark -
#pragma mark 构造函数
- (instancetype)init
{
    if(self = [super init]){
        _rootManagerType = ManagerTypeAll;
    }
    return self;
}

#pragma mark 加载视图
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    TPKeyboardAvoidingScrollView *container = ({
        TPKeyboardAvoidingScrollView *scrollView = [[TPKeyboardAvoidingScrollView alloc] init];
        [self.view addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        scrollView;
    });
    [self.view addSubview:container];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [container addSubview:titleLabel];
    [titleLabel setFrame:CGRectMake(0, 100, width, 120)];
    [titleLabel setTextColor:COLOR_HEXSTRING(@"#007AFF")];
    [titleLabel setText:@"AYOU"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"Snell Roundhand" size:60]];
    
    NSArray *textArr = @[ @"请输入账号...", @"请输入密码..." ];
    for(NSInteger i = 0; i < textArr.count; ++i) {
        UIView *textFieldBackView = [[UIView alloc] init];
        [textFieldBackView setFrame:CGRectMake(50, 200+35+i*60, width - 100, 40)];
        [textFieldBackView setBackgroundColor:[UIColor whiteColor]];
        [container addSubview:textFieldBackView];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(0, 0, textFieldBackView.frame.size.width,textFieldBackView.frame.size.height);
        textField.placeholder = textArr[i];
        textField.textColor = [UIColor blackColor];
        textField.textAlignment = NSTextAlignmentLeft;
        [textFieldBackView addSubview:textField];
        
        textField.font = [UIFont systemFontOfSize:16];
        textField.delegate = self;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        if(i==0) {
            textFieldArray[i].keyboardType = UIKeyboardTypeNumberPad;
        } else {
            textFieldArray[i].secureTextEntry = YES;
        }

        UIView *line = [[UIView alloc]init];
        line.frame = CGRectMake(0, 39, textFieldBackView.frame.size.width, 0.5);
        line.backgroundColor = [UIColor lightGrayColor];
        [textFieldBackView addSubview:line];
        
        textFieldArray[i] = textField;
        textFieldContainers[i] = textFieldBackView;
    }
    
    // 登陆
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(width*0.25f, height * 0.5f, width*0.5f, 45);
    loginBtn.tag = 100;
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = loginBtn.frame.size.height/2;
    loginBtn.backgroundColor = COLOR_HEXSTRING(@"#007AFF");
    [loginBtn setTitle:@"登    陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(pressLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:loginBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark -
#pragma mark 设置导航条是否隐藏
- (BOOL)prefersNavigationBarHidden
{
    return YES;
}


#pragma mark -
// 这里只对长度做检查
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length] == 0){
        return YES;
    }
    
    if (textField == textFieldArray[0] && range.location < 11){
        return YES;
    }
    
    if(textField == textFieldArray[1] && range.location < 16){
        return YES;
    }
    
    else{
        return NO;
    }
}


@end
