//
//  IFQResponse.h
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFQResponse : NSObject

@property (nonatomic, assign) BOOL     isSucc;
@property (nonatomic, strong) NSObject *responseObj;
@property (nonatomic, strong) NSError  *error;


- (void)setTask:(NSURLSessionDataTask*)task;

@end
