import Foundation

struct DiscountCalculatorManager {
    
    var originalPrice: Double
    var discountPercentage: Double
    var finalResult: Double
    
    mutating func calculateFinalResult() -> Double{
    
        let percentage = discountPercentage * 0.01              // ex. 20% 를 0.2 로 반환
        let discountedAmount = originalPrice * percentage       // 할인되는 가격
        finalResult = originalPrice - discountedAmount
        
        return finalResult
    }  
}
