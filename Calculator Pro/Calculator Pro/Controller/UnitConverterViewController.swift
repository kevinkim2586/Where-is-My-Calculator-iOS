import UIKit

class UnitConverterViewController: UIViewController {

    @IBOutlet weak var unitFromButton: UIButton!
    @IBOutlet weak var unitToButton: UIButton!
    @IBOutlet weak var unitFromTextField: UITextField!
    @IBOutlet weak var unitToTextField: UITextField!
    
    var inputWorkings: String = ""
    
    var unitConverterManager = UnitConverterManager(selectedSection: 0)
    
    var selectedSection: Int = 0
    
    var unitFromLength: UnitLength = .millimeter
    var unitToLength: UnitLength = .centimeter
    
    var unitFromMass: UnitMass = .gram
    var unitToMass: UnitMass = .kilogram
    
    var unitFromTemperature: UnitTemperature = .celsius
    var unitToTemperature: UnitTemperature = .fahrenheit
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        unitFromTextField.becomeFirstResponder()
        unitFromTextField.delegate = self
        unitToTextField.delegate = self
        
        unitFromTextField.inputView = UIView()
        
   
    }

   
    
    @IBAction func pressedClearButton(_ sender: UIButton) {
        
        unitFromTextField.text = ""
        unitToTextField.text = ""
    }
    
    @IBAction func pressedDeleteButton(_ sender: UIButton) {
     
        if(!inputWorkings.isEmpty){
            inputWorkings.removeLast()
            unitFromTextField.text = inputWorkings
        }
    }
    

    @IBAction func pressedNumber(_ sender: UIButton) {
        
        inputWorkings += sender.currentTitle!
        unitFromTextField.text = inputWorkings
    }
    
    
    
    @IBAction func pressedCalculate(_ sender: UIButton) {
        
        
        var result: Double = 0.0
        
        if let inputText = unitFromTextField.text {
            
            if !inputText.isEmpty{
                
                let inputNum = Double(inputText)!
                
                if selectedSection == 0 {
                    result = unitFromLength.convertTo(unit: unitToLength, value: inputNum)
                } else if selectedSection == 1 {
                    result = unitFromMass.convertTo(unit: unitToMass, value: inputNum)
                } else if selectedSection == 2 {
                    result = unitFromTemperature.convertTo(unit: unitToTemperature, value: inputNum)
                }
        
                unitToTextField.text = String(format: "%.5f", result)
            }
        }
    }
    
    
}


//MARK: - UnitPopOverFromContentControllerDelegate

extension UnitConverterViewController: UnitPopOverFromContentControllerDelegate{
    
    func didSelectFromUnit(controller: UnitPopOverFromContentController, name: String, selectedSection: Int) {
        self.selectedSection = selectedSection
        unitFromButton.setTitle(name, for: .normal)
        
        switch selectedSection{
        case 0: setUnitFromLength(for: name)
        case 1: setUnitFromMass(for: name)
        case 2: setUnitFromTemperature(for: name)
        default: return
        }
    }

    func setUnitFromLength(for name: String){
        
        if let unitLength = UnitLength.setUnit(name){
            unitFromLength = unitLength
            return
        }
        else{ print("Error while setUnitFromLength()") }
    }
    
    func setUnitFromMass(for name: String){
        
        if let unitMass = UnitMass.setUnit(name){
            unitFromMass = unitMass
            return
        }
        else{ print("Error while setUnitFromMass()") }
    }
    
    func setUnitFromTemperature(for name: String){
        
        if let unitTemp = UnitTemperature.setUnit(name){
            unitFromTemperature = unitTemp
            return
        }
        else{ print("Error while setUnitFromTemperature()") }
    }
    
    
    func showUnitToSelectionList(){

        let button = unitToButton!
        let buttonFrame = button.frame
    
        let popoverContentController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardID.unitPopoverToStoryboardID) as? UnitPopOverToContentController
        
        popoverContentController?.selectedSection = self.selectedSection
        popoverContentController?.modalPresentationStyle = .popover
        
        if let popoverPresentationController = popoverContentController?.popoverPresentationController{
            
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = buttonFrame
            popoverPresentationController.delegate = self
            
            popoverContentController?.unitPopOverToDelegate = self
            
            if let popoverController = popoverContentController{
                present(popoverController, animated: true, completion: nil)
            }
        }
    }
}

//MARK: - UnitPopOverToContentControllerDelegate

extension UnitConverterViewController: UnitPopOverToContentControllerDelegate{
    
    func didSelectToUnit(controller: UnitPopOverToContentController, name: String) {
        
        unitToButton.setTitle(name, for: .normal)
        switch selectedSection{
        case 0: setUnitToLength(for: name)
        case 1: setUnitToMass(for: name)
        case 2: setUnitToTemperature(for: name)
        default: return
        }
    }
    
    
    func setUnitToLength(for name: String){
        
        if let unitLength = UnitLength.setUnit(name){
            unitToLength = unitLength
            return
        }
        else { print("Error while setUnitToLength()") }
    }
    
    func setUnitToMass(for name: String){
        
        if let unitMass = UnitMass.setUnit(name){
            unitToMass = unitMass
            return
        }
        else { print("Error while setUnitToMass()") }
        
    }
    
    func setUnitToTemperature(for name: String){
        
        if let unitTemp = UnitTemperature.setUnit(name){
            unitToTemperature = unitTemp
            return
        }
        else { print("Error while setUnitToTemperature()") }
    }
 
}

//MARK: - @IBAction Methods to show Unit Selection Popovers

extension UnitConverterViewController{
    
    @IBAction func showUnitFromSelectionListButton(_ sender: UIButton) {
        
        let button = sender as UIButton
        let buttonFrame = button.frame
        
        let popoverContentController = storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardID.unitPopoverFromStoryboardID) as? UnitPopOverFromContentController
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
        showUnitToSelectionList()
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

//MARK: - UITextFieldDelegate

extension UnitConverterViewController: UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}
