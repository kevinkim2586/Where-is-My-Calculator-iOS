import Foundation

// Using https://www.goldapi.io/dashboard

protocol GoldCalculatorManagerDelegate{
    
    func didUpdateGoldPrice(_ goldCalculatorManager: GoldCalculatorManager, goldModel: GoldModel)
    func didFailWithError(error: Error)
}

struct GoldCalculatorManager{

    var goldDelegate: GoldCalculatorManagerDelegate?
    
    let APIKey = "goldapi-3ldrukkm196k6-io"
    let urlString = "https://www.goldapi.io/api/XAU/USD"
    
    
    
}

//MARK: - API Networking Methods

extension GoldCalculatorManager{
    
    func performRequest(with url: String){
        
        let semaphore = DispatchSemaphore (value: 0)
    
        if let url = URL(string: urlString){
            var request = URLRequest(url: url, timeoutInterval:  Double.infinity)
            request.addValue("goldapi-3ldrukkm196k6-io", forHTTPHeaderField: "x-access-token")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data else {
                    goldDelegate?.didFailWithError(error: error!)
                    return
                }
                if let goldModel = parseJSON(for: data){
                    goldDelegate?.didUpdateGoldPrice(self, goldModel: goldModel)
                }
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
        }
    }
    
    func parseJSON(for goldData: Data)->GoldModel?{
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(GoldData.self, from: goldData)
            
            let currency = decodedData.currency
            let metal = decodedData.metal
            let price = decodedData.price
            
            let goldModel = GoldModel(metal: metal, currency: currency, price: price)
            
            return goldModel
        }
        catch{
            goldDelegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
