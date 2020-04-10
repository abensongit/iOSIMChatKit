
#import "CFCBaseCoreViewController.h"
#import "SSChatMessagelLayout.h"

@interface SSChatController : CFCBaseCoreViewController

// 单聊 群聊
@property(nonatomic,assign) SSChatConversationType chatType;

// 会话id
@property (nonatomic, strong) NSString *sessionId;

// 名字
@property (nonatomic, strong) NSString *titleString;

@end
