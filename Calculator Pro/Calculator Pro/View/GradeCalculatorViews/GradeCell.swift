import UIKit

protocol GradeCellDelegate{
    
    func didChangeLectureName(lecture: String, tagNum: Int, cell: GradeCell)
    func didChangeCredit(credit: Int, tagNum: Int, cell: GradeCell)
    func didChangeGrade(grade: Double, tagNum: Int, cell: GradeCell)
}

class GradeCell: UITableViewCell {
    
    @IBOutlet weak var lectureTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    
    var newGradeInfo = GradeInfo()
    
    var tagNum: Int = 0
    
    var gradeCellDelegate: GradeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lectureTextField.delegate = self
        creditTextField.delegate = self
        gradeTextField.delegate = self
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


//MARK: - String Extensions

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
