import UIKit

protocol GradeCellDelegate{
    
    func didChangeLectureName(lecture: String, tagNum: Int, cell: GradeCell)
    func didChangeCredit(credit: Int, tagNum: Int, cell: GradeCell)
    func didChangeGrade(grade: Double, tagNum: Int, cell: GradeCell)
}

class GradeCell: UITableViewCell {
    
    @IBOutlet weak var backgroundTextField: UITextField!
    @IBOutlet weak var textfieldImageView: UIImageView!
    @IBOutlet weak var lectureTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!                  // Picker View 구현
    
    var newGradeInfo = GradeInfo()
    var gradeCalculatorManager = GradeCalculatorManager(totalCredit: 0, totalGrade: 0)
    
    var tagNum: Int = 0
    var highestPossibleGrade: Double = 4.5
    var gradeToDisplay = ""                                         // Grade to display in each TextField
    
    var gradeCellDelegate: GradeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpPossibleGradesList()
        
        //Basic texfield Setup
        backgroundTextField.borderStyle = .none
        backgroundTextField.backgroundColor = UIColor.groupTableViewBackground // Use anycolor that give you a 2d look.

        //To apply corner radius
        backgroundTextField.layer.cornerRadius = 30

        //To apply border
        backgroundTextField.layer.borderWidth = 0.25
        backgroundTextField.layer.borderColor = UIColor.white.cgColor

        //To apply Shadow
//        backgroundTextField.layer.shadowOpacity = 1
//        backgroundTextField.layer.shadowRadius = 3.0
//        backgroundTextField.layer.shadowOffset = CGSize.zero // Use any CGSize
//        backgroundTextField.layer.shadowColor = UIColor.gray.cgColor

        //To apply padding
//        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: backgroundTextField.frame.height))
//        backgroundTextField.leftView = paddingView
    
      
        
        
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
    
    func convertGradeDoubleToString(_ grade: Double) -> String {
        
        if grade == 4.5 || grade == 4.3 {
            return "A+"
        } else if grade == 4.0 {
            return "A0"
        } else if grade == 3.7 {
            return "A-"
        } else if grade == 3.5 || grade == 3.3 {
            return "B+"
        } else if grade == 3.0 {
            return "B0"
        } else if grade == 2.7 {
            return "B-"
        } else if grade == 2.5 || grade == 2.3 {
            return "C+"
        } else if grade == 2.0 {
            return "C0"
        } else if grade == 1.7 {
            return "C-"
        } else if grade == 1.5 || grade == 1.3 {
            return "D+"
        } else if grade == 1.0 {
            return "D0"
        } else if grade == 0.7 {
            return "D-"
        } else if grade == 0.0 {
            return "F"
        } else {
            return ""
        }
    }
    
    func clearCellContents(){
        
        lectureTextField.text = ""
        creditTextField.text = ""
        gradeTextField.text = ""
        gradeToDisplay = ""
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
                else { creditTextField.text = "" }
            }
        case gradeTextField:
            
            if gradeToDisplay == "" || gradeToDisplay.isEmpty {
                gradeToDisplay = "A+"
                gradeTextField.text = "A+"
            }
        
            if let gradeString = gradeTextField.text{
           
                let gradeDouble = convertGradeStringToDouble(gradeString)
                gradeCellDelegate?.didChangeGrade(grade: gradeDouble, tagNum: tagNum, cell: self)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
            if range.length + range.location > currentCharacterCount {
                return false
            }
            let newLength = currentCharacterCount + string.count - range.length
            return newLength <= 30
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
        
        let doneButton = UIBarButtonItem(title: "완료", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.dismissPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.dismissPicker))

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
        }else {
            return Constants.GradeCalcStrings.possibleGradesArrayTwo.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if highestPossibleGrade == 4.5{
            gradeCalculatorManager.possibleGrades = Constants.GradeCalcStrings.possibleGradeArrayOne
            return Constants.GradeCalcStrings.possibleGradeArrayOne[row]
        }else {
            gradeCalculatorManager.possibleGrades = Constants.GradeCalcStrings.possibleGradesArrayTwo
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
