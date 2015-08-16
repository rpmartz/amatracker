//
//  MovementDetailViewController.swift
//  amatracker
//
//  Created by ryan on 8/16/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import UIKit
import CoreData

class MovementDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var movementNameLabel: UILabel!
    @IBOutlet weak var movementRecordTableView: UITableView!
    
    var movement: Movement!
    var records: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movementNameLabel.text = movement.name
        
        // fetch the records
        let request = NSFetchRequest(entityName: "Record")
        
        // add type since we're casting
        let appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDelegate.managedObjectContext!
        
        var error: NSError?
        let fetchedRecords = context.executeFetchRequest(request, error: &error) as! [Record]
        
        var filteredRecords: [Record] = []
        if fetchedRecords.count > 0 {
            // TODO this should be done in the query
            for record in fetchedRecords {
                if(record.movement == movement) {
                    filteredRecords.append(record)
                }
            }
        }
        
        records = filteredRecords
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITableViewDataSource functions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let record = records[indexPath.row]
        let cell = self.movementRecordTableView.dequeueReusableCellWithIdentifier("movementRecordCell") as! MovementRecordTableCell
        cell.recordLabel.text = "\(record.numberOfReps) Reps"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        cell.dateLabel.text = dateFormatter.stringFromDate(record.date)
        cell.weightLabel.text = "\(record.weight) kg"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    // MARK: UITableViewDelegate functions
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: implement something here
    }
    
    
    @IBAction func addRecordButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("addRecordSegue", sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationViewController: AddRecordViewController = segue.destinationViewController as! AddRecordViewController
        destinationViewController.currentMovement = self.movement
        
    }
    

}
