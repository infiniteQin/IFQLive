//
//  IFQIngKeeListModel.h
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@class IFQLivesModel,IFQCreatorModel;
@interface IFQIngKeeListModel : NSObject

@property (nonatomic, assign) NSInteger expire_time;

@property (nonatomic, assign) NSInteger dm_error;

@property (nonatomic, strong) NSArray<IFQLivesModel *> *lives;

@property (nonatomic, copy) NSString *error_msg;

@end
@interface IFQLivesModel : NSObject

@property (nonatomic, copy) NSString *liveId;

@property (nonatomic, assign) NSInteger room_id;

@property (nonatomic, assign) NSInteger online_users;

@property (nonatomic, assign) NSInteger version;

@property (nonatomic, assign) NSInteger rotate;

@property (nonatomic, assign) NSInteger multi;

@property (nonatomic, assign) NSInteger link;

@property (nonatomic, copy) NSString *share_addr;

@property (nonatomic, assign) NSInteger slot;

@property (nonatomic, strong) IFQCreatorModel *creator;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, assign) NSInteger group;

@property (nonatomic, copy) NSString *stream_addr;

@property (nonatomic, assign) NSInteger pub_stat;

@property (nonatomic, assign) NSInteger optimal;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger status;

@end

@interface IFQCreatorModel : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *creatorId;

@property (nonatomic, copy) NSString *third_platform;

@property (nonatomic, assign) NSInteger rank_veri;

@property (nonatomic, assign) NSInteger gmutex;

@property (nonatomic, assign) NSInteger verified;

@property (nonatomic, copy) NSString *emotion;

@property (nonatomic, copy) NSString *nick;

@property (nonatomic, assign) NSInteger inke_verify;

@property (nonatomic, copy) NSString *verified_reason;

@property (nonatomic, copy) NSString *birth;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *portrait;

@property (nonatomic, copy) NSString *hometown;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *veri_info;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, copy) NSString *profession;

@end

