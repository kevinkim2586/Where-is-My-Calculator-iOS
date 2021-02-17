import UIKit

protocol UnitPopOverFromContentControllerDelegate {
    func didSelectFromUnit(controller: UnitPopOverFromContentController, name: String, selectedSection: Int)
    func showUnitToSelectionList()
}

class UnitPopOverFromContentController: UIViewController {

    @IBOutlet weak var fromUnitSelectionTableView: UITableView!
    
    var unitPopOverDelegate: UnitPopOverFromContentControllerDelegate?
    
    let unitConverterManager = UnitConverterManager(selectedSection: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromUnitSelectionTableView.delegate = self
        fromUnitSelectionTableView.dataSource = self
        
    }
    

}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension UnitPopOverFromContentController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return UnitConverterManager.UnitSections.allCases.count
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
      
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UnitConverterStrings.cellIdentifierFromPopoverView, for: indexPath)
        
        let text: String
        
        if indexPath.section == UnitConverterManager.UnitSections.Length.rawValue{
            text = unitConverterManager.unitLengthArray[indexPath.row]
        }
        else if indexPath.section == UnitConverterManager.UnitSections.Mass.rawValue{
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
        
        if indexPath.section == UnitConverterManager.UnitSections.Length.rawValue{
            unitSelected = unitConverterManager.unitLengthArray[indexPath.row]
        }
        else if indexPath.section == UnitConverterManager.UnitSections.Mass.rawValue{
            unitSelected = unitConverterManager.unitMassArray[indexPath.row]
        }
        else{
            unitSelected = unitConverterManager.unitTemperatureArray[indexPath.row]
        }
        unitPopOverDelegate?.didSelectFromUnit(controller: self, name: unitSelected, selectedSection: indexPath.section)
        
        self.dismiss(animated: true, completion: nil)
        unitPopOverDelegate?.showUnitToSelectionList()
    }
}
