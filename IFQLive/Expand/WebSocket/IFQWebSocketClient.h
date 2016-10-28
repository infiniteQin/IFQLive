//
//  IFQWebSocketClient.h
//  IFQLive
//
//  Created by taizi on 16/10/14.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SocketRocket.h>
#import "IFQBaseIMMsg.h"

@protocol IFQWebSocketClientDelegate <NSObject>

- (void)didSendMsgFailed:(id)message;

@end

@interface IFQWebSocketClient : NSObject


+ (instancetype)sharedInstance;

- (void)connectWithURL:(NSString*)url;

- (void)sendMsg:(IFQBaseIMMsg*)msg;

- (void)close;

@end

@interface IFQWebSocketClient (SRWebSocketDelegate)<SRWebSocketDelegate>

@end

