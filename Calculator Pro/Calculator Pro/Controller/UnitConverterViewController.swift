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
            
            if let popoverController = popoverContentController{
                present(popoverController, animated: true, completion: nil)
            }
        }
        
    }

}

extension UnitConverterViewController: UIPopoverPresentationControllerDelegate{
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
//    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
//        <#code#>
//    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return true
    }
    
    
    
}
