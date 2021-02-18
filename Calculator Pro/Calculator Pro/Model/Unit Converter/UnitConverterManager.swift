import Foundation

enum UnitLength: Int{
    
    case millimeter = 0, centimeter, meter, kilometer, inch, feet, yard, mile
    
    static func setFromUnit(_ string: String) -> UnitLength?{
        
        if string == "밀리미터(mm)"{
            return .millimeter
        } else if string == "센티미터(cm)"{
            return .centimeter
        } else if string == "미터(m)"{
            return .meter
        } else if string == "킬로미터(km)"{
            return .kilometer
        } else if string == "인치(in)"{
            return .inch
        } else if string == "피트(ft)"{
            return .feet
        } else if string == "야드(yd)"{
            return .yard
        } else if string == "마일(mile)"{
            return .mile
        } else{
            return nil
        }
    }
    
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
            } else if to == .kilometer{
                constant = 0.000025
            } else if to == .yard{
                constant = 0.027778
            } else if to == .millimeter{
                constant = 25.4
            }
            
        case .centimeter:
            if to == .inch {
                constant = 0.393701
            } else if to == .feet {
                constant = 0.032808
            } else if to == .meter {
                constant = 0.01
            } else if to == .mile {
                constant = 6.2137e-6
            } else if to == .kilometer{
                constant = 0.00001
            } else if to == .yard{
                constant = 0.010936
            } else if to == .millimeter{
                constant = 10
            }
            
        case .feet:
            if to == .inch {
                constant = 12
            } else if to == .centimeter {
                constant = 30.48
            } else if to == .meter {
                constant = 0.3048
            } else if to == .mile {
                constant = 0.000189
            } else if to == .kilometer{
                constant = 0.000305
            } else if to == .yard{
                constant = 0.333333
            } else if to == .millimeter{
                constant = 304.8
            }
            
        case .meter:
            if to == .inch {
                constant = 39.370079
            } else if to == .centimeter {
                constant = 100
            } else if to == .feet {
                constant = 3.28084
            } else if to == .mile {
                constant = 0.000621
            } else if to == .kilometer{
                constant = 0.001
            } else if to == .yard{
                constant = 1.093613
            } else if to == .millimeter{
                constant = 1000
            }
            
        case .mile:
            if to == .inch {
                constant = 63360
            } else if to == .centimeter {
                constant = 160934.4
            } else if to == .meter {
                constant = 1609.344
            } else if to == .feet {
                constant = 5280
            } else if to == .kilometer{
                constant = 1.609344
            } else if to == .yard {
                constant = 1760
            } else if to == .millimeter{
                constant = 1609344
            }
            
        case .millimeter:
            if to == .inch {
                constant = 0.03937
            } else if to == .centimeter {
                constant = 0.1
            } else if to == .meter {
                constant = 0.001
            } else if to == .feet {
                constant = 0.003281
            } else if to == .kilometer{
                constant = 1e-6
            } else if to == .yard {
                constant = 0.001094
            } else if to == .mile{
                constant = 6.2137
            }
            
        case .kilometer:
            if to == .inch {
                constant = 39370.0787
            } else if to == .centimeter {
                constant = 100000
            } else if to == .meter {
                constant = 1000
            } else if to == .feet {
                constant = 3280.8399
            } else if to == .millimeter{
                constant = 1000000
            } else if to == .yard {
                constant = 1093.6133
            } else if to == .mile{
                constant = 0.621371
            }
            
        case .yard:
            if to == .inch {
                constant = 36
            } else if to == .centimeter {
                constant = 91.44
            } else if to == .meter {
                constant = 0.9144
            } else if to == .feet {
                constant = 3
            } else if to == .millimeter{
                constant = 914.4
            } else if to == .kilometer {
                constant = 0.000914
            } else if to == .mile{
                constant = 0.000568
            }
        }
        
        return constant * val
    }
    

}

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
    
    
    
    // For mass conversion
    
    enum UnitMass{
        case milligram, gram, kilogram, ton, ounce, pound
    }
    
    // For temperature conversion

    enum UnitTemperature{
        case celsius, fahrenheit, kelvin
    }
    
    
    
   
    


    
    
}
