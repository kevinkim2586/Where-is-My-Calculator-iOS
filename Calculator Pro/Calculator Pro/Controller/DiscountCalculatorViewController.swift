import UIKit

class DiscountCalculatorViewController: UIViewController {
    
    @IBOutlet weak var originalPriceBackgroundTextField: UITextField!
    @IBOutlet weak var discountPercentageBackgroundTextField: UITextField!
    @IBOutlet weak var finalResultBackgroundTextField: UITextField!
    @IBOutlet var textFieldCollection: [UITextField]!
    
    @IBOutlet weak var originalPriceTextField: UITextField!
    @IBOutlet weak var discountPercentageTextField: UITextField!
    @IBOutlet weak var finalResultTextField: UITextField!
    
    @IBOutlet var numberButtonCollection: [UIButton]!
    @IBOutlet var operationButtonCollection: [UIButton]!
    
    var originalPriceWorkings: String = ""
    var discountPercentageWorkings: String = ""
    
    var discountCalculatorManager = DiscountCalculatorManager(originalPrice: 0.0, discountPercentage: 0.0, finalResult: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalPriceTextField.delegate = self
        discountPercentageTextField.delegate = self
        
        // Inserting a dummy UIView to prevent iPhone default keyboard from appearing
        originalPriceTextField.inputView = UIView()
        discountPercentageTextField.inputView = UIView()
        
        originalPriceTextField.becomeFirstResponder()
        configureUIButton()
        configureTextFieldUI()
    }
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        if originalPriceTextField.isEditing{
            
            originalPriceWorkings += sender.currentTitle!
            originalPriceTextField.text = originalPriceWorkings
        }
        else if discountPercentageTextField.isEditing{
            
            discountPercentageWorkings += sender.currentTitle!
            discountPercentageTextField.text = discountPercentageWorkings
        }
    }

    @IBAction func pressedCalculate(_ sender: UIButton) {
        
        guard let inputPrice = originalPriceTextField.text, let discountPercentage = discountPercentageTextField.text else{
            createAlertMessage("입력 값 확인", "입력 값을 다시 확인해주세요.")
            return
        }
        
        if let inputPriceDouble = Double(inputPrice), let discountPercentageDouble = Double(discountPercentage){
        
            discountCalculatorManager.originalPrice = inputPriceDouble
            discountCalculatorManager.discountPercentage = discountPercentageDouble
        } else {
            createAlertMessage("유효하지 않은 값", "다시 입력해주세요")
        }
        
        let finalResult = discountCalculatorManager.calculateFinalResult()
        
        if finalResult.truncatingRemainder(dividingBy: 1) == 0 {        // Determine if whole number
            let formattedResult = String(format: "%.0f", locale: Locale.current, Double(finalResult))
            finalResultTextField.text = formattedResult
            return
        }

        let formattedResult = String(format: "%.1f", locale: Locale.current, Double(finalResult))
        finalResultTextField.text = formattedResult
    }
    
    @IBAction func pressedDelete(_ sender: UIButton) {
        
        if originalPriceTextField.isEditing{
            
            if !originalPriceWorkings.isEmpty {
                originalPriceWorkings.removeLast()
                originalPriceTextField.text = originalPriceWorkings
            }
        }
        else if discountPercentageTextField.isEditing{
            
            if !discountPercentageWorkings.isEmpty {
                discountPercentageWorkings.removeLast()
                discountPercentageTextField.text = discountPercentageWorkings
            }
        }
    }
    
    @IBAction func pressedSwapButton(_ sender: UIButton) {
        
        if originalPriceTextField.isEditing {
            discountPercentageTextField.becomeFirstResponder()
        } else if discountPercentageTextField.isEditing {
            originalPriceTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func pressedClearButton(_ sender: UIButton) {
        
        originalPriceTextField.text = ""
        originalPriceWorkings = ""
        
        discountPercentageTextField.text = ""
        discountPercentageWorkings = ""
        
        finalResultTextField.text = ""
    }
}

//MARK: - UITextFieldDelegate

extension DiscountCalculatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        
        case originalPriceTextField:
            discountPercentageTextField.becomeFirstResponder()
        case discountPercentageTextField:
            discountPercentageTextField.resignFirstResponder()
        default: break
        }
        return true
    }
}

//MARK: -  UI Configuration Methods

extension DiscountCalculatorViewController {
    
    func setButtonUI(for button: UIButton, color: UIColor) {
        
        button.backgroundColor = color
        button.layer.cornerRadius = button.frame.width / 2
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30)
        //button.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 30)
    }
    
    func configureUIButton() {
    
        // Number buttons
        for button in numberButtonCollection {
            setButtonUI(for: button, color: .white)
        }
        
        // Operation buttons - Basic configurations
        for button in operationButtonCollection {
            let color = UIColor(red: 0.00, green: 0.41, blue: 0.22, alpha: 1.00)
            setButtonUI(for: button, color: color)
        }
        
        // Separate button configurations for each operation buttons
        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .small)
        
        // Equal button
        let equalButtonImage = UIImage(systemName: "equal", withConfiguration: smallConfiguration)
        operationButtonCollection[0].setImage(equalButtonImage, for: .normal)
        
        // Swap button
        var swapButtonImage = UIImage(named: "swapbutton_icon")
        swapButtonImage = swapButtonImage?.scalePreservingAspectRatio(targetSize: CGSize(width: 60, height: 60))
        operationButtonCollection[1].setImage(swapButtonImage, for: .normal)

        // Clear button
        operationButtonCollection[2].titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 40)

        
        // Delete button
        let deleteButtonImage = UIImage(systemName: "delete.left.fill", withConfiguration: smallConfiguration)
        operationButtonCollection[3].setImage(deleteButtonImage, for: .normal)
        
    }
    
    func configureTextFieldUI() {
 
        for textField in textFieldCollection {

            textField.borderStyle = .none
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 30
            textField.layer.borderWidth = 0.25
            textField.layer.borderColor = UIColor.white.cgColor
        }
    }
}

//MARK: - Other Methods

extension DiscountCalculatorViewController {
    
    func createAlertMessage(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
