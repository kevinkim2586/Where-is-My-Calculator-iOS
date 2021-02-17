import Foundation

struct GradeCalculatorManager{

    var totalCredit: Int
    var totalGrade: Double
    
    let possibleGrades = ["A+","A0","A-", "B+", "B0", "B-", "C+", "C0", "C-", "D+", "D0","D-","F","P","NP"]
    
    mutating func calculateFinalCredit(gradeInfo: [GradeInfo])->Int{
        
        totalCredit = 0
        
        for credits in gradeInfo{
            if let credit = credits.credit{
                totalCredit += credit
            }
        }
        return totalCredit
    }
    
    mutating func calculateFinalGrade(gradeInfo: [GradeInfo])->Double{
        
        totalGrade = 0.0
        
        for grades in gradeInfo{
            if let grade = grades.grade{
                totalGrade += grade
            }
        }
        
        totalGrade = Double(totalGrade) / Double(gradeInfo.count)
        print(gradeInfo.count)
        
        return totalGrade
    }

}
