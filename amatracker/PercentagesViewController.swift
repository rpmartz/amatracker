//
//  PercentagesViewController.swift
//  amatracker
//
//  Created by ryan on 10/24/15.
//  Copyright © 2015 ryan. All rights reserved.
//

import Foundation
import UIKit

class PercentagesViewController : UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var oneRepMaxWeight: Float = Float()
    let percentages : [Float] = [0.5, 0.55, 0.6, 0.65,
                                0.7, 0.75, 0.8, 0.85,
                                0.9, 0.95, 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: PercentageTableCell = tableView.dequeueReusableCellWithIdentifier("percentageCell") as! PercentageTableCell
        
        let currentRowPercentage = percentages[indexPath.row]
        let percentage : Int = Int(currentRowPercentage * oneRepMaxWeight)
       
        
        cell.weightTextLabel.text = "\(percentage) kg"
        cell.percentageTextLabel.text = "\(currentRowPercentage * 100.0)% of 1RM"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return percentages.count
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    @IBAction func closeButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            
        }
    }
}
