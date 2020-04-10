
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 展示类型
 */
typedef NS_ENUM(NSInteger,CFCRootManagerType) {
    ManagerTypeAll = 1, // 全部界面需要登录展示的
    ManagerTypePart, // 部分页面需要登录展示的
};

/**
 * 以类族的模式管理 CFCRootAllOfManager + CFCRootPartOfManager
 */
@interface CFCRootManager : NSObject
@property(nonatomic, strong) NSArray *authIndexs;
@property(nonatomic, assign) NSUInteger selectedIndex;
+ (instancetype)shareRootManager:(CFCRootManagerType)type;
@end

/**
 * 全部界面需要登录显示
 */
@interface CFCRootAllOfManager : CFCRootManager
+ (CFCRootAllOfManager *)shareRootAllOfManager;
@end

/**
 * 部分界面需要登录显示
 */
@interface CFCRootPartOfManager : CFCRootManager <UITabBarControllerDelegate>
+ (CFCRootPartOfManager *)shareRootPartOfManager;
@end

NS_ASSUME_NONNULL_END
