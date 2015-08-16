//
//  MovementListViewController.swift
//  amatracker
//
//  Created by ryan on 8/16/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import UIKit
import CoreData

class MovementListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    // MARK: Constants
    let MOVEMENT_TABLE_CELL = "movementTableCell"
    let MOVEMENT_DETAIL_SEGUE = "movementDetailSegue"

    @IBOutlet weak var movementTable: UITableView!
    
    var movements : [Movement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movements = fetchMovements()
    }
    
    func fetchMovements() -> [Movement] {
        let request = NSFetchRequest(entityName: "Movement")
        
        // add type since we're casting
        let appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDelegate.managedObjectContext!
        
        var error: NSError?
        var movementArray = context.executeFetchRequest(request, error: &error)
        
        if movementArray?.count == 0 {
            createMovements()
            movementArray = context.executeFetchRequest(request, error: &error)
        }
        
        return movementArray as! [Movement]
        
    }
    
    private func createMovements() {
        NSLog("creating movements")
        let movementNames = [
            "Back Squat",
            "Front Squat",
            "Overhead Squat",
            "Deadlift",
            "Shoulder Press",
            "Push Press",
            "Jerk",
            "Power Clean",
            "Clean",
            "Clean and Jerk",
            "Power Snatch",
            "Snatch"
        ]
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        for name in movementNames {
            let entityDescription = NSEntityDescription.entityForName("Movement", inManagedObjectContext: managedObjectContext!)
            let movement = Movement(entity: entityDescription!, insertIntoManagedObjectContext:  managedObjectContext!)
            movement.name = name
        }
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource functions
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let currentMovement = movements[indexPath.row]
        var cell: MovementTableCell = tableView.dequeueReusableCellWithIdentifier(MOVEMENT_TABLE_CELL) as! MovementTableCell
        cell.movementNameLabel.text = currentMovement.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count
    }
    
    // MARK: UITableViewDelegate required functions
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(MOVEMENT_DETAIL_SEGUE, sender: self)
    }

    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == MOVEMENT_DETAIL_SEGUE) {
            let destinationViewController : MovementDetailViewController = segue.destinationViewController  as! MovementDetailViewController
            
            let indexPathOfSelectedRow : NSIndexPath = self.movementTable.indexPathForSelectedRow()!
            let selectedMovement = movements[indexPathOfSelectedRow.row]
            destinationViewController.movement = selectedMovement
        }
        
    }
    

    private func buildMovementsArray() -> [MovementDisplayItem] {
        let backSquat = MovementDisplayItem(name: "Back Squat")
        let frontSquat = MovementDisplayItem(name: "Front Squat")
        let overheadSquat = MovementDisplayItem(name: "Overhead Squat")
        let deadlift = MovementDisplayItem(name: "Deadlift")
        let shoulderPress = MovementDisplayItem(name: "Shoulder Press")
        let pushPress = MovementDisplayItem(name: "Push Press")
        let jerk = MovementDisplayItem(name: "Jerk")
        let powerClean = MovementDisplayItem(name: "Power Clean")
        let clean = MovementDisplayItem(name: "Clean")
        let cleanAndJerk = MovementDisplayItem(name: "Clean and Jerk")
        let powerSnatch = MovementDisplayItem(name: "Power Snatch")
        let snatch = MovementDisplayItem(name: "Snatch")
        
        let movementArray = [backSquat, frontSquat, overheadSquat, deadlift, shoulderPress, pushPress, jerk, powerClean, clean, cleanAndJerk, powerSnatch, snatch]
        
        return movementArray
    }


    
}

class MovementDisplayItem {
    
    let name : String!
    
    init(name: String) {
        self.name = name
    }
}
