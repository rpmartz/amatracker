//
//  AddRecordViewController.swift
//  amatracker
//
//  Created by ryan on 8/16/15.
//  Copyright (c) 2015 ryan. All rights reserved.
//

import UIKit
import CoreData

class AddRecordViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var currentMovement: Movement!
    var pickerData: [[NSString]]!
    
    enum pickerComponent:Int{
        case weights = 0
        case fractions = 1
        case units = 2
    }
    
    func weightArray() -> [NSString] {
        var weights: [NSString] = []
        for num in 1...600 {
            weights.append("\(num)")
        }
        
        return weights
    }
    
    func fractionalWeightArray() -> [NSString] {
        return  [".0", ".25", ".5", ".75"]
    }
    
    func unitsArray() -> [NSString] {
        // TODO: make this an enum or class corresponding to a unit
        return ["kg", "lbs"]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = [
            weightArray(),
            fractionalWeightArray(),
            unitsArray()
        ]
        
        weightPicker.dataSource = self
        weightPicker.delegate = self
        
        stepper.minimumValue = 1
        stepper.maximumValue = 100
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.value = 1
        
        repsLabel.text = Int(stepper.value).description
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        
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
        let weightLifted = getSelectedWeight()
        
        
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
    
    private func getSelectedWeight() -> NSNumber {
        // TODO: has to be an easier way to do this
        let selectedWeightRow = weightPicker.selectedRowInComponent(pickerComponent.weights.rawValue)
        let selectedFractionRow = weightPicker.selectedRowInComponent(pickerComponent.fractions.rawValue)
        
        let weightValue = pickerData[pickerComponent.weights.rawValue][selectedWeightRow]
        let fraction = pickerData[pickerComponent.fractions.rawValue][selectedFractionRow]
        
        let asString = NSString(string: "\(weightValue)\(fraction)")
        
        return asString.floatValue
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: UIPickerViewDataSource required functions
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    //MARK: UIPickerViewDelegate optional functions
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(pickerData[component][row])"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        NSLog("selected row. Row:  [\(row)]. Component: [\(component)]")
    }

}
