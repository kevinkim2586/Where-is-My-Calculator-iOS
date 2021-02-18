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
    
    // For length conversion
    
    enum UnitLength: Int{
        
        case millimeter = 0, centimeter, meter, kilometer, inch, feet, yard, mile
        
        func convertTo(unit to: UnitLength, value val: Double) -> Double {
            var constant = 1.0
            switch self {
            case .inch:
                if to == .centimeter {
                    constant = 2.54
                } else if to == .feet {
                    constant = 0.08333333
                } else if to == .meter {
                    constant = 0.0254
                } else if to == .mile {
                    constant = 1.5783e-5
                }
                
            case .centimeter:
                if to == .inch {
                    constant = 0.0393701
                } else if to == .feet {
                    constant = 0.0328084
                } else if to == .meter {
                    constant = 0.01
                } else if to == .mile {
                    constant = 6.2137e-6
                }
                
            case .feet:
                if to == .inch {
                    constant = 12;
                } else if to == .centimeter {
                    constant = 30.48
                } else if to == .meter {
                    constant = 0.3048
                } else if to == .mile {
                    constant = 0.000189394
                }
                
            case .meter:
                if to == .inch {
                    constant = 39.3701
                } else if to == .centimeter {
                    constant = 100
                } else if to == .feet {
                    constant = 3.28084
                } else if to == .mile {
                    constant = 0.000621371
                }
                
            case .mile:
                if to == .inch {
                    constant = 63360
                } else if to == .centimeter {
                    constant = 160934
                } else if to == .feet {
                    constant = 5280
                } else if to == .meter {
                    constant = 1609.34
                }
            case .millimeter:
                <#code#>
            case .kilometer:
                <#code#>
            case .yard:
                <#code#>
            }
            
            return constant * val
        }
        
        
        
        
        
        
        
        
    }
    
    // For mass conversion
    
    enum UnitMass{
        case milligram, gram, kilogram, ton, ounce, pound
    }
    
    // For temperature conversion

    enum UnitTemperature{
        case celsius, fahrenheit, kelvin
    }
    
    
    
   
    


    
    
}
