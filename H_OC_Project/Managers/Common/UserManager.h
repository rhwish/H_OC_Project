//
//  UserManager.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserManager : NSObject

// user model
@property(nonatomic, strong, readwrite, nullable) UserModel *user;

// 语言简码
@property(nonatomic, strong, readwrite) NSString *locale;

// 语言和地区简码
@property (nonatomic, strong, readwrite) NSString *fullLocale;


// instance
+ (UserManager *)shareInstance;

@end

NS_ASSUME_NONNULL_END
