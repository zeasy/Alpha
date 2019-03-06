//
//  ALPHAWebSocketServerNode.m
//  Alpha
//
//  Created by easy on 2019/3/1.
//

#import "ALPHAWebSocketServerNode.h"
#import "ALPHAStatusBarNotification.h"
#import "ALPHA_MBWebSocketServer.h"
#import "ALPHAManager.h"

#import "ALPHASerialization.h"

@interface ALPHAWebSocketServerNode() <ALPHA_MBWebSocketServerDelegate>{
    
}

@property (atomic, strong) ALPHA_MBWebSocketServer *server;

@property (nonatomic, strong) ALPHAStatusBarNotification *notification;
@end

@implementation ALPHAWebSocketServerNode

- (BOOL)isActive
{
    return self.server.port > 0;
}

- (void)start {
    self.server = [[ALPHA_MBWebSocketServer alloc] initWithDelegate:self];

    NSUInteger port = (int)[NSDate timeIntervalSinceReferenceDate] % 10000 + 5000;
    NSError *err = nil;
    BOOL b = [self.server acceptOnPort:port error:&err];
    
    if (b) {
        self.notification = [[ALPHAManager defaultManager] displayNotificationWithMessage:[self serverStatusText] completion:nil];
    } else {
        self.notification = [[ALPHAManager defaultManager] displayNotificationWithMessage:@"WebSocket Setup Error" completion:nil];
    }
}

- (void) stop {
    [self.server disconnect];

    self.server = nil;
    
    [self.notification dismissNotificationWithCompletion:^
     {
     self.notification = nil;
     }];
}


- (NSString *)serverStatusText
{
    return [NSString stringWithFormat:@"WebSocket Server Active: %ld - Accept at Port:%ld", (long)self.server.clientCount, self.server.port];
}

- (void)webSocketServer:(ALPHA_MBWebSocketServer *)webSocketServer didAcceptConnection:(ALPHA_GCDAsyncSocket *)connection {
    self.notification.notificationLabel.text = [self serverStatusText];
}

- (void)webSocketServer:(ALPHA_MBWebSocketServer *)webSocketServer clientDisconnected:(ALPHA_GCDAsyncSocket *)connection {
    self.notification.notificationLabel.text = [self serverStatusText];
}

- (void)webSocketServer:(ALPHA_MBWebSocketServer *)webSocket didReceiveData:(NSData *)data fromConnection:(ALPHA_GCDAsyncSocket *)connection {
    NSError *err;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    if(!err && object) {
        NSString *action = object[@"action"];
        NSString *event = object[@"event"];
        NSDictionary *params = object[@"params"] ?: @{};
        
        if([@"query" isEqualToString:action] && event) {
            ALPHARequest *request = [ALPHARequest requestWithIdentifier:event parameters:params];
            [self.source dataForRequest:request completion:^(id object, NSError *error) {
                if(!error) {
//                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
//                    NSDictionary *resp = [object codableProperties];
//                    NSData *data = [NSCoder coder];
                    NSDictionary *resp = @{@"code":@0};
                    NSData *data = [NSJSONSerialization dataWithJSONObject:resp options:0 error:0];
                    [connection writeWebSocketFrame:data];
                }
            }];
        }
        
    }
}

- (void)webSocketServer:(ALPHA_MBWebSocketServer *)webSocketServer couldNotParseRawData:(NSData *)rawData fromConnection:(ALPHA_GCDAsyncSocket *)connection error:(NSError *)error {}

@end
