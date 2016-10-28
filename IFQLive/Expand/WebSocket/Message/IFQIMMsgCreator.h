//
//  IFQIMMsgCreator.h
//  IFQLive
//
//  Created by taizi on 16/10/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFQBaseIMMsg.h"

@interface IFQIMMsgCreator : NSObject

+ (IFQBaseIMMsg*)textMsg:(NSString*)text;

+ (IFQBaseIMMsg*)loginMsgWithUsrName:(NSString*)usrName password:(NSString*)password;

@end
