//
//  IFQActivityViewController.m
//  IFQLive
//
//  Created by taizi on 16/9/29.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQActivityViewController.h"

@interface IFQActivityViewController ()

@end

@implementation IFQActivityViewController


- (instancetype)initWithActivityItems:(NSArray *)activityItems
                      completionBlock:(UIActivityViewControllerCompletionWithItemsHandler)completoinBlock {
    self = [super initWithActivityItems:activityItems applicationActivities:nil];
    if (self) {
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
            self.completionWithItemsHandler = completoinBlock;
        }else{
//            UIActivityViewControllerCompletionHandler myBlock = ^(NSString *activityType,BOOL completed)
//            {
//                completoinBlock(activityType,completed, nil, nil);
//            };
//            // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
//            self.completionHandler = myBlock;
        }
        self.excludedActivityTypes = @[];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
