//
//  YZTDeviceStatusSource.m
//  Alpha
//
//  Created by easy on 2019/3/6.
//

#import "YZTDeviceStatusSource.h"
#import "YZT_ALPHAModel.h"

#import "UIApplication+Information.h"
#import "UIApplication+Version.h"

NSString* const YZTDeviceStatusDataIdentifier = @"yzt.device.status";

@implementation YZTDeviceStatusSource

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addDataIdentifier:YZTDeviceStatusDataIdentifier];
    }
    return self;
}

- (ALPHAModel *)modelForRequest:(ALPHARequest *)request {
    YZT_ALPHAModel *model = [[YZT_ALPHAModel alloc] initWithIdentifier:YZTDeviceStatusDataIdentifier];
//    model.data[@"status"] = @"ok";
    
    model.data[@"cpu_usage"] = @([UIApplication sharedApplication].alpha_cpuUsage);// 1%
    model.data[@"memory_size"] = @([UIApplication sharedApplication].alpha_memorySize); //bytes
    
    return model;
}

@end
