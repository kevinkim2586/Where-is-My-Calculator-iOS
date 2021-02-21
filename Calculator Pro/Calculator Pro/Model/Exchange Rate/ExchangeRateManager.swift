import UIKit

protocol ExchangeRateManagerDelegate {
    
    func didUpdateExchangeRate(_ exchangeRateManager: ExchangeRateManager, exchange: ExchangeRateModel)
    func didFailWithError(error: Error)
}

struct ExchangeRateManager{
    
    let countries = Constants.ExchangeRateStrings.countries
    
    // Properties for API Networking
    let exchangeRateURL = Constants.ExchangeRateStrings.basicURL

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
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        return nil
    }
}

//MARK: - Methods

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

    func calculateFinalResult(with conversionRate: Double) -> Double{
        
        let result = Double(inputAmount) * conversionRate
        return result
    }
}
