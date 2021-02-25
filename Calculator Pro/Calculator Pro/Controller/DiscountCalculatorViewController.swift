import UIKit

class DiscountCalculatorViewController: UIViewController {
    
    @IBOutlet weak var originalPriceTextField: UITextField!
    @IBOutlet weak var discountPercentageTextField: UITextField!
    @IBOutlet weak var finalResultTextField: UITextField!
    
    var originalPriceWorkings: String = ""
    var discountPercentageWorkings: String = ""
    
    var discountCalculatorManager = DiscountCalculatorManager(originalPrice: 0.0, discountPercentage: 0.0, finalResult: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalPriceTextField.delegate = self
        discountPercentageTextField.delegate = self
        
        originalPriceTextField.becomeFirstResponder()
    }
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        if originalPriceTextField.isEditing{
         
            originalPriceWorkings += sender.currentTitle!
            originalPriceTextField.text = originalPriceWorkings
        }
        else if discountPercentageTextField.isEditing{
            
            discountPercentageWorkings += sender.currentTitle!
            discountPercentageTextField.text = discountPercentageWorkings + " %"
        }
    }

    @IBAction func pressedCalculate(_ sender: UIButton) {
        
        guard let inputPrice = originalPriceTextField.text, let discountPercentage = discountPercentageTextField.text else{
            createAlertMessage("입력 값 확인", "입력 값을 다시 확인해주세요.")
            return
        }
        
        if let inputPriceDouble = Double(inputPrice), let discountPercentageDouble = Double(discountPercentage){
        
            discountCalculatorManager.originalPrice = inputPriceDouble
            discountCalculatorManager.discountPercentage = discountPercentageDouble
        } else {
            createAlertMessage("유효하지 않은 값", "다시 입력해주세요")
        }
        
        let finalResult = discountCalculatorManager.calculateFinalResult()
        finalResultTextField.text = String(format: "%.1f", finalResult)
    
    }
}

//MARK: - UITextFieldDelegate

extension DiscountCalculatorViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        
        case originalPriceTextField:
            discountPercentageTextField.becomeFirstResponder()
        case discountPercentageTextField:
            discountPercentageTextField.resignFirstResponder()
        default: break
        }
        return true
    }
    
    
    
}

//MARK: - Other Methods

extension DiscountCalculatorViewController {
    
    func createAlertMessage(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
