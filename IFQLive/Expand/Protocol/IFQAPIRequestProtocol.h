//
//  IFQAPIRequestProtocol.h
//  IFQLive
//
//  Created by taizi on 16/9/28.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFQNetworkManager.h"

@protocol IFQAPIRequestProtocol <NSObject>
@required
+ (void)requestWithURL:(NSString*)url params:(NSDictionary*)params succ:(void(^)(__kindof id model))succ failure:(void(^)(NSError *error,NSString *errMsg))failure;

@end
