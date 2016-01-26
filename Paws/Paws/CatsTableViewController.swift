//
//  CatsTableViewController.swift
//  Paws
//
//  Created by 李祐昇 on 2015/10/17.
//  Copyright © 2015年 Nilson Lee. All rights reserved.
//

import UIKit

let CELL_IDENTIFIER = "CatCell"
let ORDER_BY_ASCENDING_FIELD = "name"
let CELL_NIB_NAME = "CatsTableViewCell"
let OBJECTS_PER_PAGE:UInt = 25
let TABLEVIEW_ROWHEIGHT:CGFloat = 350

class CatsTableViewController: PFQueryTableViewController {
    
    let cellIdentifier:String = CELL_IDENTIFIER
    
    override init(style: UITableViewStyle, className: String!)
    {
        //此處的className指的上Parse上
        super.init(style: style, className: className)
        
        //設定列為合適高度
        self.tableView.rowHeight = TABLEVIEW_ROWHEIGHT
        //不允許做cell的選取
        self.tableView.allowsSelection = false
        
        //頁面往下拉就刷新的功能打開
        self.pullToRefreshEnabled = true
        //關閉分頁
        self.paginationEnabled = false
        //設定Table內物件最多25個
        self.objectsPerPage = OBJECTS_PER_PAGE
        
        self.parseClassName = className
    }
    
    required init(coder aDecoder:NSCoder)
    {
        fatalError("NSCoding not supported")  
    }
    

    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: CELL_NIB_NAME, bundle: nil), forCellReuseIdentifier: cellIdentifier)

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func queryForTable() -> PFQuery {
        var query:PFQuery = PFQuery(className:self.parseClassName!)
        
        if(objects?.count == 0)
        {
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        
        query.orderByAscending(ORDER_BY_ASCENDING_FIELD)
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell:CatsTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CatsTableViewCell
        
        if(cell == nil) {
            
            cell = NSBundle.mainBundle().loadNibNamed(CELL_NIB_NAME, owner: self, options: nil)[0] as? CatsTableViewCell
            
        }
        
        cell?.parseObject = object
        
        if let pfObject = object {
            cell?.catNameLabel?.text = pfObject["name"] as? String
            
            var votes:Int? = pfObject["votes"] as? Int
            if votes == nil {
                votes = 0
            }
            cell?.catVotesLabel?.text = "\(votes!) votes"
            
            var credit:String? = pfObject["cc_by"] as? String
            if credit != nil {
                cell?.catCreditLabel?.text = "\(credit!) / CC 2.0"
            }
            
            cell?.catImageView?.image = nil
            if var urlString:String? = pfObject["url"] as? String {
                var url:NSURL? = NSURL(string: urlString!)
                
                if var url:NSURL? = NSURL(string: urlString!) {
                    var error:NSError?
                    var request:NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 5.0)
                    
                    NSOperationQueue.mainQueue().cancelAllOperations()
                    
                    
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse?, imageData:NSData?, error:NSError?) -> Void in
                        cell?.catImageView?.image = UIImage(data: imageData!)
                    })
                }
            }
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait, UIInterfaceOrientationMask.PortraitUpsideDown]
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
