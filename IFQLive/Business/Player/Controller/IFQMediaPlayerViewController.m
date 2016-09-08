//
//  IFQVideoPlayerViewController.m
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQMediaPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import <Masonry/Masonry.h>
#import "UIView+IFQInspectable.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface IFQMediaPlayerViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation IFQMediaPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    { // back btn
        [self setupBackBtn];
    }
    
    { // setup player
        [self reSetupPlayer];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(appDidBecomeActive)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (![self.player isPlaying]) {
        [self.player prepareToPlay];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player pause];
}

- (void)appDidBecomeActive {
//    [self.player prepareToPlay];
//    [self.player play];
    [self reSetupPlayer];
    [self.player prepareToPlay];
}

- (void)setupBackBtn {
    UIButton *backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    backBtn.ifq_CornerRadius = 15;
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    @weakify(self);
    [[backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self goBack];
    }];
}

- (void)reSetupPlayer {
    [_player.view removeFromSuperview];
    [_player shutdown];
    _player = nil;
    self.player.view.frame = self.view.bounds;
    [self.view insertSubview:self.player.view atIndex:0];
    
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (IJKFFMoviePlayerController *)player {
    if (!_player) {
        NSURL *url = [NSURL URLWithString:self.mediaURL];
        _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:[IJKFFOptions optionsByDefault]];
        [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
        [_player setPauseInBackground:YES];
    }
    return _player;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_player shutdown];
    _player = nil;
}

@end
