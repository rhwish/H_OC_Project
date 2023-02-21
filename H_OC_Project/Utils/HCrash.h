//
//  HCrash.h
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCrash : NSObject

+ (HCrash *)shareCrashManager;

- (void)startCrashGuard;

@end

NS_ASSUME_NONNULL_END
