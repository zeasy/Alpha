//
//  ALPHAServerNode.h
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "ALPHADataSource.h"

@interface ALPHAServerNode : NSObject

@property (nonatomic, readonly) BOOL isActive;

@property (atomic, strong) id<ALPHADataSource> source;

- (void)start;
- (void)stop;

@end
