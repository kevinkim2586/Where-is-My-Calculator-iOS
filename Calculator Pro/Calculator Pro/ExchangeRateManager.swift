import UIKit

protocol ExchangeRateManagerDelegate {
    
    func didUpdateExchangeRate(_ exchangeRateManager: ExchangeRateManager, exchange: ExchangeRateModel)
    func didFailWithError(error: Error)
}

let countries = ["대한민국", "미국"]

struct ExchangeRateManager{
    
    let exchangeRateURL = "https://www.koreaexim.go.ksr/site/program/financial/exchangeJSON?authkey="
    let apiKey = Constants.APIKeys.keyForExchangeRate
    var currentDate = "DEFAULT"
    var apiRequestType = "AP01"                     //AP01 : 환율, AP02 : 대출금리, AP03 : 국제금리
    
    var delegate: ExchangeRateManagerDelegate?
    
    func fetchExchangeRate(for country: String){
        
        let urlString = "\(exchangeRateURL)\(apiKey)&searchdate=\(currentDate)&data=\(apiRequestType)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let exchangeRate = parseJSON(for: safeData){
                        delegate?.didUpdateExchangeRate(self, exchange: exchangeRate)
                    }
                }

            }
            task.resume()
        }
        
    }
    
    func parseJSON(for exchangeData: Data)->ExchangeRateModel?{
        
        let decoder = JSONDecoder()
        
        do{
            
            let decodedData = try decoder.decode(ExchangeRateData.self, from: exchangeData)
            let result = decodedData.result
            let cur_unit = decodedData.cur_unit
            let deal_bas_r = decodedData.deal_bas_r
            
            let exchangeRate = ExchangeRateModel(result: result, cur_unit: cur_unit, deal_bas_r: deal_bas_r)
            return exchangeRate
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    mutating func fetchCurrentDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let current_date_string = formatter.string(from: Date())
        currentDate = current_date_string
    }

}

