//
//  ResponseModel.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResponseModel : NSObject

// 状态码
@property (assign, nonatomic, readwrite) NSInteger code;

// 是否成功
@property (assign, nonatomic, readwrite) BOOL isSuccess;

@end

NS_ASSUME_NONNULL_END
