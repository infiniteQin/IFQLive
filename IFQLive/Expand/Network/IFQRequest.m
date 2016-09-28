//
//  IFQRequest.m
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQRequest.h"

@interface IFQRequest ()
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation IFQRequest

- (void)setTask:(NSURLSessionDataTask *)task {
    _task = task;
}

-(void)cancel {
    if (self.task) {
        [self.task cancel];
    }
}

@end
