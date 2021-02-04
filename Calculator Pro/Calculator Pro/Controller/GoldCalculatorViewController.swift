import UIKit


class GoldCalculatorViewController: UIViewController {

    
    @IBOutlet weak var GoldUnitPicker: UITextField!
    @IBOutlet weak var UserInputTextField: UITextField!
    @IBOutlet weak var ResultTextField: UITextField!
    
    var workings: String = ""
    
    var goldCalculatorManager = GoldCalculatorManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        goldCalculatorManager.goldDelegate = self
        
        UserInputTextField.delegate = self
        UserInputTextField.inputView = UIView()
        UserInputTextField.becomeFirstResponder()
        
        
        
    }
    
    
    
   
    
  
    
    
    
}

//MARK: - @IBAction Methods

extension GoldCalculatorViewController{
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        if let inputNum = sender.currentTitle{
            workings += inputNum
            UserInputTextField.text = workings
        }
        
        
    }
    
    @IBAction func pressedClear(_ sender: UIButton) {
        
        UserInputTextField.text = ""
        ResultTextField.text = ""
    }
    
    @IBAction func pressedDelete(_ sender: UIButton) {
        
        if(!workings.isEmpty){
            workings.removeLast()
            UserInputTextField.text = workings
        }
    }
    
}

//MARK: - Implementation of GoldCalculatorManagerDelegate Protocol

extension GoldCalculatorViewController: GoldCalculatorManagerDelegate{
    
    func didUpdateGoldPrice(_ goldCalculatorManager: GoldCalculatorManager, goldModel: GoldModel) {
        <#code#>
    }
    
    func didFailWithError(error: Error) {
        print("Failed to fetch Gold Price at this moment")
    }
    
}


//MARK: - UITextFieldDelegate

extension GoldCalculatorViewController: UITextFieldDelegate{
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != nil{
            view.endEditing(true)
            return true
        }
        else{
            return false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    
}
