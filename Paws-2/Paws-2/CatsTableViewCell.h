//
//  CatsTableViewCell.h
//  Paws-2
//
//  Created by 李祐昇 on 2015/10/26.
//  Copyright © 2015年 Nilson Lee. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import <Parse.h>

@interface CatsTableViewCell : PFTableViewCell
//貓咪圖片、貓咪名稱、所得票選數、以及圖片的原始作者和paw圖
@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *catNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *catVotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *catCreditLabel;
@property (weak, nonatomic) IBOutlet UIImageView *catPawIcon;
@property (strong, nonatomic) PFObject * parseObject;
@end
