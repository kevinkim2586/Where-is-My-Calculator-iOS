import UIKit

class GradeCell: UITableViewCell {
    
    @IBOutlet weak var lectureTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    
    var newGradeInfo = GradeInfo()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lectureTextField.delegate = self
        creditTextField.delegate = self
        gradeTextField.delegate = self
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        var newGradeInfo = GradeInfo()
    }
}


extension GradeCell: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField{
        case lectureTextField:
            
            if let lectureName = lectureTextField.text{
                newGradeInfo.lectureName = lectureName
            }else {
                newGradeInfo.lectureName = nil
            }
        case creditTextField:
            
            if let creditString = creditTextField.text{
                
                if creditString.isNumber{
                    let creditInt = Int(creditString)
                    newGradeInfo.credit = creditInt
                    break
                }
                else{ creditTextField.text = "" }
            }

        case gradeTextField:
            
            if let gradeString = gradeTextField.text{
                
                if gradeString.isNumber || (Double(gradeString) != nil){
                    let gradeDouble = Double(gradeString)
                    newGradeInfo.grade = gradeDouble
                    break
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



extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
