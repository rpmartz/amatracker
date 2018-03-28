import UIKit
import CoreData
import Mixpanel

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
        
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.setValue(true, forKey: "highlightsToday")
        datePicker.maximumDate = Date()
        
        // when user touches outside keyboard, keyboard should go away
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddRecordViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.weightTextField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let mixpanel = Mixpanel.sharedInstance() {
            mixpanel.track("Add Record Scene Viewed", properties: ["movement": currentMovement!.name])
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func stepperPressed(_ sender: UIStepper) {
         repsLabel.text = Int(sender.value).description
    }
 
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {

        let reps = Int(stepper.value)
        let recordDate = self.datePicker.date
        let weightLifted = getEnteredWeight()
        
        let appDelegate : AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Record", in: managedObjectContext!)
        
        let record = Record(entity: entityDescription!, insertInto: managedObjectContext!)
        record.numberOfReps = NSNumber(value: reps)
        record.weight = NSNumber(value: weightLifted)
        record.date = recordDate
        record.movement = currentMovement
        record.unit = "kg"
        
        appDelegate.saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func getEnteredWeight() -> Float {
        return (weightTextField.text! as NSString).floatValue
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}
