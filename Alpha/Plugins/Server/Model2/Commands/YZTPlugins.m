//
//  YZTPlugins.m
//  Alpha
//
//  Created by easy on 2019/3/6.
//

#import "YZTPlugins.h"
#import "YZTDeviceStatusSource.h"

@implementation YZTPlugins


- (instancetype)init
{
    self = [super initWithIdentifier:@"yzt.plugins"];
    
    if (self)
        {
        
        [self registerSource:[YZTDeviceStatusSource new]];
        }
    
    return self;
}

@end
