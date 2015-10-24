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
    let movementService = MovementService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movements = movementService.fetchMovements()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource functions
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let currentMovement = movements[indexPath.row]
        let cell: MovementTableCell = tableView.dequeueReusableCellWithIdentifier(MOVEMENT_TABLE_CELL) as! MovementTableCell
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
            
            let indexPathOfSelectedRow : NSIndexPath = self.movementTable.indexPathForSelectedRow!
            let selectedMovement = movements[indexPathOfSelectedRow.row]
            destinationViewController.movement = selectedMovement
        }
        
    }
    
}

