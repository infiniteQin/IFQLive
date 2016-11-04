//
//  IFQConversationListViewController.m
//  IFQLive
//
//  Created by taizi on 16/10/14.
//  Copyright © 2016年 qiuyin. All rights reserved.
//

#import "IFQConversationListViewController.h"
#import "IFQConversationListCell.h"
#import "IFQWebSocketClient.h"
#import "IFQIMMsgCreator.h"
#import "UIScrollView+IFQRefresh.h"

static NSString * const kConversationListCell = @"IFQConversationListCell";

@interface IFQConversationListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation IFQConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {//
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.title = @"消息中心";
    }
    
    { //TableView
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight  = 60;
        self.tableView.tableFooterView = [UIView new];
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([IFQConversationListCell class]) bundle:nil] forCellReuseIdentifier:kConversationListCell];
        [self.tableView addPullToRefreshView:^{
            
        }];
    }
    
    
    {//test
        [[IFQWebSocketClient sharedInstance] connectWithURL:@"ws://127.0.0.1:8080"];
        IFQBaseIMMsg *loginMsg = [IFQIMMsgCreator loginMsgWithUsrName:@"bbb" password:@"123456"];
        [[IFQWebSocketClient sharedInstance] sendMsg:loginMsg];
    }
}

#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kConversationListCell forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IFQBaseIMMsg *msg = [IFQIMMsgCreator textMsg:@"文本内容" toUsr:@"bbb"];
    [[IFQWebSocketClient sharedInstance] sendMsg:msg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
