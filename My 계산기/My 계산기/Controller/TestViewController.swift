import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var numberButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        drawCircle()
        
    }
    

    func drawCircle() {
        
        numberButton.backgroundColor = .white
        numberButton.layer.cornerRadius = numberButton.frame.width / 2
        //numberButton.layer.masksToBounds = true
        
        numberButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        numberButton.layer.shadowRadius = 2.0
        numberButton.layer.shadowOpacity = 0.5
    
    }


}
