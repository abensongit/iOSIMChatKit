
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCAccountModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;

@end


@interface CFCAccountManager : NSObject

+ (instancetype)shareAccountManager;

@property(nonatomic, strong) NSString *filePath;

@property(nonatomic, strong, nullable) CFCAccountModel *accountModel;

@end

NS_ASSUME_NONNULL_END
