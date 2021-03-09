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
        calculatorButtonCollection[1].backgroundColor = UIColor(red: 0.23, green: 0.53, blue: 0.93, alpha: 1.00)
        
        calculatorButtonCollection[2].backgroundColor = UIColor(red: 0.16, green: 0.53, blue: 0.33, alpha: 1.00)
        calculatorButtonCollection[3].backgroundColor = UIColor(red: 0.42, green: 0.27, blue: 0.53, alpha: 1.00)
        calculatorButtonCollection[4].backgroundColor = UIColor(red: 0.55, green: 0.50, blue: 0.45, alpha: 1.00)
        calculatorButtonCollection[5].backgroundColor = UIColor(red: 0.64, green: 0.26, blue: 0.27, alpha: 1.00)
        
        
    }
    
}


