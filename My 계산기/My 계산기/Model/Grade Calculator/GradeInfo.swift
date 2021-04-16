import Foundation

struct GradeInfo: Codable{
    
    var lectureName: String?
    var credit: Int?
    var grade: Double?
}

/// global variable
var totalGradeInfo: [GradeInfo] = []
