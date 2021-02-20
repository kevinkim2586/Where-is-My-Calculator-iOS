import Foundation

struct UnitConverterManager{
    
    
//    let unitLengthArray = Constants.UnitConverterStrings.unitLengthArray.values
//    let unitMassArray = Constants.UnitConverterStrings.unitMassArray.values
//    let unitTemperatureArray = Constants.UnitConverterStrings.unitTemperatureArray.values

    let unitLengthArray = ["밀리미터(mm)", "센티미터(cm)", "미터(m)", "킬로미터(km)", "인치(in)", "피트(ft)", "야드(yd)", "마일(mile)"]
    let unitMassArray = ["밀리그램(mg)", "그램(g)", "킬로그램(kg)", "톤(t)", "온스(oz)", "파운드(lb)"]
    let unitTemperatureArray = ["섭씨(°C)", "화씨(°F)", "절대온도(K)"]
    
    var selectedSection: Int
    
    enum UnitSections: Int, CaseIterable{
        
        case Length = 0
        case Mass = 1
        case Temperature = 2
    }
}
 
