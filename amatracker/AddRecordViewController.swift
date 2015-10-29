//
//  AddRecordViewController.swift
//  amatracker
//
//  Created by ryan on 8/16/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import UIKit
import CoreData

class AddRecordViewController: UIViewController {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var weightTextField: UITextField!
    
    var currentMovement: Movement!
    var pickerData: [[NSString]]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stepper.minimumValue = 1
        stepper.maximumValue = 100
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.value = 1
        
        repsLabel.text = Int(stepper.value).description
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.setValue(UIColor.whiteColor(), forKey: "textColor")
        
        
        // Do any additional setup after loading the view.

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func stepperPressed(sender: UIStepper) {
         repsLabel.text = Int(sender.value).description
    }
 
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIButton) {

            let reps = Int(stepper.value)
        let recordDate = self.datePicker.date
        let weightLifted = getEnteredWeight()
        
        let appDelegate : AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("Record", inManagedObjectContext: managedObjectContext!)
        
        let record = Record(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        record.numberOfReps = reps
        record.weight = weightLifted
        record.date = recordDate
        record.movement = currentMovement
        record.unit = "kg"
        
        appDelegate.saveContext()
        
//        let recordListViewController = self.parentViewController as! MovementDetailViewController
//        recordListViewController.loadRecords()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func getEnteredWeight() -> Float {
        return (weightTextField.text! as NSString).floatValue
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

}
