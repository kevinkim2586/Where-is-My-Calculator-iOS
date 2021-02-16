import UIKit

protocol UnitPopOverToContentControllerDelegate{
    func didSelectToUnit(controller: UnitPopOverToContentController, name: String)
}

class UnitPopOverToContentController: UIViewController {

    @IBOutlet weak var toUnitSelectionTableView: UITableView!
    
    var unitPopOverToDelegate: UnitPopOverToContentControllerDelegate?
    
    let unitConverterManager = UnitConverterManager(selectedSection: 0)
    
    var selectedSection: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        toUnitSelectionTableView.delegate = self
        toUnitSelectionTableView.dataSource = self
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension UnitPopOverToContentController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch selectedSection {
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
    
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UnitConverterStrings.cellIdentifierToPopoverView, for: indexPath)
        
        let text: String
        
        switch selectedSection {
        case 0:
            text = unitConverterManager.unitLengthArray[indexPath.row]
        case 1:
            text = unitConverterManager.unitMassArray[indexPath.row]
        case 2:
            text = unitConverterManager.unitTemperatureArray[indexPath.row]
        default:
            text = ""
        }
        cell.textLabel?.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let unitSelected: String
        
        switch selectedSection {
        case 0:
            unitSelected = unitConverterManager.unitLengthArray[indexPath.row]
        case 1:
            unitSelected = unitConverterManager.unitMassArray[indexPath.row]
        case 2:
            unitSelected = unitConverterManager.unitTemperatureArray[indexPath.row]
        default:
            unitSelected = ""
        }
        unitPopOverToDelegate?.didSelectToUnit(controller: self, name: unitSelected)
        self.dismiss(animated: true, completion: nil)
    }
   
    
    
    
}
