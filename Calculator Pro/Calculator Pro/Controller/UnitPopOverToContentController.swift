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
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UnitConverterStrings.cellIdentifierToPopoverView, for: indexPath)
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
   
    
    
    
}
