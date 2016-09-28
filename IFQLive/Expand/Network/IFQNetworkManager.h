//
//  IFQNetworkManager.h
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFQRequest.h"
#import "IFQResponse.h"

@interface IFQNetworkManager : NSObject

+ (instancetype)manager;

- (IFQRequest *)requestWithURL:(NSString *)url
                         paras:(NSDictionary *)parasDict completionBlock:(void(^)(IFQResponse *response))completionBlock;
//                                 success:(void(^)(NSURLSessionDataTask *task,NSObject *parserObject))success
//                                 failure:(void(^)(NSURLSessionDataTask *task,NSObject *cacheParserObject,NSError *requestErr))failure;

@end
