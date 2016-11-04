//
//  IFQLobbyViewController.m
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQLobbyViewController.h"
#import "IFQIngKeeListModel.h"
#import "IFQLobbyItemCell.h"
#import "UIImageView+IFQIngKeeURL.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "IFQMediaPlayerViewController.h"
#import "UIScrollView+IFQRefresh.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "IFQLiveViewController.h"
#import "UIImage+IFQIngKeeAVImage.h"
#import "IFQActivityViewController.h"
#import "NSString+IngKeeURL.h"

#define Ratio 420/320
#define INGKEE_LIST_URL ([NSString stringWithFormat:@"http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"])

static NSString * const kItemCellIdentify = @"ItemCellIdentify";

@interface IFQLobbyViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic)   IBOutlet UITableView            *tableView;
@property (nonatomic, copy)   NSMutableArray<IFQLivesModel*>  *dataArr;
@property (nonatomic, strong) IFQRequest                      *ingKeeListRequest;
@property (nonatomic, copy)   NSString                        *textValue;

@end

@implementation IFQLobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    self.edgesForExtendedLayout               = UIRectEdgeTop;
//    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    { // tableView
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = [UIScreen mainScreen].bounds.size.width * Ratio + 1;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([IFQLobbyItemCell class]) bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:kItemCellIdentify];
        __weak typeof(self) wSelf = self;
        [self.tableView addPullToRefreshView:^{
            [wSelf requestListData];
        }];
//        self.tableView.contentInset = UIEdgeInsetsZero;
    }
    
    { // init data
        [self requestListData];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -UITabelViewDataSrouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IFQLobbyItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kItemCellIdentify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    IFQLivesModel *liveModel = self.dataArr[indexPath.row];
    IFQCreatorModel *creator = liveModel.creator;
    [cell.avatorImgView ifqIk_setImageWithURL:creator.portrait];
    cell.nickLabel.text = creator.nick;
    cell.addressLabel.text = creator.location;
    cell.numLabel.text = [NSString stringWithFormat:@"%@",@(liveModel.online_users)];
    [cell.preImgView ifqIk_setImageWithURL:creator.portrait placeholderImage:nil];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IFQLivesModel *liveModel = self.dataArr[indexPath.row];
    IFQCreatorModel *creator = liveModel.creator;
    [self pushToPlayWithStreamURL:liveModel.stream_addr preImgURL:creator.portrait];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.width * Ratio + 1;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}



#pragma mark Network
#pragma mark -- Request
- (void)requestListData {
    __weak typeof(self) wSelf = self;
    [self.ingKeeListRequest cancel];
    self.ingKeeListRequest = [IFQIngKeeListModel requestWithURL:INGKEE_LIST_URL params:nil succ:^(IFQIngKeeListModel *model) {
        __strong typeof(wSelf) sSelf= wSelf;
        if (model) {
            [sSelf.dataArr addObjectsFromArray:model.lives];
            [sSelf.tableView reloadData];
        }
        [sSelf.tableView endPullAnimator];
    } failure:^(NSError *error, NSString *errMsg) {
        __strong typeof(wSelf) sSelf= wSelf;
        [sSelf.tableView endPullAnimator];
    }];
}

/**
 *  跳转到直播页面
 */
- (IBAction)showLive:(id)sender {
    IFQLiveViewController *liveVC = [[IFQLiveViewController alloc] init];
    [self presentViewController:liveVC animated:YES completion:NULL];
}

/**
 *  跳转到视频播放页
 */
- (void)pushToPlayWithStreamURL:(NSString*)streamURL preImgURL:(NSString*)preImgURL {
    if (streamURL.length == 0) {
        //TODO:媒体地址为空
        return;
    }
    IFQMediaPlayerViewController *mediaPlayerVC = [[IFQMediaPlayerViewController alloc] init];
    mediaPlayerVC.preImgURL = preImgURL;
    mediaPlayerVC.mediaURL  = streamURL;
    mediaPlayerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mediaPlayerVC animated:YES];
}

#pragma mark getter
-(NSMutableArray<IFQLivesModel*> *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)refreshTriggered:(id)sender {
    [self requestListData];
}

-(void)dealloc {
    [self.ingKeeListRequest cancel];
}

@end
