import UIKit


class HomeViewController: UIViewController {

    @IBOutlet var calculatorButtonCollection: [UIButton]!
    @IBOutlet var calculatorLabelCollection: [UILabel]!
    
    let buttonIconArray: [UIImage] = [
        
        UIImage(named: "Normal white icon")!,
        UIImage(named: "Normal white icon")!,
        UIImage(named: "Discount white icon")!,
        UIImage(named: "Gold white icon")!,
        UIImage(named: "Exchange white icon")!,
        UIImage(named: "Grade white icon")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "계산기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
    
  
        configureButtonUI()
    }
    
    
    func configureButtonUI() {
        
        var index = 0
        
        for button in calculatorButtonCollection {
            
            button.layer.cornerRadius = button.frame.width / 2
            //button.setBackgroundImage(buttonIconArray[index], for: .normal)
            button.setImage(buttonIconArray[index], for: .normal)
   
            index += 1
            
        }
        
        calculatorButtonCollection[0].backgroundColor = Constants.Colors.normalCalculatorButtonColor
        calculatorButtonCollection[1].backgroundColor = Constants.Colors.unitConverterButtonColor
        
        calculatorButtonCollection[2].backgroundColor = Constants.Colors.discountCalculatorButtonColor
        calculatorButtonCollection[3].backgroundColor = Constants.Colors.goldCalculatorButtonColor
        calculatorButtonCollection[4].backgroundColor =
            Constants.Colors.exchangeRateButtonColor
        calculatorButtonCollection[5].backgroundColor = Constants.Colors.gradeCalculatorButtonColor
        
        
    }
    
}


