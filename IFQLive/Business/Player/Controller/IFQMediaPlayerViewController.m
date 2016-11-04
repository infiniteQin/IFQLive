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
#import "IFQRTMPConfig.h"
#import "UIImageView+IFQIngKeeURL.h"

@interface IFQMediaPlayerViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController    *player;
@property (nonatomic, strong) UIImageView                   *loadingMaskView;

@end

@implementation IFQMediaPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kCustPlayRTMPURL.length>0) {
        self.mediaURL = kCustPlayRTMPURL;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    {// loading mask view
        [self.view addSubview:self.loadingMaskView];
    }
    { // back btn
        [self setupBackBtn];
    }
    { // setup player
        [self reSetupPlayer];
        [self installMovieNotificationObservers];
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

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    if (![self.player isPlaying]) {
//        [self.player play];
//    }
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.player pause];
//}

-(void)dealloc {
    [self removeMovieNotificationObservers];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_player shutdown];
    _player = nil;
}

- (void)appDidBecomeActive {
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

- (UIImageView *)loadingMaskView {
    if (!_loadingMaskView) {
        _loadingMaskView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [_loadingMaskView ifqIk_setImageWithURL:self.preImgURL placeholderImage:[UIImage imageNamed:@"default_video_load_mask"]];
        
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = _loadingMaskView.bounds;
        [_loadingMaskView addSubview:visualEffectView];
    }
    return _loadingMaskView;
}

#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    
}

- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}

#pragma mark IJK Notification
- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    
    self.loadingMaskView.hidden = YES;
    switch (_player.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

@end
