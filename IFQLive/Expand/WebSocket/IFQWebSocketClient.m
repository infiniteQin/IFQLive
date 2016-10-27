//
//  IFQWebSocketClient.m
//  IFQLive
//
//  Created by taizi on 16/10/14.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQWebSocketClient.h"

@interface IFQWebSocketClient ()
@property (nonatomic, strong) SRWebSocket *webSocket;
@end

@implementation IFQWebSocketClient

+ (instancetype)sharedInstance {
    static IFQWebSocketClient *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __initConfig];
    }
    return self;
}

- (void)__initConfig {
    
}

- (void)connectWithURL:(NSString*)url {
    NSAssert(url.length>0, @"url不能为空");
    
    if (_webSocket == nil || _webSocket.readyState != SR_CLOSED) {
        [_webSocket close];
    }
    
    _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:url]];
    _webSocket.delegate = self;
    [_webSocket open];
}


- (void)sendMsg:(id)msg {
    
}

@end

@implementation IFQWebSocketClient (SRWebSocketDelegate)

#pragma mark SRWebSocket Delegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"%s",__func__);
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"%s",__func__);
}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"%s",__func__);
}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"%s",__func__);
}
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSLog(@"%s",__func__);
}

// Return YES to convert messages sent as Text to an NSString. Return NO to skip NSData -> NSString conversion for Text messages. Defaults to YES.
- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket {
    return YES;
}

@end
