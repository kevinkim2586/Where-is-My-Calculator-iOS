import UIKit


class GoldCalculatorViewController: UIViewController {

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
}


extension GoldCalculatorViewController: GoldCalculatorManagerDelegate{
    
    func didUpdateGoldPrice(_ goldCalculatorManager: GoldCalculatorManager, goldModel: GoldModel) {
        <#code#>
    }
    
    func didFailWithError(error: Error) {
        print("Failed to fetch Gold Price at this moment")
    }
    
    

    
    
}
