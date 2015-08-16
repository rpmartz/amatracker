//
//  MovementDetailViewController.swift
//  amatracker
//
//  Created by ryan on 8/16/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import UIKit

class MovementDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movementNameLabel: UILabel!
    @IBOutlet weak var movementRecordTableView: UITableView!
    
    var movement: Movement!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movementNameLabel.text = movement.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITableViewDataSource functions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.movementRecordTableView.dequeueReusableCellWithIdentifier("movementRecordCell") as! MovementRecordTableCell
        cell.recordLabel.text = "Some Record"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: UITableViewDelegate functions
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("selected row at index path \(indexPath.row)")
    }
    
    
    @IBAction func addRecordButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("addRecordSegue", sender: nil)
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
