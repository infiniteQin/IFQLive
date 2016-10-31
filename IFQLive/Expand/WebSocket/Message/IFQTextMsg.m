//
//  IFQTextMsg.m
//  IFQLive
//
//  Created by taizi on 16/10/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQTextMsg.h"
#import <YYModel/YYModel.h>

@implementation IFQTextMsg

+ (instancetype)textMsgWithText:(NSString*)text toUsr:(NSString*)toUsr{
    IFQTextMsg *textMsg = [[self alloc] init];
    textMsg.type = IFQBaseIMMsgTypeText;
    textMsg.content = text;
    textMsg.toUsr   = toUsr;
    return textMsg;
}

- (NSString*)contentWrap {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(IFQBaseIMMsgTypeText) forKey:@"type"];
    [param setObject:self.content forKey:@"content"];
    [param setObject:self.toUsr forKey:@"toUsr"];
    return [param yy_modelToJSONString];
}

@end
