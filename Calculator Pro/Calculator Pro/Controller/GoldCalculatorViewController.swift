import UIKit


class GoldCalculatorViewController: UIViewController {

    
    @IBOutlet weak var goldUnitPicker: UITextField!
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    
    var workings: String = ""
    
    var goldCalculatorManager = GoldCalculatorManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        goldCalculatorManager.goldDelegate = self
        
        userInputTextField.delegate = self
        userInputTextField.inputView = UIView()
        userInputTextField.becomeFirstResponder()
        
        
        
    }
    
    
    
   
    
  
    
    
    
}

//MARK: - @IBAction Methods

extension GoldCalculatorViewController{
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        if let inputNum = sender.currentTitle{
            workings += inputNum
            userInputTextField.text = workings
        }
        
        
    }
    
    @IBAction func pressedClear(_ sender: UIButton) {
        
        userInputTextField.text = ""
        resultTextField.text = ""
    }
    
    @IBAction func pressedDelete(_ sender: UIButton) {
        
        if(!workings.isEmpty){
            workings.removeLast()
            userInputTextField.text = workings
        }
    }
    
}

//MARK: - Implementation of GoldCalculatorManagerDelegate Protocol

extension GoldCalculatorViewController: GoldCalculatorManagerDelegate{
    
    func didUpdateGoldPrice(_ goldCalculatorManager: GoldCalculatorManager, goldModel: GoldModel) {
        //
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


//MARK: - Picker View Related Methods

extension GoldCalculatorViewController{
    
    func createPickerView(){
        
        let goldUnitPickerView = UIPickerView()
        goldUnitPickerView.dataSource = self
        goldUnitPickerView.delegate = self
        
        goldUnitPicker
    }
    
}
