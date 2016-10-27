//
//  IFQConversationListCell.h
//  IFQLive
//
//  Created by taizi on 16/10/14.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFQConversationListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatorImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMsgLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
