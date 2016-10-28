//
//  IFQMsgFile.h
//  IFQLive
//
//  Created by taizi on 16/10/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFQMsgFileExtendInfo-Protocol.h"


@interface IFQMsgFile : NSObject

@property (nonatomic, strong) NSData   *fileData;
@property (nonatomic, strong) NSString *fileUrl;

@property (nonatomic, strong) id<IFQMsgFileExtendInfo>       fileInfo;

@end
