import Foundation

struct ExchangeRateModel{
    
    let result: Int         // 조회 결과 (1 : 성공, 2 : DATA코드 오류, 3 : 인증코드 오류, 4 : 일일제한횟수 마감)
    let cur_unit: String    // 통화 코드 ("USD")
    let deal_bas_r: String  // 매매 기준율 (1000원 = "1117.2"
    
    
    var resultValue: Int    // 최종 출력값
}
