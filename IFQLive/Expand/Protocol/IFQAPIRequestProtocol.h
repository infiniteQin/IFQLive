//
//  IFQAPIRequestProtocol.h
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFQNetworkManager.h"
//====Start Define RequestApi=====
#define IFQ_REQUEST_API \
+ (IFQRequest*)requestWithURL:(NSString*)url params:(NSDictionary*)params succ:(void(^)(__kindof id model))succ failure:(void(^)(NSError *error,NSString *errMsg))failure {\
IFQRequest *request = [[IFQNetworkManager manager] requestWithURL:url paras:params completionBlock:^(IFQResponse *response) {\
if (response.isSucc) {\
NSObject *respObj = response.responseObj;\
if ([respObj isKindOfClass:[NSDictionary class]]) {\
id listModel = [self yy_modelWithDictionary:(NSDictionary*)respObj];\
if (succ) {\
succ(listModel);\
}\
return;\
}\
}\
if (failure) {\
failure(response.error,nil);\
}\
}];\
return request;\
}
//=====End Define RequestApi=====

@protocol IFQAPIRequestProtocol <NSObject>
@required
+ (IFQRequest*)requestWithURL:(NSString*)url params:(NSDictionary*)params succ:(void(^)(__kindof id model))succ failure:(void(^)(NSError *error,NSString *errMsg))failure;

@end
