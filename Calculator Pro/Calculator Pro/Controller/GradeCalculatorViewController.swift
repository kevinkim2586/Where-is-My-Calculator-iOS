import UIKit

class GradeCalculatorViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCreditLabel: UILabel!
    @IBOutlet weak var totalGradeLabel: UILabel!
    
    var rowNum = 1
    
    var gradeCalculatorManager = GradeCalculatorManager(totalCredit: 0, totalGrade: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: Constants.GradeCalcStrings.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.GradeCalcStrings.cellIdentifier)
    }

    @IBAction func pressedAddButton(_ sender: UIButton) {
        
        if rowNum == 10{
            createAlertMessage("과목 수 제한", "10개 이상의 과목을 입력할 수 없습니다.")
            return
        }
        increaseRowNum()
        tableView.insertRows(at: [IndexPath(row:rowNum-1, section: 0)], with: .bottom)
    }
    
    @IBAction func pressedCalculate(_ sender: UIButton) {

        self.view.endEditing(true)
    
        let totalCredit = gradeCalculatorManager.calculateFinalCredit(gradeInfo: totalGradeInfo)
        let totalGrade = gradeCalculatorManager.calculateFinalGrade(gradeInfo: totalGradeInfo)
        
        
        totalCreditLabel.text = String(format: "%d", totalCredit)
        totalGradeLabel.text = String(format: "%.2f", totalGrade)
    }
    
    
    
}

//MARK: - Methods

extension GradeCalculatorViewController{
    
    func increaseRowNum(){
        rowNum += 1
    }
    func decreaseRowNum(){
        rowNum -= 1
    }
    func createNewGradeInfo(){
        
        let newGradeInfo = GradeInfo(lectureName: nil, credit: nil, grade: nil)
        totalGradeInfo.append(newGradeInfo)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension GradeCalculatorViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GradeCalcStrings.cellIdentifier, for: indexPath) as! GradeCell
        
        cell.lectureTextField.text = ""
        cell.creditTextField.text = ""
        cell.gradeTextField.text = ""
        cell.tagNum = indexPath.row
        
        cell.gradeCellDelegate = self
    
        createNewGradeInfo()
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete{
            
            tableView.beginUpdates()
            
            totalGradeInfo.remove(at: indexPath.row)
            decreaseRowNum()
            tableView.deleteRows(at: [indexPath], with: .fade )
            
            tableView.endUpdates()
        }
    }
}

//MARK: - GradeCellDelegate

extension GradeCalculatorViewController: GradeCellDelegate{
    
    func didChangeLectureName(lecture: String, tagNum: Int, cell: GradeCell) {
        totalGradeInfo[tagNum].lectureName = lecture
    }
    
    func didChangeCredit(credit: Int, tagNum: Int, cell: GradeCell) {
        totalGradeInfo[tagNum].credit = credit
    }

    func didChangeGrade(grade: Double, tagNum: Int, cell: GradeCell) {
        totalGradeInfo[tagNum].grade = grade
    }
    
}

//MARK: - UITextFieldDelegate

extension GradeCalculatorViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}


//MARK: - Alert Handling Method

extension GradeCalculatorViewController{
    
    func createAlertMessage(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
