
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFCDocumentManager : NSObject

/**
 * 获取 app 临时文件路径
 * @return 返回路径
 */
+ (NSString *)getAppTempPath;

/**
 * 获取 app 文件路径
 * @return 返回路径
 */
+ (NSString *)getAPPDocumentPath;

/**
 * 获取当前用户文件夹路径
 * @return 返回路径
 */
+ (NSString *)getUserDocumentPath;

/**
 * 用户文档路径
 * @param suffix 添加后缀
 * @return 返回路径
 */
+ (NSString *)getAccountDocumentPath:(NSString *)suffix;

@end


NS_ASSUME_NONNULL_END
