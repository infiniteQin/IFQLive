//
//  IFQNetworkManager.m
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQNetworkManager.h"
#import <AFNetworking/AFNetworking.h>



@interface IFQNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation IFQNetworkManager

+ (instancetype)manager {
    static IFQNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IFQNetworkManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer.timeoutInterval = 10.;
        //去除NSnull
        if ([_sessionManager.responseSerializer isKindOfClass:[AFJSONResponseSerializer class]]) {
            [(AFJSONResponseSerializer*)_sessionManager.responseSerializer setRemovesKeysWithNullValues:YES];
        }

        NSMutableSet<NSString*> *acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [acceptableContentTypes addObject:@"text/plain"];
        _sessionManager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    }
    return self;
}
- (IFQRequest *)requestWithURL:(NSString *)url
                         paras:(NSDictionary *)parasDict
               completionBlock:(void(^)(IFQResponse *response))completionBlock {
    NSURLSessionDataTask *dataTask = [self.sessionManager POST:url parameters:parasDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#if DEBUG
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"======Response Start======\n%@\n======Response End=======",str);
        }else {
            NSLog(@"======Response Start======\n%@\n======Response End=======",responseObject);
        }
#endif
        if (completionBlock) {
            IFQResponse *resp = [[IFQResponse alloc] init];
            [resp setTask:task];
            resp.responseObj = responseObject;
            resp.isSucc = YES;
            completionBlock(resp);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionBlock) {
            IFQResponse *resp = [[IFQResponse alloc] init];
            [resp setTask:task];
            resp.responseObj = nil;
            resp.isSucc = YES;
            resp.error = error;
            completionBlock(resp);
        }
    }];
    IFQRequest *request = [[IFQRequest alloc] init];
    [request setTask:dataTask];
    return request;
}

@end
