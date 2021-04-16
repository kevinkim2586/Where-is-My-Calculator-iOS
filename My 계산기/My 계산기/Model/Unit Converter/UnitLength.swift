import Foundation

enum UnitLength: Int {
    
    case millimeter = 0, centimeter, meter, kilometer, inch, feet, yard, mile
    
    static func setUnit(_ string: String) -> UnitLength? {
        
        if string == Constants.UnitConverterStrings.unitLengthArray[.millimeter]{
            return .millimeter
        } else if string == Constants.UnitConverterStrings.unitLengthArray[.centimeter]{
            return .centimeter
        } else if string == Constants.UnitConverterStrings.unitLengthArray[.meter]{
            return .meter
        } else if string == Constants.UnitConverterStrings.unitLengthArray[.kilometer]{
            return .kilometer
        } else if string == Constants.UnitConverterStrings.unitLengthArray[.inch]{
            return .inch
        } else if string == Constants.UnitConverterStrings.unitLengthArray[.feet]{
            return .feet
        } else if string == Constants.UnitConverterStrings.unitLengthArray[.yard]{
            return .yard
        } else if string == Constants.UnitConverterStrings.unitLengthArray[.mile]{
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
