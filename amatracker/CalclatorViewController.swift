import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var weightTextField: UITextField!
    
    @IBAction func showPercentagesButtonPressed(sender: UIButton) {
        let weight = NSString(string: weightTextField.text!).floatValue
        // segue to new controller
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

