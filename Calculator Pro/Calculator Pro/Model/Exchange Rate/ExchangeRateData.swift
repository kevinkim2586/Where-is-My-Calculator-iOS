import Foundation

//struct ExchangeRateData: Codable{
//
//    let result: Int         // 조회 결과 (1 : 성공, 2 : DATA코드 오류, 3 : 인증코드 오류, 4 : 일일제한횟수 마감)
//    let cur_unit: String    // 통화 코드 ("USD")
//    let deal_bas_r: String  // 매매 기준율 (1000원 = "1117.2"
//
//}

struct ExchangeRateData: Codable{
    
    let result: String                              // "success" or "error"
    let base_code: String                           // 기준이 되는 통화 ex. "USD"
    let conversion_rates: [ConversionRates]
    
    struct ConversionRates: Codable{
        
        let USD: Double
        let JPY: Double
        let CNY: Double
        let KRW: Double
        let EUR: Double
    }
}











//MARK: - API 문서 링크
/*
 1. https://www.koreaexim.go.kr/site/program/openapi/openApiView?menuid=001003002002001&apino=2&viewtype=C#none
 2. https://app.exchangerate-api.com/dashboard
 -> Example API Request :  https://v6.exchangerate-api.com/v6/0017fb5715b05218a5601cf9/latest/USD
*/

//MARK: - 내 API 인증 Key
/*
 1. 한국 수출입은행 API Key: 0KWEJK5Ttln2L2s44erbx7aJbz0cCbdi
 2. Exchange Rate API 사이트 API Key: 0017fb5715b05218a5601cf9
*/




