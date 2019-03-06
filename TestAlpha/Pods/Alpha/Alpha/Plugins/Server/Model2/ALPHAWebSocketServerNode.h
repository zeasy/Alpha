//
//  ALPHAWebSocketServerNode.h
//  Alpha
//
//  Created by easy on 2019/3/1.
//

#import <Foundation/Foundation.h>
#import "ALPHADataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface ALPHAWebSocketServerNode : NSObject


@property (nonatomic, readonly) BOOL isActive;

@property (atomic, strong) id<ALPHADataSource> source;

- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
