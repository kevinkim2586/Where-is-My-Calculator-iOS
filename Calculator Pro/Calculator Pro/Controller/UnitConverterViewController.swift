import UIKit

class UnitConverterViewController: UIViewController {

    @IBOutlet weak var unitFromButton: UIButton!
    
    var unitConverterManager = UnitConverterManager(selectedSection: 0)
    
    var selectedSection: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func showUnitFromSelectionListButton(_ sender: UIButton) {
        
        let button = sender as UIButton
        let buttonFrame = button.frame
        
        let popoverContentController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardID.unitPopoverStoryboardID) as? UnitPopOverFromContentController
        popoverContentController?.modalPresentationStyle = .popover
        
        if let popoverPresentationController = popoverContentController?.popoverPresentationController{
            
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = buttonFrame
            popoverPresentationController.delegate = self
            
            popoverContentController?.unitPopOverDelegate = self
            
            if let popoverController = popoverContentController{
                present(popoverController, animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func showUnitToSelectionListButton(_ sender: UIButton) {
        
        
    }
    
    
    
    
    

}

//MARK: - UnitPopOverContentControllerDelegate

extension UnitConverterViewController: UnitPopOverContentControllerDelegate{
    
    func didSelectFromUnit(controller: UnitPopOverFromContentController, name: String, selectedSection: Int) {
        self.selectedSection = selectedSection
        unitFromButton.setTitle(name, for: .normal)
    }
}



//MARK: - UIPopoverPresentationControllerDelegate

extension UnitConverterViewController: UIPopoverPresentationControllerDelegate{
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return true
    }
 
}
