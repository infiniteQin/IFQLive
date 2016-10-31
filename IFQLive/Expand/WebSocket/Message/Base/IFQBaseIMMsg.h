//
//  IFQBaseIMMsg.h
//  IFQLive
//
//  Created by taizi on 16/10/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFQMsgFile.h"

typedef NS_ENUM(NSUInteger,IFQBaseIMMsgType) {
    IFQBaseIMMsgTypeText  = 1,
    IFQBaseIMMsgTypeImage = 2,
    IFQBaseIMMsgTypeVideo = 3,
    IFQBaseIMMsgTypeLogin = 1000
};

typedef NS_ENUM(NSUInteger,IFQBaseIMMsgStatus) {
    IFQBaseIMMsgStatusNone,
    IFQBaseIMMsgStatusSending,
    IFQBaseIMMsgStatusSendSucc,
    IFQBaseIMMsgStatusSendFail,
};

@interface IFQBaseIMMsg : NSObject

@property (nonatomic, assign) IFQBaseIMMsgType    type;

@property (nonatomic, assign) IFQBaseIMMsgStatus  status;

@property (nonatomic, copy)   NSString            *content;

@property (nonatomic, strong) IFQMsgFile          *file;

@property (nonatomic, copy, readonly)   NSString            *contentWrap;

@property (nonatomic, copy) NSString   *toUsr;

@end
