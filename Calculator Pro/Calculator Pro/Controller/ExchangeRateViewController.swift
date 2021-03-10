import UIKit

class ExchangeRateViewController: UIViewController{
    
    @IBOutlet weak var exchangeRateFromPicker: UITextField!
    @IBOutlet weak var exchangeRateToPicker: UITextField!
    
    @IBOutlet weak var exchangeRateFromTextField: UITextField!
    @IBOutlet weak var exchangeRateToTextField: UITextField!
    
    @IBOutlet weak var currencyUnitFromTextField: UITextField!
    @IBOutlet weak var currencyUnitToTextField: UITextField!
    
    
    @IBOutlet var numberButtonCollection: [UIButton]!
    @IBOutlet var operationButtonCollection: [UIButton]!
    
    var exchangeRateManager = ExchangeRateManager()
    
    var inputWorkings: String = ""                               // For TextField String input
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRateManager.delegate = self
        exchangeRateFromTextField.delegate = self
        exchangeRateToTextField.delegate = self
        
        // Inserting a dummy view to block automatically displaying the iPhone default keyboard
        // when textfield is touched.
        exchangeRateFromTextField.inputView = UIView()
        exchangeRateToTextField.inputView = UIView()
        
        // Initialize Picker's text
        exchangeRateFromPicker.text = "한국 원"
        exchangeRateToPicker.text = "미국 달러"
        
        exchangeRateFromTextField.becomeFirstResponder()
        createPickerView()
        
        configureUIButton()
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
            createAlertMessage("입력 값 확인", "입력 값을 다시 확인해주세요.")
            return
        }
    }

    @IBAction func pressedNumber(_ sender: UIButton) {
    
        inputWorkings += sender.currentTitle!
        exchangeRateFromTextField.text = inputWorkings
    }
    
    @IBAction func pressedClear(_ sender: UIButton) {
        
        clearAllTexts()
        exchangeRateFromTextField.becomeFirstResponder()
    }

    @IBAction func pressedDelete(_ sender: UIButton) {
        
        if(!inputWorkings.isEmpty){
            inputWorkings.removeLast()
            exchangeRateFromTextField.text = inputWorkings
        }
    }
    
    @IBAction func pressedSwap(_ sender: UIButton) {
        
        let temp: String = exchangeRateToPicker.text!
        exchangeRateToPicker.text = exchangeRateFromPicker.text
        exchangeRateFromPicker.text = temp
        
        pressedCalculate(sender)
    
    }
    
    
    
    
}

//MARK: -  Implementation of ExchangeRateManagerDelegate Protocol

extension ExchangeRateViewController: ExchangeRateManagerDelegate{
    
    func didUpdateExchangeRate(_ exchangeRateManager: ExchangeRateManager, exchange: ExchangeRateModel) {
  
        DispatchQueue.main.async {
            
            let formattedFinalResult = String(format: "%.1f", locale: Locale.current, Double(exchange.finalResult))
            self.exchangeRateToTextField.text = formattedFinalResult

        }
    }
    func didFailWithError(error: Error) {
        createAlertMessage("환율 데이터 가져오기 실패", "데이터 연결 확인 후 다시 시도 부탁드립니다.")
        print(error.localizedDescription)
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
        clearAllTexts()
        self.view.endEditing(true)
        exchangeRateFromTextField.becomeFirstResponder()
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

//MARK: - UI Configuration Methods

extension ExchangeRateViewController {
    
    func setButtonUI(for button: UIButton, color: UIColor) {
        
        button.backgroundColor = color
        button.layer.cornerRadius = button.frame.width / 2
        
//        button.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
//        button.layer.shadowRadius = 2.0
//        button.layer.shadowOpacity = 0.5
        
        button.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 30)
    }
    
    func configureUIButton() {
    
        // Number buttons
        for button in numberButtonCollection {
            setButtonUI(for: button, color: .white)
        }
        
        // Operation buttons - Basic configurations
        for button in operationButtonCollection {
            
            let color = UIColor(red: 0.76, green: 0.15, blue: 0.18, alpha: 1.00)
            
            setButtonUI(for: button, color: color)
        }
        
        // Separate button configurations for each operation buttons
        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .small)
        
        // Equal button
        let equalButtonImage = UIImage(systemName: "equal", withConfiguration: smallConfiguration)
        operationButtonCollection[0].setImage(equalButtonImage, for: .normal)
        
        // Swap button
        operationButtonCollection[2].titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 40)
        
    
        
        // Delete button
        let deleteButtonImage = UIImage(systemName: "delete.left.fill", withConfiguration: smallConfiguration)
        operationButtonCollection[3].setImage(deleteButtonImage, for: .normal)
        
    }
}

//MARK: - Other Methods

extension ExchangeRateViewController{
    
    func clearAllTexts(){
        
        exchangeRateFromTextField.text = ""
        exchangeRateToTextField.text = ""
        inputWorkings = ""
    }
    
    func createAlertMessage(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
