import UIKit


class GoldCalculatorViewController: UIViewController {

    
    @IBOutlet weak var goldUnitPickerTextField: UITextField!
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    
    var workings: String = ""
    var goldPrice: Float = 0.0
    
    var goldCalculatorManager = GoldCalculatorManager()
    var goldModelReceived = GoldModel(metal: "", currency: "", price: 0.0, finalResult: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goldCalculatorManager.goldDelegate = self
        
        goldCalculatorManager.goldUnit = "oz"
        
        
        goldUnitPickerTextField.text = "oz"
        userInputTextField.delegate = self
        userInputTextField.inputView = UIView()
        userInputTextField.becomeFirstResponder()
    
        createPickerView()
        
        goldCalculatorManager.fetchGoldPrice()
    }
    
   
    

}

//MARK: - @IBAction Methods

extension GoldCalculatorViewController{
    
    func setInputAmount(inputAmount: String){
        
        if let inputAmount = Float(inputAmount){
            goldCalculatorManager.inputAmount = inputAmount
        }
    }
    
    func setGoldUnit(inputUnit: String){

        goldCalculatorManager.goldUnit = inputUnit
    }
    
    
    // 버튼을 누름과 동시에 계산이 될 수 있도록 구현
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        if let inputNum = sender.currentTitle, let inputGoldUnit = goldUnitPickerTextField.text{
            
            workings += inputNum
            userInputTextField.text = workings
            
            setInputAmount(inputAmount: workings)
            setGoldUnit(inputUnit: inputGoldUnit)
            
            goldPrice = goldModelReceived.price
            
            let finalResult = goldCalculatorManager.calculateFinalResult(currentGoldPrice: goldPrice)
            
            resultTextField.text = String(format: "%.2f", finalResult)
            
        }

    }
    
    @IBAction func pressedClear(_ sender: UIButton) {
        
        userInputTextField.text = ""
        resultTextField.text = ""
        workings = ""
    }
    
    @IBAction func pressedDelete(_ sender: UIButton) {
        
        if(!workings.isEmpty){
            workings.removeLast()
            userInputTextField.text = workings
            
            setInputAmount(inputAmount: workings)
            goldPrice = goldModelReceived.price
            
            let finalResult = goldCalculatorManager.calculateFinalResult(currentGoldPrice: goldPrice)
            
            resultTextField.text = String(format: "%.2f", finalResult)
        }
        else if(userInputTextField.text == ""){
            
            resultTextField.text = ""
            workings = ""
        }
        
        
        
        
        
    }
    
}

//MARK: - Implementation of GoldCalculatorManagerDelegate Protocol

extension GoldCalculatorViewController: GoldCalculatorManagerDelegate{
    
    func didUpdateGoldPrice(_ goldCalculatorManager: GoldCalculatorManager, goldModel: GoldModel) {
        
        goldModelReceived = goldModel


//        DispatchQueue.main.async {
//
//            self.resultTextField.text = ""
//            self.resultTextField.text = String(format: "%.2f", goldModel.finalResult)
//        }
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
