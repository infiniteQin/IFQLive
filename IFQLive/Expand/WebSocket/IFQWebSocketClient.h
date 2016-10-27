//
//  IFQWebSocketClient.h
//  IFQLive
//
//  Created by taizi on 16/10/14.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SocketRocket.h>

@protocol IFQWebSocketClientDelegate <NSObject>

- (void)didSendMsgFailed:(id)message;

@end

@interface IFQWebSocketClient : NSObject


+ (instancetype)sharedInstance;

- (void)connectWithURL:(NSString*)url;

- (void)sendMsg:(id)msg;

@end

@interface IFQWebSocketClient (SRWebSocketDelegate)<SRWebSocketDelegate>

@end

