//
//  PFQTableViewController.m
//  Paws-2
//
//  Created by 李祐昇 on 2015/10/26.
//  Copyright © 2015年 Nilson Lee. All rights reserved.
//

#import "PFQTableViewController.h"
#import <Parse.h>
#import "CatsTableViewCell.h"


@interface PFQTableViewController ()

@end

@implementation PFQTableViewController

- (void)commonInit
{
    //設定列為合適高度
    self.tableView.rowHeight = 350;
    //不允許做cell的選取
    self.tableView.allowsSelection = false;
    //parse上所建的class名稱
    self.parseClassName = PARSE_CLASS_NAME;
    //下拉更新
    self.pullToRefreshEnabled = NO;
    //分頁功能
    self.paginationEnabled = NO;
    //每頁最大物件數量
    self.objectsPerPage = 25;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    
    self = [super initWithStyle:style];
    if (!self) return nil;
    
    [self commonInit];
    
    return self;
}
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) return nil;
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    
    [self commonInit];
    
    return self;
}*/

- (UIInterfaceOrientationMask)supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}


- (void)viewDidLoad {
    
    [self.tableView registerNib:[UINib nibWithNibName:CELL_NIB_NAME bundle:nil] forCellReuseIdentifier:CELL_IDENTIFIER];
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:PARSE_CLASS_NAME];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    //以name欄位來當排序的標準
    [query orderByAscending:ORDER_BY_ASCENDING_FIELD];
    
    return query;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    
    //PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    CatsTableViewCell *cell = (CatsTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!cell) {
//        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:CELL_IDENTIFIER];
        cell = (CatsTableViewCell *)[[NSBundle mainBundle] loadNibNamed:CELL_NIB_NAME owner:self options:nil];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    
    //cell.textLabel.text = object[@"name"];
    
    cell.parseObject = object;
    
    if (object) {
        cell.catNameLabel.text = object[@"name"];
        int votes = [object[@"votes"] intValue];
        if (!votes) {
            votes = 0;
        }
        cell.catVotesLabel.text = [NSString stringWithFormat:@"%d votes", votes];
        NSString * credit = object[@"cc_by"];
        if (credit) {
            cell.catCreditLabel.text = [NSString stringWithFormat:@"%@  / CC 2.0", credit];

        }
        
        cell.catImageView.image = nil;
        
        
        NSString *urlString = object[@"url"];
        
        if (urlString) {
            /*
            //NSURLConnection的寫法
            NSURL * url = [NSURL URLWithString:urlString];
            
            NSURLRequest * request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5.0];
            
            [[NSOperationQueue mainQueue] cancelAllOperations];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                if (connectionError) {
                    NSLog(@"Error: %@",connectionError.description);
                } else {
                    cell.catImageView.image = [UIImage imageWithData:data];
                }

            }];
            */
            //Prepare NSURLSession 基本型
            NSURL * url = [NSURL URLWithString:urlString];
            [[NSOperationQueue mainQueue] cancelAllOperations];
            
            NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
            //因為NSURLSession的作法他的CachePolicy是擺在NSURLSessionConfiguration底下,所以request的部份不該設定CachePolicy,若設定會無效,且也會讓config內的CachePolicy設定也失效
            
            NSURLRequest * request = [NSURLRequest requestWithURL:url];
            
            config.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
            
            NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
            NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Error: %@",error.description);
                } else {
                    //main queue很重要,不然模擬器上圖片顯示會怪怪的,但實機仍然是有問題狀態
                    dispatch_async(dispatch_get_main_queue(), ^{
      
                        cell.catImageView.image = [UIImage imageWithData:data];
                    });
                }
            }];
            
            //下達時才會開始跑
            [task resume];
           
            
        }
    }

    return cell;
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
