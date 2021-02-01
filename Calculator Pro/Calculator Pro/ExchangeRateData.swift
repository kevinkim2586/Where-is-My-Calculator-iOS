import Foundation

struct ExchangeRateData: Codable{
    
    let result: Int         // 조회 결과 (1 : 성공, 2 : DATA코드 오류, 3 : 인증코드 오류, 4 : 일일제한횟수 마감)
    let cur_unit: String    // 통화 코드 ("USD")
    let deal_bas_r: String  // 매매 기준율 (1000원 = "1117.2"
}


//MARK: - API 문서 링크
/*
 https://www.koreaexim.go.kr/site/program/openapi/openApiView?menuid=001003002002001&apino=2&viewtype=C#none
*/

//MARK: - 내 API 인증 Key
/*
 0KWEJK5Ttln2L2s44erbx7aJbz0cCbdi
*/
