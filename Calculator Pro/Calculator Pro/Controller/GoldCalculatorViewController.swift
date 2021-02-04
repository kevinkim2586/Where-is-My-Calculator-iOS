import UIKit


class GoldCalculatorViewController: UIViewController {

    
    let APIKey = "goldapi-3ldrukkm196k6-io"
    
    let urlString = "https://www.goldapi.io/api/XAU/USD"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performRequest(with: urlString)
        
    }
    
    
        
    
    func performRequest(with url: String){
        
        var semaphore = DispatchSemaphore (value: 0)
    
        if let url = URL(string: urlString){
            var request = URLRequest(url: url, timeoutInterval:  Double.infinity)
            request.addValue("goldapi-3ldrukkm196k6-io", forHTTPHeaderField: "x-access-token")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
              print(String(data: data, encoding: .utf8)!)
              semaphore.signal()
            }
            
            task.resume()
            semaphore.wait()
        }
        
    }
    

}
