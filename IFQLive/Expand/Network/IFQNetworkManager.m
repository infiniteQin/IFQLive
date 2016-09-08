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
//        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
//        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 10.;
//        _sessionManager.r
//        [_sessionManager.requestSerializer setValue:@"" forHTTPHeaderField:@"User-Agent"];
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

- (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                                   paras:(NSDictionary *)parasDict
                                 success:(void(^)(NSURLSessionDataTask *task,NSObject *parserObject))success
                                 failure:(void(^)(NSURLSessionDataTask *task,NSObject *cacheParserObject,NSError *requestErr))failure {
    
    NSURLSessionDataTask *dataTask = [self.sessionManager POST:url parameters:parasDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#if DEBUG
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"======Response Start======\n%@\n======Response End=======",str);
        }
#endif
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, nil, error);
    }];
    return dataTask;
}

@end
