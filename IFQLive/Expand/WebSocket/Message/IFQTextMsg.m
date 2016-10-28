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

+ (instancetype)textMsgWithText:(NSString*)text {
    IFQTextMsg *textMsg = [[self alloc] init];
    textMsg.type = IFQBaseIMMsgTypeText;
    textMsg.content = text;
    
    return textMsg;
}

- (NSString*)contentWrap {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(IFQBaseIMMsgTypeText) forKey:@"type"];
    [param setObject:self.content forKey:@"content"];
    return [param yy_modelToJSONString];
}

@end
