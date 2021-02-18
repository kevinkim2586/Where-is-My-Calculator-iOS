import Foundation

enum UnitTemperature: Int{
    
    case celsius = 0, fahrenheit, kelvin
    
    
    static func setUnit(_ string: String) -> UnitTemperature?{
        
        if string == Constants.UnitConverterStrings.unitTemperatureArray[.celsius]{
            return .celsius
        } else if string == Constants.UnitConverterStrings.unitTemperatureArray[.fahrenheit]{
            return .fahrenheit
        } else if string == Constants.UnitConverterStrings.unitTemperatureArray[.kelvin]{
            return .kelvin
        } else{
            return nil
        }
    }
    
    
    func convertTo(unit to: UnitTemperature, value val: Double) -> Double{
        
        switch self {
        
        case .celsius:
            if to == .fahrenheit{
               return val * 9 / 5 + 32
            } else if to == .kelvin{
                return val + 273.15
            }

        case .fahrenheit:
            if to == .celsius{
        
                return (val - 32) * 5 / 9
            } else if to == .kelvin{
                return (val - 32) * 5 / 9 + 273.15
            }
            
        case .kelvin:
            if to == .celsius{
                return val - 273.15
            } else if to == .fahrenheit{
                return (val - 273.15) * 9 / 5 + 32
            }
        
        }
        return 0.0
    }
    
    
    
}
