import UIKit

protocol ExchangeRateManagerDelegate {
    
    func didUpdateExchangeRate(_ exchangeRateManager: ExchangeRateManager, exchange: ExchangeRateModel)
    func didFailWithError(error: Error)
}



struct ExchangeRateManager{
    
    let countries = ["대한민국", "미국", "캐나다"]
    
    // Properties for API Networking
    let exchangeRateURL = Constants.ExchangeRateStrings.basicURL
    let apiKey = Constants.ExchangeRateStrings.keyForExchangeRate
    var currentDate = "DEFAULT"
    var apiRequestType = "AP01"            //AP01 : 환율, AP02 : 대출금리, AP03 : 국제금리
    
    // Properties needed for conversion calculation
    var exchangeRateFrom = ""
    var exchangeRateTo = ""
    
    var inputAmount: Int = 0
    
    
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
            print("Error in converting currency unit to JSON key value")
            return "Error in converting currency unit to JSON key value"
        }
    }
    
}


//MARK: - API Networking & Parsing JSON Methods

extension ExchangeRateManager{
    
    mutating func fetchExchangeRate(for amount: Int){
        
        inputAmount = amount
        
        fetchCurrentDate()
        
        //let urlString = "\(Constants.ExchangeRateStrings.basicURL)\(Constants.ExchangeRateStrings.keyForExchangeRate)&searchdate=\(currentDate)&data=\(apiRequestType)"
    
        let urlString = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=0KWEJK5Ttln2L2s44erbx7aJbz0cCbdi&searchdate=20210201&data=AP01"
        
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    delegate?.didFailWithError(error: error!)
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

            for data in decodedData{
                
                // 환율을 구하려는 국가의 화폐 단위 (ex. USD)를 JSON 객체에서 찾으면
                if data.cur_unit == exchangeRateTo{
                    
                    
                    var dealBaseInString = data.deal_bas_r
                    dealBaseInString = dealBaseInString.replacingOccurrences(of: ",", with: "")
                    let dealBaseNumRounded = String(format: "%.0f", dealBaseInString)
                    if let dealBaseNum = Int(dealBaseNumRounded){
            
                        // 환율 계산
                        let resultValue = inputAmount/dealBaseNum
                    
                        let result = data.result
                        let cur_unit = data.cur_unit
                        let deal_base_r = data.deal_bas_r
                        
                        let exchangeRate = ExchangeRateModel(result: result, cur_unit: cur_unit, deal_bas_r: deal_base_r, resultValue: resultValue )
                        
                        return exchangeRate
                    }
                    else{
                        print("Error in optional binding data.deal_bas_r")
                    }
                }
            }
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        return nil
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
