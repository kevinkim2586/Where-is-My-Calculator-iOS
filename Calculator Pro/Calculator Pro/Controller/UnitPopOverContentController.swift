import UIKit

protocol UnitPopOverContentControllerDelegate {
    func didSelectUnit(controller: UnitPopOverContentController, name: String)
}

enum UnitSections: Int, CaseIterable{
    
    case Length = 0
    case Mass = 1
    case Temperature = 2
    
}


class UnitPopOverContentController: UIViewController {

    @IBOutlet weak var unitSelectionTableView: UITableView!
    
    var unitPopOverDelegate: UnitPopOverContentControllerDelegate?
    
    let unitConverterManager = UnitConverterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unitSelectionTableView.delegate = self
        unitSelectionTableView.dataSource = self

        
     
    }
    

}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension UnitPopOverContentController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return UnitSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return unitConverterManager.unitLengthArray.count
        case 1:
            return unitConverterManager.unitMassArray.count
        case 2:
            return unitConverterManager.unitTemperatureArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UnitConverterStrings.cellIdentifier, for: indexPath)
        
        let text: String
        
        if indexPath.section == 0{
            text = unitConverterManager.unitLengthArray[indexPath.row]
        }
        else if indexPath.section == 1{
            text = unitConverterManager.unitMassArray[indexPath.row]
        }
        else{
            text = unitConverterManager.unitTemperatureArray[indexPath.row]
        }
        
        cell.textLabel?.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section < 2{
            return section == 0 ? "길이" : "무게"
        }
        else{
            return "온도"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let unitSelected: String
        
        if indexPath.section == 0{
            unitSelected = unitConverterManager.unitLengthArray[indexPath.row]
        }
        else if indexPath.section == 1{
            unitSelected = unitConverterManager.unitMassArray[indexPath.row]
        }
        else{
            unitSelected = unitConverterManager.unitTemperatureArray[indexPath.row]
        }
        
    
    }
    

    
    
    
}
