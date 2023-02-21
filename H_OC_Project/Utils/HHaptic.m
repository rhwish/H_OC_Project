//
//  HHaptic.m
//  Her.AI
//
//  Created by RHFlower on 2023/2/20.
//

#import "HHaptic.h"

@implementation HHaptic

+ (void)impactFeedback {
    UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: UIImpactFeedbackStyleLight];
    [generator prepare];
    [generator impactOccurred];
}

@end
