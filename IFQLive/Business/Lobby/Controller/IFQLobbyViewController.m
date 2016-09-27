//
//  IFQLobbyViewController.m
//  IFQLive
//
//  Created by taizi on 16/9/8.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQLobbyViewController.h"
#import "IFQNetworkManager.h"
#import "IFQIngKeeListModel.h"
#import "IFQLobbyItemCell.h"
#import "UIImageView+IFQIngKeeURL.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "IFQMediaPlayerViewController.h"
#import "UIScrollView+IFQRefresh.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "IFQLiveViewController.h"

#define Ratio 420/320
#define INGKEE_LIST_URL ([NSString stringWithFormat:@"http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"])

static NSString * const kItemCellIdentify = @"ItemCellIdentify";

@interface IFQLobbyViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy)   NSMutableArray<IFQLivesModel*> *dataArr;
@property (nonatomic, strong) NSURLSessionDataTask *ingKeeDataTast;

@property (nonatomic, copy) NSString *textValue;

@end

@implementation IFQLobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout               = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.extendedLayoutIncludesOpaqueBars     = YES;
    { // tableView
//        self.tableView.
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = [UIScreen mainScreen].bounds.size.width * Ratio + 1;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([IFQLobbyItemCell class]) bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:kItemCellIdentify];
//        SDRefreshHeaderView *refreshView = [SDRefreshHeaderView refreshView];
//        [refreshView addToScrollView:self.tableView];
        __weak typeof(self) wSelf = self;
        [self.tableView addPullToRefreshView:^{
            [wSelf requestListData];
        }];
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
    [self.ingKeeDataTast cancel];
//    [SVProgressHUD show];
    self.ingKeeDataTast = [[IFQNetworkManager manager] requestWithURL:INGKEE_LIST_URL
                                                                paras:nil
                                                              success:^(NSURLSessionDataTask *task, NSObject *parserObject) {
        __strong typeof(wSelf) sSelf= wSelf;
//        [SVProgressHUD dismiss];
        
        BOOL isSucc = YES;
        if ([parserObject isKindOfClass:[NSDictionary class]]) {
            IFQIngKeeListModel *listModel = [IFQIngKeeListModel yy_modelWithDictionary:(NSDictionary*)parserObject];
            isSucc = (listModel != nil);
            [sSelf.dataArr addObjectsFromArray:listModel.lives];
            [sSelf.tableView reloadData];
        } else {
            isSucc = NO;
        }
        if (!isSucc) {
            //TODO:加载出错
        }
        [wSelf.tableView endPullAnimator];
    } failure:^(NSURLSessionDataTask *task, NSObject *cacheParserObject, NSError *requestErr) {
        [wSelf.tableView endPullAnimator];
        //TODO:加载出错
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
    [self.ingKeeDataTast cancel];
}

@end
