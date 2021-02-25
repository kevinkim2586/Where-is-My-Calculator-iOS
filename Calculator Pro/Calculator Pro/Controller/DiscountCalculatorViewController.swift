import UIKit

class DiscountCalculatorViewController: UIViewController {
    
    @IBOutlet weak var originalPriceTextField: UITextField!
    @IBOutlet weak var discountPercentageTextField: UITextField!
    @IBOutlet weak var finalResultTextField: UITextField!
    
    
    var originalPriceWorkings: String = ""
    var discountPercentageWorkings: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    

    @IBAction func pressedNumber(_ sender: UIButton) {
        
        if originalPriceTextField.isEditing{
         
            originalPriceWorkings += sender.currentTitle!
            originalPriceTextField.text = originalPriceWorkings
        }
        else if discountPercentageTextField.isEditing{
            
            discountPercentageWorkings += sender.currentTitle!
            discountPercentageTextField.text = discountPercentageWorkings
        }
    }
    
    
    
}
