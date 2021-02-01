import UIKit

class ExchangeRateViewController: UIViewController{
    
    @IBOutlet weak var exchangeRateFromPicker: UITextField!
    @IBOutlet weak var exchangeRateToPicker: UITextField!
    
    @IBOutlet weak var exchangeRateFromTextField: UITextField!
    @IBOutlet weak var exchangeRateToTextField: UITextField!
    
    
    
    var exchangeRateManager = ExchangeRateManager(exchangeRateFrom: nil, exchangeRateTo: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRateManager.delegate = self
        
        exchangeRateFromPicker.tintColor = .clear
        createPickerView()
        dismissPickerView()
        
        exchangeRateFromPicker.text = "대한민국"
        exchangeRateToPicker.text = "미국"
        

        
        exchangeRateFromPicker.setLeftIcon(icon: #imageLiteral(resourceName: "USA"))
    }

    
}



//MARK: -  Implementation of ExchangeRateManagerDelegate Protocol

extension ExchangeRateViewController: ExchangeRateManagerDelegate{
    
    func didUpdateExchangeRate(_ exchangeRateManager: ExchangeRateManager, exchange: ExchangeRateModel) {
        
        DispatchQueue.main.async {
            
            self.exchangeRateFromTextField.text = exchange.deal_bas_r
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
        fromPickerView.delegate = self
        
        // Lower PickerView
        let toPickerView = UIPickerView()
        toPickerView.tag = 1
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
        
        exchangeRateFromPicker.endEditing(true)
        exchangeRateToPicker.endEditing(true)
        
        if let fromCountry = exchangeRateFromPicker.text{
            
            exchangeRateManager.setCurrencyUnitForFrom(country: fromCountry)

        }
        else {return}
        
        if let toCountry = exchangeRateToPicker.text{
           
            exchangeRateManager.setCurrencyUnitForTo(country: toCountry)
        }
        else {return}
        
        
        
        
        
        
        //exchangeRateManager.
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
    
}


//MARK: - UIPickerViewDelegate

extension ExchangeRateViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0{
            exchangeRateFromPicker.text = countries[row]
        }
        else{
            exchangeRateToPicker.text = countries[row]
        }
    }
    
}

//MARK: - UIPickerViewDataSource

extension ExchangeRateViewController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
}
