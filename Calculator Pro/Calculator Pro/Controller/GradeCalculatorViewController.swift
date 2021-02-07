import UIKit

class GradeCalculatorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var gradeInfo: [GradeInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: Constants.GradeCalcStrings.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.GradeCalcStrings.cellIdentifier)
        
    }
    

    @IBAction func pressedAddButton(_ sender: UIButton) {
        
        let newGradeInfo = GradeInfo(lectureName: nil, credit: nil, grade: nil)
        
        gradeInfo.append(newGradeInfo)
        
        tableView.reloadData()
    }
    
}


extension GradeCalculatorViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradeInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.GradeCalcStrings.cellIdentifier, for: indexPath) as! GradeCell
        
        cell.lectureTextField.text = ""
        cell.creditTextField.text = ""
        cell.gradeTextField.text = ""
        
        return cell
    }
    
    
    
}


