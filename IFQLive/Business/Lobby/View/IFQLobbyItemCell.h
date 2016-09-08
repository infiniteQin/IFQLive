//
//  IFQLobbyItemCell.h
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFQLobbyItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatorImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *preImgView;

@end
