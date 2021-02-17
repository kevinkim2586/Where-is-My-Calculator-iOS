import Foundation

struct UnitConverterManager{
    
    let unitLengthArray = ["밀리미터(mm)", "센티미터(cm)", "미터(m)", "킬로미터(km)", "인치(in)", "피트(ft)", "야드(yd)", "마일(mile)"]
    let unitMassArray = ["밀리그램(mg)", "그램(g)", "킬로그램(kg)", "톤(t)", "온스(oz)", "파운드(lb)"]
    let unitTemperatureArray = ["섭씨(°C)", "화씨(°F)", "절대온도(K)"]
    
    var selectedSection: Int
    
    enum UnitSections: Int, CaseIterable{
        
        case Length = 0
        case Mass = 1
        case Temperature = 2
    }
    
    
    enum UnitLength{
        case millimeter, centimeter, meter, kilometer, inch, feet, yard, mile
    }
    
    enum UnitMass{
        case milligram, gram, kilogram, ton, ounce, pound
    }

    enum UnitTemperature{
        case celsius, fahrenheit, kelvin
    }
    
    
    
    func setUnitFrom(_ userChoice: String){
        
        if unitLengthArray.contains(userChoice){
         
            var unitFrom: UnitLength
          
            if userChoice == unitLengthArray[0]{
                unitFrom = .millimeter
            }
            else if userChoice == unitLengthArray[1]{
                unitFrom = .centimeter
            }
            else if userChoice == unitLengthArray[2]{
                unitFrom = .meter
            }
            else if userChoice == unitLengthArray[3]{
                unitFrom = .kilometer
            }
            else if userChoice == unitLengthArray[4]{
                unitFrom = .inch
            }
            else if userChoice == unitLengthArray[5]{
                unitFrom = .feet
            }
            else if userChoice == unitLengthArray[6]{
                unitFrom = .yard
            }
            else if userChoice == unitLengthArray[7]{
                unitFrom = .mile
            }
            
            
        
            
        }
        else if unitMassArray.contains(userChoice){
            
        }
        else if unitTemperatureArray.contains(userChoice){
            
        }
    }
    
    func setUnitTo(_ userChoice: String){
        
        
    }
    
    
//    func convert(with value: Double) -> Double {
//
//
//
//    }
    
    

    
    
}
