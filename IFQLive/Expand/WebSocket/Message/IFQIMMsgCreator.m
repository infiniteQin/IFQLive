//
//  IFQIMMsgCreator.m
//  IFQLive
//
//  Created by taizi on 16/10/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQIMMsgCreator.h"
#import "IFQTextMsg.h"
#import "IFQLoginMsg.h"

@implementation IFQIMMsgCreator

+ (IFQBaseIMMsg*)textMsg:(NSString*)text {
    return [IFQTextMsg textMsgWithText:text];
}

+ (IFQBaseIMMsg*)loginMsgWithUsrName:(NSString*)usrName password:(NSString*)password {
    return [IFQLoginMsg loginMsgWithUsrName:usrName password:password];
}

@end
