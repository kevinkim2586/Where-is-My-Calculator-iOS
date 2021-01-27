
import UIKit

class NormalCalculatorViewController: UIViewController {
    
    @IBOutlet weak var calculatorWorkings: UILabel!
    @IBOutlet weak var calculatorResults: UILabel!
    
    var workings: String = ""
    
    var numPressedFirst: Bool = false
    var first: Double = 0.0
    var second: Double = 0.0
    var op: String = ""
    var result: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Functions
    
    // Clears all two labels
    func clearAll(){
        workings = ""
        calculatorWorkings.text = ""
        calculatorResults.text = "0"
    }
    
    // Only clears the result label
    func clearResultsLabel(){
        
        workings = ""
        calculatorResults.text = ""
    }
    
    func addToWorkings(value: String){
        
        workings = workings + value
        calculatorWorkings.text = workings
    }
    
    //MARK: - Numbers
    
    @IBAction func pressedNumber(_ sender: UIButton) {
        
        numPressedFirst = true
        workings += sender.currentTitle!
        calculatorResults.text = workings
        
    }
    
    @IBAction func pressedFunction(_ sender: UIButton) {
        
        op = sender.currentTitle!
        
        if(numPressedFirst){
            first = Double(workings) ?? 0
            calculatorWorkings.text = workings + sender.currentTitle!
            clearResultsLabel()
            numPressedFirst = false
        }
        else{
            return
        }
        
    }
    
    
    @IBAction func pressedEqual(_ sender: UIButton) {
        
        second = Double(workings) ?? 0
        calculatorWorkings.text! += calculatorResults.text ?? "Error"
        
        calculate(with: op)
        
        if(result.truncatingRemainder(dividingBy: 1)==0){
            calculatorResults.text = String(format: "%.0f", result)
        }
        else{
            calculatorResults.text = String(format: "%.2f", result)
        }
        
    }
        
    
    func calculate(with op: String){
        
        switch op{
        case "+": result = first + second
        case "-": result = first - second
        case "*": result = first * second
        case "/": result = first / second
            
        default:
            print("Error in displaying number")
        }
    }
    
    
    
    
    
    
    
    //MARK: - Calculator Functions
    @IBAction func allClearTap(_ sender: UIButton) {
        clearAll()
    }
    
    @IBAction func backTap(_ sender: UIButton) {
        
        if(!workings.isEmpty){
            workings.removeLast()
            calculatorResults.text = workings
        }
    }
    
    
       
    
    
    
    
    
    
}

