//
//  UserModel.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

// token
@property (strong, nonatomic, readwrite) NSString *token;

// userId
@property (assign, nonatomic, readwrite) NSInteger userId;

@end

NS_ASSUME_NONNULL_END
