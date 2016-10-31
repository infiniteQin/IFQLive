//
//  IFQTextMsg.h
//  IFQLive
//
//  Created by taizi on 16/10/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFQBaseIMMsg.h"

@interface IFQTextMsg : IFQBaseIMMsg

+ (instancetype)textMsgWithText:(NSString*)text toUsr:(NSString*)toUsr;

@end
