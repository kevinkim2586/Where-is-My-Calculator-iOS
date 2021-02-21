struct Constants{
    
    struct Segues{
        static let normalCalculatorSegue                    = "HomeToNormal"
    }
    
    struct StoryboardID{
        static let unitPopoverFromStoryboardID              = "unitPopoverContentController"
        static let unitPopoverToStoryboardID                = "unitPopoverToContentController"
    }
    
    struct ExchangeRateStrings{
        static let countries                                = ["미국 달러","위안화", "유로","일본 옌", "한국 원"]
        static let keyForExchangeRate                       = "0017fb5715b05218a5601cf9"
        static let basicURL         = "https://v6.exchangerate-api.com/v6/0017fb5715b05218a5601cf9/latest/" // To
    }
    
    struct GradeCalcStrings{
        
        static let possibleGradeArrayOne                    = ["A+","A","B+","B","C+","C","D+","D","F"]
        static let possibleGradesArrayTwo                   = ["A+","A0","A-", "B+", "B0", "B-", "C+", "C0", "C-", "D+", "D0","D-","F"]
        
        static let highestPossibleGradeArray                = ["4.5", "4.3"]
        
        static let cellIdentifier                           = "ReusableCell"
        static let cellNibName                              = "GradeCell"
        static let userDefaultsKey                          = "savedGradeInfo"
    }
    
    struct UnitConverterStrings{
        static let cellIdentifierFromPopoverView            = "PopoverFromCell"
        static let cellIdentifierToPopoverView              = "PopoverToCell"
        
        static let unitLengthArray: [UnitLength : String] = [.millimeter : "밀리미터(mm)", .centimeter : "센티미터(cm)", .meter : "미터(m)", .kilometer : "킬로미터(km)", .inch : "인치(in)", .feet : "피트(ft)", .yard :"야드(yd)",  .mile :"마일(mile)"]
        
        static let unitMassArray: [UnitMass : String] = [.milligram : "밀리그램(mg)", .gram : "그램(g)", .kilogram : "킬로그램(kg)", .ton : "톤(t)", .ounce : "온스(oz)", .pound : "파운드(lb)"]
        
        static let unitTemperatureArray: [UnitTemperature : String] = [.celsius : "섭씨(°C)", .fahrenheit : "화씨(°F)", .kelvin : "절대온도(K)"]

    }
    
}
