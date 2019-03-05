// Originally created by Max Howell in October 2011.
// This class is in the public domain.
//
// ALPHA_MBWebSocketServer accepts client connections as soon as it is instantiated.
// Implementated against: http://tools.ietf.org/id/draft-ietf-hybi-thewebsocketprotocol-10

#import "ALPHA_GCDAsyncSocket.h"

@protocol ALPHA_MBWebSocketServerDelegate;


@interface ALPHA_MBWebSocketServer : NSObject {
    ALPHA_GCDAsyncSocket *socket;
    NSMutableArray *connections;
}

//- (id)initWithPort:(NSUInteger)port delegate:(id<ALPHA_MBWebSocketServerDelegate>)delegate;

- (id)initWithDelegate:(id<ALPHA_MBWebSocketServerDelegate>)delegate;

- (BOOL)acceptOnPort:(uint16_t)port error:(NSError **)errPtr;
- (void) disconnect;
// Sends this data to all open connections. The object must respond to
// webSocketFrameData. We provide implementations for NSData and NSString.
// You may like to, eg: provide implementations for NSDictionary, encoding into a
// JSON string before calling [NSString webSocketFrameData].
- (void)send:(id)object;

@property (nonatomic, readonly) NSUInteger port;
@property (nonatomic, weak) id<ALPHA_MBWebSocketServerDelegate> delegate;
@property (nonatomic, readonly) NSUInteger clientCount;
@end


@protocol ALPHA_MBWebSocketServerDelegate
- (void)webSocketServer:(ALPHA_MBWebSocketServer *)webSocketServer didAcceptConnection:(ALPHA_GCDAsyncSocket *)connection;
- (void)webSocketServer:(ALPHA_MBWebSocketServer *)webSocketServer clientDisconnected:(ALPHA_GCDAsyncSocket *)connection;
- (void)webSocketServer:(ALPHA_MBWebSocketServer *)webSocket didReceiveData:(NSData *)data fromConnection:(ALPHA_GCDAsyncSocket *)connection;

// Data is passed to you as it was received from the socket, ie. with header & masked
// We disconnect the connection immediately after your delegate call returns.
// This always disconnect behavior sucks and should be fixed, but requires more
// intelligent error handling, so feel free to fix that.
- (void)webSocketServer:(ALPHA_MBWebSocketServer *)webSocketServer couldNotParseRawData:(NSData *)rawData fromConnection:(ALPHA_GCDAsyncSocket *)connection error:(NSError *)error;
@end


@interface ALPHA_GCDAsyncSocket (ALPHA_MBWebSocketServer)
- (void)writeWebSocketFrame:(id)object;
@end


@interface NSData (ALPHA_MBWebSocketServer)
- (NSData *)webSocketFrameData;
@end
