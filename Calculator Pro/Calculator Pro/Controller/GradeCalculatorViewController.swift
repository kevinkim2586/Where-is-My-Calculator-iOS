
import UIKit

class GradeCalculatorViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCreditLabel: UILabel!
    @IBOutlet weak var totalGradeLabel: UILabel!
    @IBOutlet weak var highestPossibleGradeTextField: UITextField!
    
    var selectedHighestPossibleGrade: Double = 4.5
    
    var gradeCalculatorManager = GradeCalculatorManager(totalCredit: 0, totalGrade: 0.0)
    
    var loadedGradeInfo = [GradeInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highestPossibleGradeTextField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.GradeCalcStrings.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.GradeCalcStrings.cellIdentifier)
        
        loadedGradeInfo = gradeCalculatorManager.loadUserDefaultData()
       
        createPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    @IBAction func pressedAddButton(_ sender: UIButton) {
        
        if totalGradeInfo.count == 10 || loadedGradeInfo.count == 10 {
            createAlertMessage("과목 수 제한", "10개 이상의 과목을 입력할 수 없습니다.")    // 굳이 제한을 둬야하는지 생각 다시 해보기
            return
        }
        createNewGradeInfo()                                                    // and appends to totalGradeInfo[]
        gradeCalculatorManager.saveToUserDefaults(totalGradeInfo)
        loadedGradeInfo = gradeCalculatorManager.loadUserDefaultData()
        
        tableView.insertRows(at: [IndexPath(row:totalGradeInfo.count - 1, section: 0)], with: .bottom)
    }
    
//    @IBAction func pressedCalculate(_ sender: UIButton) {
//
//        self.view.endEditing(true)
//
//        let totalCredit = gradeCalculatorManager.calculateFinalCredit(totalGradeInfo)
//        let totalGrade = gradeCalculatorManager.calculateFinalGrade(totalGradeInfo)
//
//        // User Defaults에 이때까지 작성한 데이터 저장
//        gradeCalculatorManager.saveToUserDefaults(totalGradeInfo)
//
//        print(totalCredit)
//        print(totalGrade)
//
//        totalCreditLabel.text = String(format: "%d", totalCredit)
//        totalGradeLabel.text = String(format: "%.2f", totalGrade)
//    }
    
    func calculateResult() {
        
        self.view.endEditing(true)
    
        let totalCredit = gradeCalculatorManager.calculateFinalCredit(totalGradeInfo)
        let totalGrade = gradeCalculatorManager.calculateFinalGrade(totalGradeInfo)
        
        // User Defaults에 이때까지 작성한 데이터 저장
        gradeCalculatorManager.saveToUserDefaults(totalGradeInfo)
        
        print(totalCredit)
        print(totalGrade)

        totalCreditLabel.text = String(format: "%d", totalCredit)
        totalGradeLabel.text = String(format: "%.2f", totalGrade)
    }
}

//MARK: - Methods

extension GradeCalculatorViewController{
    
    func createNewGradeInfo(){
        
        let newGradeInfo = GradeInfo(lectureName: nil, credit: nil, grade: nil)
        totalGradeInfo.append(newGradeInfo)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension GradeCalculatorViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // User Defaults 에 정보가 저장되어 있으면~
        if !loadedGradeInfo.isEmpty {
            totalGradeInfo = loadedGradeInfo // 굳이 필요?
            return loadedGradeInfo.count
        } else {
            return totalGradeInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GradeCalcStrings.cellIdentifier, for: indexPath) as! GradeCell
        
        func configureCell(){
            cell.tagNum = indexPath.row
            cell.highestPossibleGrade = selectedHighestPossibleGrade
            cell.gradeCellDelegate = self
        }
        print("indexPath: \(indexPath.row)")
        
        if !loadedGradeInfo.isEmpty {

            if let credit = loadedGradeInfo[indexPath.row].credit, let grade = loadedGradeInfo[indexPath.row].grade {
                
                let creditString = String(format: "%d", credit)
                let gradeString = cell.convertGradeDoubleToString(grade)
                
                cell.creditTextField.text = creditString
                cell.gradeTextField.text = gradeString
                cell.lectureTextField.text = loadedGradeInfo[indexPath.row].lectureName
                configureCell()
            }
            else {
                configureCell()
            }
        }
        
        else {
            cell.lectureTextField.text = ""
            cell.creditTextField.text = ""
            cell.gradeTextField.text = ""
            configureCell()
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete{
            
            tableView.beginUpdates()
                        
            let cell = self.tableView.cellForRow(at: indexPath) as! GradeCell
            cell.clearCellContents()
            
            totalGradeInfo.remove(at: indexPath.row)
            
            gradeCalculatorManager.saveToUserDefaults(totalGradeInfo)
            loadedGradeInfo = gradeCalculatorManager.loadUserDefaultData()
            
            tableView.deleteRows(at: [indexPath], with: .fade )
            
            tableView.endUpdates()
        }
    }
}

//MARK: - GradeCellDelegate

extension GradeCalculatorViewController: GradeCellDelegate {
    
    func didChangeLectureName(lecture: String, tagNum: Int, cell: GradeCell) {
        totalGradeInfo[tagNum].lectureName = lecture
        gradeCalculatorManager.saveToUserDefaults(totalGradeInfo)
        loadedGradeInfo = gradeCalculatorManager.loadUserDefaultData()
    }
    
    func didChangeCredit(credit: Int, tagNum: Int, cell: GradeCell) {
        totalGradeInfo[tagNum].credit = credit
        gradeCalculatorManager.saveToUserDefaults(totalGradeInfo)
        loadedGradeInfo = gradeCalculatorManager.loadUserDefaultData()
        
        calculateResult()
        
        self.view.endEditing(true)
    }

    func didChangeGrade(grade: Double, tagNum: Int, cell: GradeCell) {
        totalGradeInfo[tagNum].grade = grade
        gradeCalculatorManager.saveToUserDefaults(totalGradeInfo)
        loadedGradeInfo = gradeCalculatorManager.loadUserDefaultData()
        
        calculateResult()
    }
    
}

//MARK: - UITextFieldDelegate

extension GradeCalculatorViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}

//MARK: - Picker View Related Methods & UIPickerViewDataSource & Delegate Methods
// The below picker view related methods are for picking ["4.5", "4.3"], not the ones in Grade Cell

extension GradeCalculatorViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func createPickerView(){
        
        let highestGradePickerView = UIPickerView()
        highestGradePickerView.backgroundColor = .white
        highestGradePickerView.dataSource = self
        highestGradePickerView.delegate = self
        
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
        
        highestPossibleGradeTextField.inputView = highestGradePickerView
        highestPossibleGradeTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissPicker(){
        
        highestPossibleGradeTextField.endEditing(true)
        highestPossibleGradeTextField.resignFirstResponder()
        tableView.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.GradeCalcStrings.highestPossibleGradeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.GradeCalcStrings.highestPossibleGradeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedOption = Constants.GradeCalcStrings.highestPossibleGradeArray[row]
        
        highestPossibleGradeTextField.text = selectedOption
        selectedHighestPossibleGrade = Double(selectedOption) ?? 4.5
        tableView.reloadData()
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
