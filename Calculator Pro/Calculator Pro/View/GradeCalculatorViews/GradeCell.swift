import UIKit

protocol GradeCellDelegate{
    
    func didChangeLectureName(lecture: String, tagNum: Int, cell: GradeCell)
    func didChangeCredit(credit: Int, tagNum: Int, cell: GradeCell)
    func didChangeGrade(grade: Double, tagNum: Int, cell: GradeCell)
}

class GradeCell: UITableViewCell {
    
    @IBOutlet weak var lectureTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!                  // Picker View 구현
    
    var newGradeInfo = GradeInfo()
    var gradeCalculatorManager = GradeCalculatorManager(totalCredit: 0, totalGrade: 0)
    
    var tagNum: Int = 0
    var highestPossibleGrade: Double = 0.0
    var gradeToDisplay = ""
    
    var gradeCellDelegate: GradeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpPossibleGradesList()
        
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

    func setUpPossibleGradesList(){
        
        if highestPossibleGrade == 4.5{
            gradeCalculatorManager.possibleGrades = Constants.GradeCalcStrings.possibleGradeArrayOne
        }else if highestPossibleGrade == 4.3{
            gradeCalculatorManager.possibleGrades = Constants.GradeCalcStrings.possibleGradesArrayTwo
        }
    }
    
    func convertGradeStringToDouble(_ grade: String) -> Double{
        
//        static let possibleGradeArrayOne = ["A+","A","B+","B","C+","C","D+","D","F"]
//        static let possibleGradesArrayTwo = ["A+","A0","A-", "B+", "B0", "B-", "C+", "C0", "C-", "D+", "D0","D-","F"]
        
        if grade == "A+"{
            return highestPossibleGrade == 4.5 ? 4.5 : 4.3
        } else if grade == "A" || grade == "A0"{
            return 4.0
        } else if grade == "A-"{
            return 3.7
        } else if grade == "B+"{
            return highestPossibleGrade == 4.5 ? 3.5 : 3.3
        } else if grade == "B" || grade == "B0"{
            return 3.0
        } else if grade == "B-"{
            return 2.7
        } else if grade == "C+"{
            return highestPossibleGrade == 4.5 ? 2.5 : 2.3
        } else if grade == "C" || grade == "C0"{
            return 2.0
        } else if grade == "C-"{
            return 1.7
        } else if grade == "D+"{
            return highestPossibleGrade == 4.5 ? 1.5 : 1.3
        } else if grade == "D" || grade == "D0"{
            return 1.0
        } else if grade == "D-"{
            return 0.7
        } else if grade == "F"{
            return 0.0
        } else{
            return 0
        }
    }
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
           
                let gradeDouble = convertGradeStringToDouble(gradeString)
                gradeCellDelegate?.didChangeGrade(grade: gradeDouble, tagNum: tagNum, cell: self)
                break
                
//                if gradeString.isNumber || (Double(gradeString) != nil){
//                    if let gradeDouble = Double(gradeString){
//                        gradeCellDelegate?.didChangeGrade(grade: gradeDouble, tagNum: tagNum, cell: self)
//
//                        break
//                    }
//                }
                
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
        
        gradeTextField.endEditing(true)
        gradeTextField.text = gradeToDisplay
        gradeTextField.resignFirstResponder()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if highestPossibleGrade == 4.5{
            return Constants.GradeCalcStrings.possibleGradeArrayOne.count
        }else{
            return Constants.GradeCalcStrings.possibleGradesArrayTwo.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if highestPossibleGrade == 4.5{
            return Constants.GradeCalcStrings.possibleGradeArrayOne[row]
        }else{
            return Constants.GradeCalcStrings.possibleGradesArrayTwo[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        gradeTextField.text = gradeCalculatorManager.possibleGrades[row]
        gradeToDisplay = gradeCalculatorManager.possibleGrades[row]
    }
    
}

//MARK: - String Extensions

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
