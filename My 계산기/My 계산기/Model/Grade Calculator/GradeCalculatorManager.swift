import Foundation

struct GradeCalculatorManager{
    
    var totalCredit: Int
    var totalGrade: Double
    
    var possibleGrades = Constants.GradeCalcStrings.possibleGradeArrayOne
    
    // Calculate credit (학점)
    mutating func calculateFinalCredit(_ gradeInfo: [GradeInfo]) ->Int {
        
        totalCredit = 0
        
        for credits in gradeInfo{
            if let credit = credits.credit{
                totalCredit += credit
            }
        }
        return totalCredit
    }
    
    // Calculate Final GPA (성적)
    mutating func calculateFinalGrade(_ gradeInfo: [GradeInfo]) -> Double {
        
        totalGrade = 0.0
        
        for grade in gradeInfo{
            
            if let eachCredit = grade.credit, let eachGrade = grade.grade{
                
                let eachCreditInDouble = Double(eachCredit)
                totalGrade += (eachCreditInDouble * eachGrade)
            }
        }
        
        if totalCredit == 0 {
            return 0.0
        }
        
        let totalCreditInDouble = Double(totalCredit)
        totalGrade = totalGrade / totalCreditInDouble
        return totalGrade
    }
    
    // Save to User Defaults
    func saveToUserDefaults(_ gradeInfo: [GradeInfo]) {
        
        let data = gradeInfo.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: "gradeKey")
    }
    
    // Load User Defaults Data
    func loadUserDefaultData() -> [GradeInfo] {
        
        guard let encodedData = UserDefaults.standard.array(forKey: "gradeKey") as? [Data] else{
            return []
        }
        return encodedData.map { try! JSONDecoder().decode(GradeInfo.self, from: $0) }
    }
}
