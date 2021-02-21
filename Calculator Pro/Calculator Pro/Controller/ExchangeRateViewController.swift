import UIKit

class ExchangeRateViewController: UIViewController{
    
    @IBOutlet weak var exchangeRateFromPicker: UITextField!
    @IBOutlet weak var exchangeRateToPicker: UITextField!
    
    @IBOutlet weak var exchangeRateFromTextField: UITextField!
    @IBOutlet weak var exchangeRateToTextField: UITextField!
    
    @IBOutlet weak var currencyUnitFromTextField: UITextField!
    @IBOutlet weak var currencyUnitToTextField: UITextField!
    
    var exchangeRateManager = ExchangeRateManager()
    
    var fromWorkings: String = ""
    var toWorkings: String = ""
    
    var fromTextFieldIsEditing = false
    var toTextFieldIsEditing = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRateManager.delegate = self
        
        exchangeRateFromTextField.delegate = self
        exchangeRateToTextField.delegate = self
        
        // Inserting a dummy view to block automatically displaying the iPhone default keyboard
        // when textfield is touched.
        exchangeRateFromTextField.inputView = UIView()
        exchangeRateToTextField.inputView = UIView()
        
        // A Tag to identify each UITextField
        exchangeRateFromTextField.tag = 0
        exchangeRateToTextField.tag = 1
        
        // Initialize Picker's text
        exchangeRateFromPicker.text = "대한민국 원"
        exchangeRateToPicker.text = "미국 달러"
        
        exchangeRateFromTextField.becomeFirstResponder()
        
        createPickerView()
        dismissPickerView()
        

        
        //exchangeRateFromPicker.setLeftIcon(icon: #imageLiteral(resourceName: "USA"))
    }

    
}

//MARK: - @IBAction Methods

extension ExchangeRateViewController{
    
    @IBAction func pressedCalculate(_ sender: UIButton) {
        
        if let inputString = exchangeRateFromTextField.text, let inputCountry = exchangeRateFromPicker.text, let toCountry = exchangeRateToPicker.text{
            
            if let inputNumber = Int(inputString){
                exchangeRateManager.setCurrencyUnitForFrom(country: inputCountry)
                exchangeRateManager.setCurrencyUnitForTo(country: toCountry)
                exchangeRateManager.fetchExchangeRate(for: inputNumber)
            }
        }
        else{
            // Create an alert pop up saying : "입력값을 다시 확인해주세요"
            print("Error in pressedCalculate( )")
            return
        }
    }

    @IBAction func pressedNumber(_ sender: UIButton) {
        
        if fromTextFieldIsEditing == true{
            fromWorkings += sender.currentTitle!
            exchangeRateFromTextField.text = fromWorkings
        }
        else if toTextFieldIsEditing == true{
            toWorkings += sender.currentTitle!
            exchangeRateToTextField.text = toWorkings
        }

    }
    
    @IBAction func pressedClear(_ sender: UIButton) {
        
        exchangeRateFromTextField.text = ""
        fromWorkings = ""
    
        exchangeRateToTextField.text = ""
        toWorkings = ""
        
        exchangeRateFromTextField.becomeFirstResponder()
    }


    @IBAction func pressedDelete(_ sender: UIButton) {

        if fromTextFieldIsEditing == true{
            if(!fromWorkings.isEmpty){
                fromWorkings.removeLast()
                exchangeRateFromTextField.text = fromWorkings
            }
        }
        else if toTextFieldIsEditing == true{
            if(!toWorkings.isEmpty){
                toWorkings.removeLast()
                exchangeRateToTextField.text = toWorkings
            }
        }
        else { return }
    }
}




//MARK: -  Implementation of ExchangeRateManagerDelegate Protocol

extension ExchangeRateViewController: ExchangeRateManagerDelegate{
    
    func didUpdateExchangeRate(_ exchangeRateManager: ExchangeRateManager, exchange: ExchangeRateModel) {
  
        DispatchQueue.main.async {
            self.exchangeRateToTextField.text = String(format: "%.2f", exchange.finalResult)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Picker View Related Methods

extension ExchangeRateViewController{
    
    func createPickerView() {
        
        // Upper PickerView
        let fromPickerView = UIPickerView()
        fromPickerView.tag = 0
        fromPickerView.dataSource = self
        fromPickerView.delegate = self
        
        // Lower PickerView
        let toPickerView = UIPickerView()
        toPickerView.tag = 1
        toPickerView.dataSource = self
        toPickerView.delegate = self
        
        // Inserting PickerView to UITextField
        exchangeRateFromPicker.inputView = fromPickerView
        exchangeRateToPicker.inputView = toPickerView
    }
    
    func dismissPickerView() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.dismissPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: false )
        toolBar.isUserInteractionEnabled = true
        toolBar.updateConstraintsIfNeeded()
        
        exchangeRateFromPicker.inputAccessoryView = toolBar
        exchangeRateToPicker.inputAccessoryView = toolBar
    }
    
    @objc func dismissPicker(){
        
        if let fromCountry = exchangeRateFromPicker.text{
            
            exchangeRateManager.setCurrencyUnitForFrom(country: fromCountry)

        }

        if let toCountry = exchangeRateToPicker.text{
           
            exchangeRateManager.setCurrencyUnitForTo(country: toCountry)
        }
        else {
            return
        }
        self.view.endEditing(true)
    }
}

//MARK: - UITextField Related Methods
extension UITextField {
    
    func setLeftIcon(icon: UIImage) {
        let padding = 5
        let size = 45
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size + padding, height: 20))
        let iconView = UIImageView(frame: CGRect(x: padding, y: 0, width: 35, height: 20))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
//    func setRightIcon() {
//        let size = 30
//        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: 20))
//        let iconView = UIImageView(frame: CGRect(x: 0, y: 5, width: 13, height: 10))
//        iconView.image = UIImage(named: "triangle")
//        outerView.addSubview(iconView)
//
//        rightView = outerView
//        rightViewMode = .always
//    }
    
    func setRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 34, height: self.frame.height))
        rightView = paddingView
        rightViewMode = ViewMode.always
    }
}


//MARK: - UITextFieldDelegate

extension ExchangeRateViewController: UITextFieldDelegate{
  
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        if textField.text != nil{
            view.endEditing(true)
            return true
        }
        else{
            return false
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 0{
            fromTextFieldIsEditing = true
            toTextFieldIsEditing = false
            exchangeRateFromTextField.becomeFirstResponder()
        }
        else{
            toTextFieldIsEditing = true
            fromTextFieldIsEditing = false
            exchangeRateToTextField.becomeFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
}


//MARK: - UIPickerViewDelegate

extension ExchangeRateViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exchangeRateManager.countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView.tag == 0{
            exchangeRateFromPicker.text = exchangeRateManager.countries[row]
        }
        else if pickerView.tag == 1{
            exchangeRateToPicker.text = exchangeRateManager.countries[row]
        }
        else {

            return
            
        }
    }
}

//MARK: - UIPickerViewDataSource

extension ExchangeRateViewController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exchangeRateManager.countries.count
    }
}

