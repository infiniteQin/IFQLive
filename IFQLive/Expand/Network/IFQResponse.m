//
//  IFQResponse.m
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQResponse.h"

@interface IFQResponse ()
@property (nonatomic, strong) NSURLSessionDataTask *task;
@end

@implementation IFQResponse

- (void)setTask:(NSURLSessionDataTask*)task {
    _task = task;
}


- (void)setRespResult:(BOOL)isSucc {
    _isSucc = isSucc;
}

- (void)setResponseObj:(NSObject *)responseObj {
    _responseObj = responseObj;
}

- (void)setError:(NSError *)error{
    _error = error;
}

@end
