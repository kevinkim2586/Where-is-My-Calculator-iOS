import UIKit


class HomeViewController: UIViewController {

    @IBOutlet var calculatorButtonCollection: [UIButton]!
    @IBOutlet var calculatorLabelCollection: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "계산기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
    
  
        configureButtonUI()
    }
    
    
    func configureButtonUI() {
        
        for button in calculatorButtonCollection {
            
            button.layer.cornerRadius = button.frame.width / 2
            
//            button.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
//            button.layer.shadowRadius = 2.0
//            button.layer.shadowOpacity = 0.5
            
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


