
#import "CFCMessageMainViewController.h"
#import "SSChatController.h"

@interface CFCMessageMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation CFCMessageMainViewController

#pragma mark 设置状态栏样式类型
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (instancetype)init
{
    if(self = [super init]) {
        _dataSource = [NSMutableArray new];
        [_dataSource addObjectsFromArray:@[@{@"image":@"touxiang1",
                                        @"title":@"神经萝卜",
                                        @"detail":@"王医生你好，我最近老感觉头晕乏力，是什么原因造成的呢？",
                                        @"sectionId":@"13540033103",
                                        @"type":@"1"
                                        },
                                      @{@"image":@"touxiang2",
                                        @"title":@"王医生",
                                        @"detail":@"您好，可以给我发送一份你的体检报告吗？便于我了解情况，谁是给我打电话13540033104",
                                        @"sectionId":@"13540033104",
                                        @"type":@"1"
                                        }]];
    }
    return self;
}

#pragma mark -
#pragma mark 视图生命周期（加载视图）
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 70;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.scrollIndicatorInsets = tableView.contentInset;
        tableView.backgroundColor = SSChatCellColor;
        tableView.backgroundView.backgroundColor = SSChatCellColor;
        if (@available(iOS 11.0, *)){
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
        }
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        tableView;
    });
    self.tableView = tableView;
    self.tableView.mas_key = @"tableView";
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    cell.imageView.image = [UIImage imageNamed:_dataSource[indexPath.row][@"image"]];
    cell.textLabel.text = _dataSource[indexPath.row][@"title"];
    cell.detailTextLabel.text = _dataSource[indexPath.row][@"detail"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SSChatController *vc = [SSChatController new];
    vc.chatType = (SSChatConversationType)[_dataSource[indexPath.row][@"type"] integerValue];
    vc.sessionId = _dataSource[indexPath.row][@"sectionId"];
    vc.titleString = _dataSource[indexPath.row][@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
