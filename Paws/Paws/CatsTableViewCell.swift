//
//  CatsTableViewCell.swift
//  Paws
//
//  Created by 李祐昇 on 2015/10/17.
//  Copyright © 2015年 Nilson Lee. All rights reserved.
//

import UIKit

class CatsTableViewCell: PFTableViewCell {
    //貓咪圖片、貓咪名稱、所得票選數、以及圖片的原始作者
    @IBOutlet weak var catImageView:UIImageView?
    @IBOutlet weak var catNameLabel:UILabel?
    @IBOutlet weak var catVotesLabel:UILabel?
    @IBOutlet weak var catCreditLabel:UILabel?
    @IBOutlet weak var catPawIcon:UIImageView?
    var parseObject:PFObject?
    
    

    override func awakeFromNib() {
        // Initialization code
        let gesture = UITapGestureRecognizer(target: self, action:Selector("onDoubleTap:"))
        gesture.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(gesture)
        catPawIcon?.hidden = true
        super.awakeFromNib()
        

        
    }

    func onDoubleTap(sender:AnyObject) {
        
        if(parseObject != nil) {
            
            if var votes:Int? = parseObject!.objectForKey("votes") as? Int {
                votes!++
                
                parseObject!.setObject(votes!, forKey: "votes");
                parseObject!.saveInBackground();
                
                catVotesLabel?.text = "\(votes!) votes";
            }
        }
        
        
        catPawIcon?.hidden = false
        catPawIcon?.alpha = 1.0
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.catPawIcon?.alpha = 0.0
            }, completion: { (value:Bool) in
                
                self.catPawIcon?.hidden = true
        
        })
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
