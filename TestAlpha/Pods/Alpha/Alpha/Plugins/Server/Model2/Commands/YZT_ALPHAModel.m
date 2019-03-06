//
//  YZT_ALPHAModel.m
//  Alpha
//
//  Created by easy on 2019/3/6.
//

#import "YZT_ALPHAModel.h"

@implementation YZT_ALPHAModel

- (instancetype)initWithIdentifier:(NSString *)identifier {
    self = [super initWithIdentifier:identifier];
    if (self) {
        self.code = 0;
        self.message = @"";
        self.data = [NSMutableDictionary dictionary];
        self.timestamp = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

@end
