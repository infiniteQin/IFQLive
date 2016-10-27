//
//  IFQActivityViewController.h
//  IFQLive
//
//  Created by taizi on 16/9/29.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFQActivityViewController : UIActivityViewController

- (instancetype)initWithActivityItems:(NSArray *)activityItems
                      completionBlock:(UIActivityViewControllerCompletionWithItemsHandler)completoinBlock;

@end
