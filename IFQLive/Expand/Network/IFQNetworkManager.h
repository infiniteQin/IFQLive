//
//  IFQNetworkManager.h
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFQNetworkManager : NSObject

+ (instancetype)manager;

- (NSURLSessionDataTask *)requestWithURL:(NSString *)url
                                   paras:(NSDictionary *)parasDict
                                 success:(void(^)(NSURLSessionDataTask *task,NSObject *parserObject))success
                                 failure:(void(^)(NSURLSessionDataTask *task,NSObject *cacheParserObject,NSError *requestErr))failure;

@end
