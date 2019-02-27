//
//  NSBundle+Yzt.m
//  Alpha
//
//  Created by easy on 2019/2/27.
//  Copyright © 2019 Unified Sense. All rights reserved.
//

#import "NSBundle+Yzt.h"

@implementation NSBundle (Yzt)

-(BOOL) isSpringBoard {
    return [@"com.apple.springboard" isEqualToString:self.infoDictionary[@"CFBundleIdentifier"]];
}
@end
