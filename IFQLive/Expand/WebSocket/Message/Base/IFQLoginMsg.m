//
//  IFQLoginMsg.m
//  IFQLive
//
//  Created by taizi on 16/10/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQLoginMsg.h"
#import <YYModel/YYModel.h>

@interface IFQLoginMsg ()
@property (nonatomic, strong) NSString *usrName;
@property (nonatomic, strong) NSString *password;
@end

@implementation IFQLoginMsg

+ (instancetype)loginMsgWithUsrName:(NSString*)usrName password:(NSString*)password {
    IFQLoginMsg *msg = [[self alloc] init];
    msg.type         = IFQBaseIMMsgTypeLogin;
    msg.usrName      = usrName;
    msg.password     = password;
    return msg;
}

- (NSString*)contentWrap {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(self.type) forKey:@"type"];
    [param setObject:self.usrName            forKey:@"usrname"];
    [param setObject:self.password           forKey:@"password"];
    return [param yy_modelToJSONString];
}

@end
