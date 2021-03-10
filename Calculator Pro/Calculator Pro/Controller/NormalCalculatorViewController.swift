import UIKit

enum Operation: String{
    
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case NULL = "Empty"
}

let operationSFSymbolArray = ["divide", "equal", "multiply", "plus", "minus"]

class NormalCalculatorViewController: UIViewController {

    @IBOutlet weak var calculatorResults: UILabel!
    
    @IBOutlet var numberButtonCollection: [UIButton]!
    @IBOutlet var operationButtonCollection: [UIButton]!
    @IBOutlet var clearButtonCollection: [UIButton]!
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .NULL

    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorResults.text = "0"
        configureButtonUI()
    }

    //MARK: - Methods
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        if runningNumber.count <= 8{                // 입력 숫자 제한
            runningNumber += "\(sender.tag)"
            calculatorResults.text = runningNumber
        }
    }
    
    @IBAction func pressedDot(_ sender: UIButton) {
        
        if runningNumber.count <= 7{                // 마지막 input 이 "." 이면 안 됨
            runningNumber += "."
            calculatorResults.text = runningNumber
        }
    }
    
    @IBAction func pressedEqual(_ sender: UIButton) {
        operation(operation: currentOperation)
    }
    
    @IBAction func pressedAdd(_ sender: UIButton) {
        operation(operation: .add)
    }
    
    @IBAction func pressedSubtract(_ sender: UIButton) {
        operation(operation: .subtract)
    }
    
    @IBAction func pressedMultiply(_ sender: UIButton) {
        operation(operation: .multiply)
    }
    
    @IBAction func pressedDivide(_ sender: UIButton) {
        operation(operation: .divide)
    }
    
    func checkIfValidNumber(_ value: String) -> Double{
        
        guard let value = Double(value) else{
            createAlertMessage("유효하지 않은 입력", "다시 입력해주세요.")
            calculatorResults.text = ""
            return 0
        }
        return value
    }
    
    func operation(operation: Operation){
        
        if currentOperation != .NULL{
            
            if runningNumber != ""{
                rightValue = runningNumber
                runningNumber = ""
                
                let leftNum = checkIfValidNumber(leftValue)
                let rightNum = checkIfValidNumber(rightValue)
                
                if currentOperation == .add{
                    
                    result = "\(leftNum + rightNum)"
                }
                else if currentOperation == .subtract{
                    result = "\(leftNum - rightNum)"
                }
                else if currentOperation == .multiply{
                    result = "\(leftNum * rightNum)"
                }
                else if currentOperation == .divide{
                    result = "\(leftNum / rightNum)"
                }
                leftValue = result
                
                let finalResult = checkIfValidNumber(result)
                
                if (finalResult.truncatingRemainder(dividingBy: 1) == 0){               // If divisible by 1
                    result = "\(Int(finalResult))"
                }
                calculatorResults.text = result
            }
            currentOperation = operation
        }
        else{
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
  
    //MARK: - Clearing functions
    @IBAction func allClearTap(_ sender: UIButton) {
        
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .NULL
        calculatorResults.text = "0"
    }
    
    @IBAction func backTap(_ sender: UIButton) {
        
        if(!runningNumber.isEmpty){
            runningNumber.removeLast()
            calculatorResults.text = runningNumber
        }
    }
    
}


//MARK: - UI Configuration Methods

extension NormalCalculatorViewController {
    
    func configureButtonUI() {
        
        var index = 0
        
        // Number buttons
        for button in numberButtonCollection {
            
            button.backgroundColor = .white
            button.layer.cornerRadius = button.frame.width / 2
            
        }

        // Operation buttons
        for button in operationButtonCollection {
        
            button.backgroundColor = UIColor(red: 0.02, green: 0.42, blue: 0.91, alpha: 1.00)
            button.layer.cornerRadius = button.frame.width / 2
            
            button.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 30)
            button.setTitleColor(.white, for: .normal)
           
            let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .small)
            let smallSymbolImage = UIImage(systemName: operationSFSymbolArray[index], withConfiguration: smallConfiguration)
            button.setImage(smallSymbolImage, for: .normal)
            index += 1
        }
        
        // Clear buttons
        for button in clearButtonCollection {
            
            button.backgroundColor = UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1.00)
            
            button.layer.cornerRadius = button.frame.width / 2
            

            button.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 40)
            button.setTitleColor(.white, for: .normal)
        }
        
        // Separate button configuration for "delete" button
        let smallConfiguration = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .small)
        let smallSymbolImage = UIImage(systemName: "delete.left.fill", withConfiguration: smallConfiguration)
        clearButtonCollection[1].setImage(smallSymbolImage, for: .normal)
        
    }
}




//MARK: - Alert Handling Methods

extension NormalCalculatorViewController{
    
    func createAlertMessage(_ title: String, _ message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

