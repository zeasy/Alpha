//
//  YZT_ALPHAModel.h
//  Alpha
//
//  Created by easy on 2019/3/6.
//

#import "ALPHAModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YZT_ALPHAModel : ALPHAModel

@property (assign) NSUInteger code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSMutableDictionary *data;
@property (assign) NSTimeInterval timestamp;

@end

NS_ASSUME_NONNULL_END
