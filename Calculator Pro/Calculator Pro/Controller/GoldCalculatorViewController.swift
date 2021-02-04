import UIKit


class GoldCalculatorViewController: UIViewController {

    
    @IBOutlet weak var goldUnitPickerTextField: UITextField!
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
        
        createPickerView()
    
        
        
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

extension GoldCalculatorViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    func createPickerView(){
        
        let goldUnitPickerView = UIPickerView()
        goldUnitPickerView.backgroundColor = .white
        goldUnitPickerView.dataSource = self
        goldUnitPickerView.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.dismissPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.dismissPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        goldUnitPickerTextField.inputView = goldUnitPickerView
        goldUnitPickerTextField.inputAccessoryView = toolBar
        
        
    }
    
    @objc func dismissPicker(){
        self.view.endEditing(true)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return goldCalculatorManager.goldUnitArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return goldCalculatorManager.goldUnitArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        goldUnitPickerTextField.text = goldCalculatorManager.goldUnitArray[row]
    }
    
    
}
