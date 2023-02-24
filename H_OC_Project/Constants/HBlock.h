//
//  HBlock.h
//  H_OC_Project
//
//  Created by RHFlower on 2023/2/24.
//

#ifndef HBlock_h
#define HBlock_h

#import <Foundation/Foundation.h>

// 常用Block

// 结果block
typedef void(^CommonResultBlock)(BOOL result);

// 通用操作block
typedef void(^CommonOperationBlock)(NSInteger type, _Nullable id data);


#endif /* HBlock_h */
