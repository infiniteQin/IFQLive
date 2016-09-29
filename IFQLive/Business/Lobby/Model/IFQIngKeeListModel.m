//
//  IFQIngKeeListModel.m
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQIngKeeListModel.h"

@implementation IFQIngKeeListModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"lives" : [IFQLivesModel class]};
}

+ (void)requestWithURL:(NSString*)url params:(NSDictionary*)params succ:(void(^)(__kindof id model))succ failure:(void(^)(NSError *error,NSString *errMsg))failure {
    [[IFQNetworkManager manager] requestWithURL:url
                                          paras:params
                                completionBlock:^(IFQResponse *response) {
        if (response.isSucc) {
            NSObject *respObj = response.responseObj;
            if ([respObj isKindOfClass:[NSDictionary class]]) {
                IFQIngKeeListModel *listModel = [IFQIngKeeListModel yy_modelWithDictionary:(NSDictionary*)respObj];
                if (succ) {
                    succ(listModel);
                }
                return;
            }
        }
        if (failure) {
            failure(response.error,nil);
        }
    }];
}

@end



@implementation IFQLivesModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"id":@"liveId"};
}
@end


@implementation IFQCreatorModel


+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"description" : @"desc",@"id":@"creatorId"};
}

@end


