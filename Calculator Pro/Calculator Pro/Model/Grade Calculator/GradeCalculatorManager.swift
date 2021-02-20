import Foundation

struct GradeCalculatorManager{
    
    var totalCredit: Int
    var totalGrade: Double
    
    var possibleGrades = Constants.GradeCalcStrings.possibleGradeArrayOne
    
    // Calculate credit (학점)
    mutating func calculateFinalCredit(gradeInfo: [GradeInfo])->Int{
        
        totalCredit = 0
        
        for credits in gradeInfo{
            if let credit = credits.credit{
                totalCredit += credit
            }
        }
        return totalCredit
    }
    
    // Calculate Final GPA (성적)
    mutating func calculateFinalGrade(gradeInfo: [GradeInfo])->Double{
        
        totalGrade = 0.0
        
        for grade in gradeInfo{
            
            if let eachCredit = grade.credit, let eachGrade = grade.grade{
                
                let eachCreditInDouble = Double(eachCredit)
                totalGrade += (eachCreditInDouble * eachGrade)
                
            }
        }
        
        let totalCreditInDouble = Double(totalCredit)
        totalGrade = totalGrade / totalCreditInDouble
        return totalGrade
    }
    
}
