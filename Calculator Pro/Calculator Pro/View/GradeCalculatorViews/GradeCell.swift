import UIKit

class GradeCell: UITableViewCell {
    
    @IBOutlet weak var lectureTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
