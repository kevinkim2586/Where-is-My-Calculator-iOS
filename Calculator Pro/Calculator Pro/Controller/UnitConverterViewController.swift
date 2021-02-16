import UIKit

class UnitConverterViewController: UIViewController {

    @IBOutlet weak var unitFromButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func showUnitSelectionListButton(_ sender: UIButton) {
        
        let button = sender as UIButton
        let buttonFrame = button.frame
        
        let popoverContentController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardID.unitPopoverStoryboardID) as? UnitPopOverContentController
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

}

//MARK: - UnitPopOverContentControllerDelegate

extension UnitConverterViewController: UnitPopOverContentControllerDelegate{
    
    func didSelectUnit(controller: UnitPopOverContentController, name: String) {
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
