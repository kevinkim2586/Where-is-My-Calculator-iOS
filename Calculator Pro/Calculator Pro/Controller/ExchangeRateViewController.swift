import UIKit

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet weak var exchangeRateFromPicker: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exchangeRateFromPicker.tintColor = .clear
        createPickerView()
        dismissPickerView()
        
    }
    
    
    
}

//MARK: - Picker View Related Methods

extension ExchangeRateViewController{
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        exchangeRateFromPicker.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        exchangeRateFromPicker.inputAccessoryView = toolBar
    }
    @objc func action() {
    }
}


extension ExchangeRateViewController: UITextFieldDelegate{
    
}

//MARK: - UIPickerViewDelegate

extension ExchangeRateViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        exchangeRateFromPicker.text = countries[row]
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
