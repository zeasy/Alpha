//
//  YztAlphaManager.m
//  YztAlpha
//
//  Created by easy on 2019/2/27.
//

#import "YztAlphaManager.h"
#import <UIKit/UIKit.h>


@implementation YztAlphaManager

+(instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void) setup {    
    dispatch_async(dispatch_get_main_queue(), ^{
        Class ALPHAManager = NSClassFromString(@"ALPHAManager");
        id manager = [ALPHAManager performSelector:@selector(defaultManager)];
        [manager performSelector:@selector(integrate)];
    });
    
}

@end
