//
//  MovementDetailViewController.swift
//  amatracker
//
//  Created by ryan on 8/16/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import UIKit

class MovementDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ADD_RECORD_SEGUE = "addRecordSegue"
    let SHOW_PERCENTAGES_SEGUE = "recordsToPercentagesSegue"
    
    @IBOutlet weak var movementNameLabel: UILabel!
    @IBOutlet weak var movementRecordTableView: UITableView!
    
    var movement: Movement!
    var records: [Record] = []
    
    let recordService = RecordService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movementNameLabel.text = movement.name
        loadRecords()
    }
    
    func loadRecords() {
        let fetchedRecords = recordService.loadRecordsByMovement(movement)
        records = fetchedRecords
    }
    
    override func viewWillAppear(animated: Bool) {
        loadRecords()
        self.movementRecordTableView.reloadData()
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
        performSegueWithIdentifier(ADD_RECORD_SEGUE, sender: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let record = records[indexPath.row]
        if(record.numberOfReps == 1) {
            performSegueWithIdentifier(SHOW_PERCENTAGES_SEGUE, sender: nil)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == ADD_RECORD_SEGUE {
            let destinationViewController: AddRecordViewController = segue.destinationViewController as! AddRecordViewController
            destinationViewController.currentMovement = self.movement
        }
        else if segue.identifier == SHOW_PERCENTAGES_SEGUE {
            let destinationViewController: PercentagesViewController = segue.destinationViewController as! PercentagesViewController
            
            let selectedRecord = records[movementRecordTableView.indexPathForSelectedRow!.row]
            let selectedRecordWeight = selectedRecord.weight.floatValue
            destinationViewController.oneRepMaxWeight = selectedRecordWeight
        }
        
    }
    
    @IBAction func segmentedControlPressed(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            records.sortInPlace(sortByDate)
            self.movementRecordTableView.reloadData()
           
        case 1:
            records.sortInPlace(sortByWeight)
            self.movementRecordTableView.reloadData()
            
        default:
            break
        }
    }
    
    func sortByWeight(rec1: Record, rec2: Record) -> Bool {
        return rec1.weight as Double > rec2.weight as Double
    }
    
    func sortByDate(rec1: Record, rec2: Record) -> Bool {
        return rec1.date.timeIntervalSince1970 > rec2.date.timeIntervalSince1970
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let recordToDelete: Record = records[indexPath.row]
            recordService.deleteRecord(recordToDelete)
            
            records.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    

}
