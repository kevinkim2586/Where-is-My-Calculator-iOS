import UIKit

protocol ExchangeRateManagerDelegate {
    
    func didUpdateExchangeRate(_ exchangeRateManager: ExchangeRateManager, exchange: ExchangeRateModel)
    func didFailWithError(error: Error)
}

struct ExchangeRateManager{
    
    let countries = Constants.ExchangeRateStrings.countries
    
    // Properties for API Networking
    let exchangeRateURL = Constants.ExchangeRateStrings.basicURL
    let apiKey = Constants.ExchangeRateStrings.keyForExchangeRate
    //var currentDate = "DEFAULT"
    //var apiRequestType = "AP01"                                 //AP01 : 환율, AP02 : 대출금리, AP03 : 국제금리
    
    // Properties needed for conversion calculation
    var exchangeRateFrom = ""
    var exchangeRateTo = ""

    var inputAmount: Int = 0
    
    var delegate: ExchangeRateManagerDelegate?
}


//MARK: - API Networking & Parsing JSON Methods

extension ExchangeRateManager{
    
    mutating func fetchExchangeRate(for amount: Int){
        
        inputAmount = amount
        
        // ex. https://v6.exchangerate-api.com/v6/YOUR-API-KEY/latest/USD
        let urlString = exchangeRateURL + exchangeRateFrom
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data else{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let exchangeModel = parseJSON(for: data){
                    delegate?.didUpdateExchangeRate(self, exchange: exchangeModel)
                }
            }
            task.resume()
        }
        
//        if let url = URL(string: urlString){
//
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//
//                if error != nil{
//                    delegate?.didFailWithError(error: error!)
//                }
//                if let safeData = data{
//
//                    if let exchangeRate = parseJSON(for: safeData){
//                        delegate?.didUpdateExchangeRate(self, exchange: exchangeRate)
//                    }
//                }
//            }
//            task.resume()
//        }
    }
    

    
    func determineConversionRate(_ data: ExchangeRateData) -> Double{
        
        switch exchangeRateTo{
        case "USD":
            return data.conversion_rates.USD
        case "CNY":
            return data.conversion_rates.CNY
        case "JPY":
            return data.conversion_rates.JPY
        case "KRW":
            return data.conversion_rates.KRW
        case "EUR":
            return data.conversion_rates.EUR
        default:
            return 0.0
        }
        
    }
    
    func parseJSON(for exchangeData: Data)->ExchangeRateModel?{
        
        let decoder = JSONDecoder()
    
        do{
            let decodedData = try decoder.decode(ExchangeRateData.self, from: exchangeData)

            if decodedData.result == "error" { print("There was an error decoding data") }
            
            else{
                
                let responseResult = decodedData.result
                let base_code = decodedData.base_code
                let conversionRate = determineConversionRate(decodedData)
                let finalResult = calculateFinalResult(with: conversionRate)
                
                let exchangeModel = ExchangeRateModel(result: responseResult, base_code: base_code, finalResult: finalResult)
                return exchangeModel
                
              
            }
//                if data.result == "error" { }
                
                
                
                // 환율을 구하려는 국가의 화폐 단위 (ex. USD)를 JSON 객체에서 찾으면
//                if data.cur_unit == exchangeRateTo{
//
//                    var dealBaseInString = data.deal_bas_r
//                    dealBaseInString = dealBaseInString.replacingOccurrences(of: ",", with: "")
//
//                    if let dealBaseNum = Float(dealBaseInString){
//
//                        // 환율 계산
//                        let resultValue = Float(inputAmount)/dealBaseNum
//
//
//                        let result = data.result
//                        let cur_unit = data.cur_unit
//                        let deal_base_r = data.deal_bas_r
//
//\
//                        let exchangeRate = ExchangeRateModel(result: result, cur_unit: cur_unit, deal_bas_r: deal_base_r, resultValue: resultValue )
//
//                        // 이쯤에서 계산이 이루어지는 function 이 하나 필요할듯
//
//                        return exchangeRate
//                    }
//                    else{
//                        print("Error in optional binding data.deal_bas_r")
//                    }
//                }
            //}
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        return nil
    }
    
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
        
        case countries[0]:
            return "USD"
        case countries[1]:
            return "CNY"
        case countries[2]:
            return "EUR"
        case countries[3]:
            return "JPY"
        case countries[4]:
            return "KRW"

        default:
            print("Error in converting currency unit to JSON key value")
            return "Error in converting currency unit to JSON key value"
        }
    }
    
    // Method to calculate final result to show User
    func calculateFinalResult(with conversionRate: Double) -> Double{
        
        let result = Double(inputAmount) * conversionRate
        return result
    }
}

//MARK: - Additional Needed Methods

extension ExchangeRateManager{
    

}
