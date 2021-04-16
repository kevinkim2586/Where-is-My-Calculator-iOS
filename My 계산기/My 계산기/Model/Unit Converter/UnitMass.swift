import Foundation

enum UnitMass: Int{
    
    case milligram = 0, gram, kilogram, ton, ounce, pound
    
    static func setUnit(_ string: String) -> UnitMass? {
        
        if string == Constants.UnitConverterStrings.unitMassArray[.milligram]{
            return .milligram
        } else if string == Constants.UnitConverterStrings.unitMassArray[.gram]{
            return .gram
        } else if string == Constants.UnitConverterStrings.unitMassArray[.kilogram]{
            return .kilogram
        } else if string == Constants.UnitConverterStrings.unitMassArray[.ton]{
            return .ton
        } else if string == Constants.UnitConverterStrings.unitMassArray[.ounce]{
            return .ounce
        } else if string == Constants.UnitConverterStrings.unitMassArray[.pound]{
            return .pound
        } else{
            return nil
        }
    }
    
    func convertTo(unit to: UnitMass, value val: Double) -> Double {
        
        var constant = 1.0
        
        switch self{
        
        case .milligram:
            if to == .gram{
                constant = 0.001
            } else if to == .kilogram{
                constant = 1e-6
            } else if to == .ton{
                constant = 10e-10
            } else if to == .ounce{
                constant = 0.000035
            } else if to == .pound{
                constant = 2.2046e-6
            }
        
        case .gram:
            if to == .milligram{
                constant = 1000
            } else if to == .kilogram{
                constant = 0.001
            } else if to == .ton{
                constant = 1e-6
            } else if to == .ounce{
                constant = 0.035274
            } else if to == .pound{
                constant = 0.002205
            }
            
        case .kilogram:
            if to == .milligram{
                constant = 1000000
            } else if to == .gram{
                constant = 1000
            } else if to == .ton{
                constant = 0.001
            } else if to == .ounce{
                constant = 35.273962
            } else if to == .pound{
                constant = 2.204623
            }
        
        case .ton:
            if to == .milligram{
                constant = 1e+9
            } else if to == .gram{
                constant = 1000000
            } else if to == .kilogram{
                constant = 1000
            } else if to == .ounce{
                constant = 35273.9619
            } else if to == .pound{
                constant = 2204.62262
            }
        
        case .ounce:
            if to == .milligram{
                constant = 28349.5231
            } else if to == .gram{
                constant = 28.349523
            } else if to == .kilogram{
                constant = 0.02835
            } else if to == .ton{
                constant = 0.000028
            } else if to == .pound{
                constant = 0.0625
            }
        
        case .pound:
            if to == .milligram{
                constant = 453592.37
            } else if to == .gram{
                constant = 453.59237
            } else if to == .kilogram{
                constant = 0.453592
            } else if to == .ton{
                constant = 0.000454
            } else if to == .ounce{
                constant = 16
            }
        }
        return constant * val
    }

}
