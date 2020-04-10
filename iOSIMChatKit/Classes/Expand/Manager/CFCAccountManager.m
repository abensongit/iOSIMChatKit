//
//  CFCAccountManager.m
//  iOSIMChatKit
//
//  Created by fangyuan on 2020/2/26.
//  Copyright © 2020 iosimkit. All rights reserved.
//

#import "CFCAccountManager.h"
#import "CFCDocumentManager.h"

static  NSString *KEY_MODEL_ACCOUNT   = @"account";
static  NSString *KEY_MODEL_PASSWORD  = @"password";

@implementation CFCAccountModel : NSObject

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    if(self = [super init]) {
        _account   = [aDecoder decodeObjectForKey:KEY_MODEL_ACCOUNT];
        _password  = [aDecoder decodeObjectForKey:KEY_MODEL_PASSWORD];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    [aCoder encodeObject:_account  forKey:KEY_MODEL_ACCOUNT];
    [aCoder encodeObject:_password forKey:KEY_MODEL_PASSWORD];
}

@end


@implementation CFCAccountManager

+ (instancetype)shareAccountManager
{
    static CFCAccountManager *account = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[CFCAccountManager alloc] init];
    });
    return account;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _filePath  = [[CFCDocumentManager getAPPDocumentPath] stringByAppendingPathComponent:@"account_login_data"];
        [self readLocalDatas];
    }
    return self;
}


-(void)setAccountModel:(CFCAccountModel *)accountModel
{
    _accountModel = accountModel;
    [self saveLocalDatas];
}

- (void)readLocalDatas
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:_filePath]){
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:_filePath];
        _accountModel = [object isKindOfClass:[CFCAccountModel class]] ? object : nil;
    }
}

-(void)saveLocalDatas
{
    [NSKeyedArchiver archiveRootObject:_accountModel toFile:_filePath];
}


@end

