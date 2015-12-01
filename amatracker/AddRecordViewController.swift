import UIKit
import CoreData

class AddRecordViewController: UIViewController {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var weightTextField: UITextField!
    
    var currentMovement: Movement!
    var pickerData: [[NSString]]!
    let mixpanel = MixpanelService()
    
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
        datePicker.performSelector("setHighlightsToday:", withObject:UIColor.whiteColor())
        
        // when user touches outside keyboard, keyboard should go away
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mixpanel.track("Add Record Scene Viewed", properties: ["movement": currentMovement!.name])
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func getEnteredWeight() -> Float {
        return (weightTextField.text! as NSString).floatValue
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
