
#import <UIKit/UIKit.h>

typedef void (^SSChatLocationBlock)(NSDictionary *locationDic, NSError *error);

@interface SSChatLocationController : UIViewController

@property(nonatomic,copy)SSChatLocationBlock locationBlock;

@end


