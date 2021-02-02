import UIKit

protocol ExchangeRateManagerDelegate {
    
    func didUpdateExchangeRate(_ exchangeRateManager: ExchangeRateManager, exchange: ExchangeRateModel)
    func didFailWithError(error: Error)
}

let countries = ["대한민국", "미국", "캐나다"]

struct ExchangeRateManager{
    
    // Properties for API Networking
    let exchangeRateURL = Constants.ExchangeRateStrings.basicURL
    let apiKey = Constants.ExchangeRateStrings.keyForExchangeRate
    var currentDate = "DEFAULT"
    var apiRequestType = "AP01"            //AP01 : 환율, AP02 : 대출금리, AP03 : 국제금리
    
    // Properties needed for conversion calculation
    var exchangeRateFrom: String?
    var exchangeRateTo: String?
    
    var delegate: ExchangeRateManagerDelegate?
    
}


//MARK: - Result Calculation Methods

extension ExchangeRateManager{
    
    mutating func setCurrencyUnitForFrom(country: String){
        exchangeRateFrom = convertCurrencyUnitToJSONKey(country: country)
    }
    
    mutating func setCurrencyUnitForTo(country: String){
        exchangeRateTo = convertCurrencyUnitToJSONKey(country: country)
    }
    
    func convertCurrencyUnitToJSONKey(country: String)->String{
        
        switch country {
        case "대한민국":
            return "KRW"
        case "미국":
            return "USD"
        case "캐나다":
            return "CAD"
            
        default:
            return "Error in converting currency unit to JSON key value"
        }
    }
}


//MARK: - API Networking & Parsing JSON Methods

extension ExchangeRateManager{
    
    mutating func fetchExchangeRate(){
        
        fetchCurrentDate()
        
        let urlString = "\(Constants.ExchangeRateStrings.basicURL)\(Constants.ExchangeRateStrings.keyForExchangeRate)&searchdate=\(currentDate)&data=\(apiRequestType)"
    
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
            let decodedData = try decoder.decode([ExchangeRateData].self, from: exchangeData)
            
            
            
            
            
            
            let result = decodedData[22].result
            let cur_unit = decodedData[22].cur_unit
            let deal_bas_r = decodedData[22].deal_bas_r
          
            let exchangeRate = ExchangeRateModel(result: result, cur_unit: cur_unit, deal_bas_r: deal_bas_r)
            return exchangeRate
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

//MARK: - Additional Needed Methods

extension ExchangeRateManager{
    
    mutating func fetchCurrentDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let current_date_string = formatter.string(from: Date())
        currentDate = current_date_string
    }
}
