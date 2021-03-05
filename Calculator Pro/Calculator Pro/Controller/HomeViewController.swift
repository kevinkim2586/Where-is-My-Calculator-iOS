import UIKit


class HomeViewController: UIViewController {

    @IBOutlet weak var normalCalculatorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "계산기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)]
    
  
    }
}


