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
@property (nonatomic, strong) NSTimer        *reConnectTimer;
@property (nonatomic, assign) NSTimeInterval reConnectTimeInterval;
@property (nonatomic, assign) NSUInteger     tempReConnectNum;
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
    _reConnectTimeInterval = 1;
}

- (void)connectRetry {
    [self connectWithURL:self.webSocket.url.absoluteString];
    self.tempReConnectNum ++;
    if (self.tempReConnectNum>5) {
        [self cancelReconnectTimmer];
        self.reConnectTimeInterval *= 2;
        self.tempReConnectNum = 0;
    }
    
}
- (void)startReconnectTimer {
    if (!self.reConnectTimer) {
        self.reConnectTimer = [NSTimer timerWithTimeInterval:self.reConnectTimeInterval target:self selector:@selector(connectRetry) userInfo:nil repeats:YES];
        [[NSRunLoop  currentRunLoop] addTimer:self.reConnectTimer forMode:NSRunLoopCommonModes];
        [self.reConnectTimer fire];
    }
}

- (void)cancelReconnectTimmer {
    [self.reConnectTimer invalidate];
    self.reConnectTimer = nil;
}

- (void)connectWithURL:(NSString*)url {
    NSAssert(url.length>0, @"url不能为空");
    
//    if (_webSocket == nil || _webSocket.readyState != SR_CLOSED) {
//        [_webSocket close];
//    }
    [_webSocket close];
    _webSocket = nil;
    _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:url]];
    _webSocket.delegate = self;
    [_webSocket open];
    
}


- (void)sendMsg:(IFQBaseIMMsg*)msg {
    if (!msg || self.webSocket.readyState != SR_OPEN) {
        return;
    }
    IFQBaseIMMsgType msgType = msg.type;
    switch (msgType) {
        case IFQBaseIMMsgTypeText:  // 文本
        case IFQBaseIMMsgTypeLogin: // 登录
        {
            [self.webSocket send:msg.contentWrap];
        }
            break;
        case IFQBaseIMMsgTypeImage:
        {
            
        }
            break;
        case IFQBaseIMMsgTypeVideo:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)close {
    [self cancelReconnectTimmer];
    [self.webSocket close];
}

@end

@implementation IFQWebSocketClient (SRWebSocketDelegate)

#pragma mark SRWebSocket Delegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"%s",__func__);
    NSLog(@"===resp msg ==  %@ =====",message);
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"%s",__func__);
    [self cancelReconnectTimmer];
    self.reConnectTimeInterval = 1;
    self.tempReConnectNum = 0;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"%s",__func__);
    [self startReconnectTimer];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"%s",__func__);
    if (!wasClean) {
        [self startReconnectTimer];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSLog(@"%s",__func__);
}

// Return YES to convert messages sent as Text to an NSString. Return NO to skip NSData -> NSString conversion for Text messages. Defaults to YES.
- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket {
    return YES;
}

- (void)dealloc {
    [_reConnectTimer invalidate];
    _reConnectTimer = nil;
}

@end
