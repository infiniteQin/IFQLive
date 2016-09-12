//
//  IFQLiveViewController.m
//  IFQLive
//
//  Created by taizi on 16/9/12.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQLiveViewController.h"
#import "LFLivePreview.h"

@interface IFQLiveViewController ()

@end

@implementation IFQLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    LFLivePreview *livePreView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    __weak typeof(self) wSelf = self;
    livePreView.didActionCloseBlock = ^(){
        [wSelf dismissViewControllerAnimated:YES completion:NULL];  
    };
    [self.view addSubview:livePreView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
