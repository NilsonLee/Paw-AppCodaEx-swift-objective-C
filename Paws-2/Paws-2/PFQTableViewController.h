//
//  PFQTableViewController.h
//  Paws-2
//
//  Created by 李祐昇 on 2015/10/26.
//  Copyright © 2015年 Nilson Lee. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#define PARSE_CLASS_NAME @"Cat"
#define CELL_IDENTIFIER @"CatCell"
#define ORDER_BY_ASCENDING_FIELD @"name"
#define CELL_NIB_NAME @"CatsTableViewCell"

@interface PFQTableViewController : PFQueryTableViewController

@end
