//
//  CatsTableViewCell.m
//  Paws-2
//
//  Created by 李祐昇 on 2015/10/26.
//  Copyright © 2015年 Nilson Lee. All rights reserved.
//

#import "CatsTableViewCell.h"

@implementation CatsTableViewCell

-(void) awakeFromNib {
    // Initialization code
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer new] initWithTarget:self action:@selector(onDoubleTap:)];
    
    gesture.numberOfTapsRequired = 2;
    [self.contentView addGestureRecognizer:gesture];
    _catPawIcon.hidden = true;
    [super awakeFromNib];
    
}

- (void) onDoubleTap:(id)sender {
    if(_parseObject) {
      
        int votes = [_parseObject[@"votes"] intValue];
             
        if (votes >= 0) {
            votes++;
            
            [_parseObject setObject:@(votes) forKey:@"votes"];
            [_parseObject saveInBackground];
            
            self.catVotesLabel.text = [NSString stringWithFormat:@"%d votes",votes];
        }
    }
   
    _catPawIcon.hidden = false;
    _catPawIcon.alpha = 1.0;
    
    [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.catPawIcon.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.catPawIcon.hidden = true;
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
