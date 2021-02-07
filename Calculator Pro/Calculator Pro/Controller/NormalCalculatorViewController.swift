import UIKit

enum Operation: String{
    
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case NULL = "Empty"
    
}

class NormalCalculatorViewController: UIViewController {

    @IBOutlet weak var calculatorResults: UILabel!
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .NULL

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorResults.text = "0"
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
    
    func operation(operation: Operation){
        
        if currentOperation != .NULL{
            
            if runningNumber != ""{
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .add{
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                else if currentOperation == .subtract{
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }
                else if currentOperation == .multiply{
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }
                else if currentOperation == .divide{
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                leftValue = result
                
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0){       // If is divisible by 1
                    result = "\(Int(Double(result)!))"
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

