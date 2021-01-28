
import UIKit

class NormalCalculatorViewController: UIViewController {
    
    @IBOutlet weak var calculatorWorkings: UILabel!
    @IBOutlet weak var calculatorResults: UILabel!
    
    var workings: String = ""
    
    var numPressedFirst: Bool = false
    var continuingInput: Bool = false
    
    var first: Double = 0.0
    var second: Double = 0.0
    var op: String = ""
    var result: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    //MARK: - Methods
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        numPressedFirst = true
        workings += sender.currentTitle!
        calculatorResults.text = workings
    }
    
    @IBAction func pressedFunction(_ sender: UIButton) {
        
        op = sender.currentTitle!
        
        if(numPressedFirst){
            
            if(continuingInput == true){
                
                calculatorWorkings.text = String(format: "%.0f", first + Double(workings)!) + op
                
                first = first + Double(workings)!
                
                clearResultsLabel()
            }
            else{
                calculatorWorkings.text = workings + sender.currentTitle!
                first = Double(workings) ?? 0
                
                clearResultsLabel()
                numPressedFirst = false
                
                continuingInput = true
            }
        }
    }
    
    
    @IBAction func pressedEqual(_ sender: UIButton) {
        
        second = Double(workings) ?? 0
        calculatorWorkings.text! += calculatorResults.text ?? "Error"
        
        calculate(with: op)
        
        if(result.truncatingRemainder(dividingBy: 1)==0){
            calculatorResults.text = String(format: "%.0f", result)
            workings = calculatorResults.text!
        }
        else{
            calculatorResults.text = String(format: "%.2f", result)
            workings = calculatorResults.text!
        }
    }
        
    func calculate(with op: String){
        
        switch op{
        case "+": result = first + second
        case "-": result = first - second
        case "*": result = first * second
        case "/": result = first / second
            
        default:
            print("Error in calculate()")
        }
    }
    
    
    
    //MARK: - Clearing functions
    @IBAction func allClearTap(_ sender: UIButton) {
        clearAll()
    }
    
    @IBAction func backTap(_ sender: UIButton) {
        
        if(!workings.isEmpty){
            workings.removeLast()
            calculatorResults.text = workings
        }
    }
    // Clears all two labels
    func clearAll(){
        workings = ""
        calculatorWorkings.text = ""
        calculatorResults.text = "0"
        continuingInput = false
    }
    
    // Only clears the result label
    func clearResultsLabel(){
        
        workings = ""
        calculatorResults.text = ""
    }
}

