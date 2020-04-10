
#import "CFCDocumentManager.h"

@implementation CFCDocumentManager

+ (NSString *)getAppTempPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)getAPPDocumentPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *documentPath = [path  stringByAppendingPathComponent:@"OC"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:documentPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return documentPath;
}

+ (NSString *)getUserDocumentPath
{
    NSString *userPath = [[CFCDocumentManager getAPPDocumentPath] stringByAppendingPathComponent:@"userId"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:userPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:userPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return userPath;
}

+ (NSString *)getAccountDocumentPath:(NSString *)suffix
{
    NSString *userPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                          
    if (![[NSFileManager defaultManager] fileExistsAtPath:userPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:userPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return userPath;
}

@end

