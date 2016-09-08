//
//  IFQIngKeeListModel.m
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQIngKeeListModel.h"

@implementation IFQIngKeeListModel

//+ (NSDictionary *)objectClassInArray{
//    return @{@"lives" : [IFQLivesModel class]};
//}


+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"lives" : [IFQLivesModel class]};
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


