import UIKit

protocol GradeCellDelegate{
    
    func didChangeLectureName(lecture: String, tagNum: Int, cell: GradeCell)
    func didChangeCredit(credit: Int, tagNum: Int, cell: GradeCell)
    func didChangeGrade(grade: Double, tagNum: Int, cell: GradeCell)
}

class GradeCell: UITableViewCell {
    
    @IBOutlet weak var lectureTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!                 // Picker View 구현
    
    var newGradeInfo = GradeInfo()
    var gradeCalculatorManager = GradeCalculatorManager(totalCredit: 0, totalGrade: 0)
    
    var tagNum: Int = 0
    
    var gradeCellDelegate: GradeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lectureTextField.delegate = self
        creditTextField.delegate = self
        gradeTextField.delegate = self
        
        createPickerView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - Methods

extension GradeCell{
    
    
    
    
}


//MARK: - UITextFieldDelegate

extension GradeCell: UITextFieldDelegate{

    func textFieldDidEndEditing(_ textField: UITextField) {
     
        switch textField{
        case lectureTextField:
            
            if let lectureName = lectureTextField.text{
                gradeCellDelegate?.didChangeLectureName(lecture: lectureName, tagNum: tagNum, cell: self)
            }
        case creditTextField:

            if let creditString = creditTextField.text{
                if creditString.isNumber{
                    if let creditInt = Int(creditString){
                        gradeCellDelegate?.didChangeCredit(credit: creditInt, tagNum: tagNum, cell: self)
                    }
                    break
                }
                else{ creditTextField.text = "" }
            }

        case gradeTextField:
            
            if let gradeString = gradeTextField.text{
                if gradeString.isNumber || (Double(gradeString) != nil){
                    if let gradeDouble = Double(gradeString){
                        gradeCellDelegate?.didChangeGrade(grade: gradeDouble, tagNum: tagNum, cell: self)
                        
                        break
                    }
                }
                else { gradeTextField.text = "" }
            }

            
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case lectureTextField:
            creditTextField.becomeFirstResponder()
        case creditTextField:
            gradeTextField.becomeFirstResponder()
        case gradeTextField:
            gradeTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }

    
}

//MARK: - Picker View Related Methods & UIPickerViewDataSource & Delegate Methods

extension GradeCell: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func createPickerView(){
        
        let gradePickerView = UIPickerView()
        gradePickerView.backgroundColor = .white
        gradePickerView.dataSource = self
        gradePickerView.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemBlue
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.dismissPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.dismissPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        gradeTextField.inputView = gradePickerView
        gradeTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func dismissPicker(){
        
        GradeCalculatorViewController().view.endEditing(true)
        gradeTextField.resignFirstResponder()
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradeCalculatorManager.possibleGrades.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradeCalculatorManager.possibleGrades[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gradeTextField.text = gradeCalculatorManager.possibleGrades[row]
    }
    
}




//MARK: - String Extensions

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
