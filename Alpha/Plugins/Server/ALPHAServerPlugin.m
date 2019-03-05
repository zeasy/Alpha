//
//  ALPHAServerPlugin.m
//  Alpha
//
//  Created by Dal Rupnik on 16/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAServerPlugin.h"
#import "ALPHAActions.h"
#import "ALPHABonjourConfig.h"
#import "ALPHALocalSource.h"
#import "ALPHAServerNode.h"
#import "ALPHAManager.h"
#import "ALPHACoreAssets.h"

#import "ALPHAWebSocketServerNode.h"

@interface ALPHAServerPlugin ()

//@property (nonatomic, strong) ALPHAServerNode* server;
@property (nonatomic, strong) ALPHAWebSocketServerNode* server;

@end

@implementation ALPHAServerPlugin

#pragma mark - Getters and Setters

//- (ALPHAServerNode *)server
- (ALPHAWebSocketServerNode *)server
{
    if (!_server)
    {
//        _server = [[ALPHAServerNode alloc] init];
        _server = [[ALPHAWebSocketServerNode alloc] init];
        
        ALPHALocalSource* source = [ALPHALocalSource new];
        [source loadSourcesFromPlugins:[ALPHAManager defaultManager].plugins];
        
        _server.source = source;
    }
    
    return _server;
}

#pragma mark - Initialization

- (id)init
{
    self = [super initWithIdentifier:@"com.unifiedsense.alpha.plugin.server"];
    
    if (self)
    {
        ALPHABlockActionItem *touchAction = [ALPHABlockActionItem itemWithIdentifier:@"com.unifiedsense.alpha.plugin.server.activate"];
        touchAction.title = @"Server";
        touchAction.icon = [[ALPHAAssetManager sharedManager] imageWithIdentifier:ALPHAIconRemoteIdentifier color:nil size:CGSizeMake(28.0, 28.0)];
        touchAction.priority = 3000.0;
        touchAction.actionBlock = ^id(id sender)
        {
            [self activateBonjourServer];
            
            return nil;
        };
        
        [self registerAction:touchAction];
                
        //[self registerSource:[ALPHAScreenshotSource new]];
    }
    
    return self;
}

- (void)activateBonjourServer
{
    if (self.server.isActive)
    {
        [self.server stop];
    }
    else
    {
        [self.server start];
    }
}

@end
