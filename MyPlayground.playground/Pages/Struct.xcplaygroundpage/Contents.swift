import Foundation

//Thiết kế chương trình:
//- đầu vào: một mảng các hình đa giác đều (tam giác đều, hình vuông...) (Không cần bước nhập, có thể fix cứng giá trị truyền vào)
//- đầu ra: một mảng chu vi, diện tích của các hình đa giác trên
//
//Yêu cầu:
//- Dùng struct, tự định nghĩa model thỏa mãn yêu cầu đề bài
//- Chú ý việc tái sử dụng code (tránh lặp code)

struct Polygon {
    var numOfEdges: Int
    var edgeLength: Int
}

func calculate(polygons: [Polygon]) -> [(Int, Double)] {
    guard !polygons.isEmpty else {
        return []
    }
    
    var result:[(Int, Double)] = []
    
    for polygon in polygons {
        result.append(calculatePolygon(polygon: polygon))
    }
    return result
}


func calculatePolygon(polygon: Polygon) -> (Int, Double) {
    guard polygon.numOfEdges > 2 && polygon.edgeLength > 0 else {
        return (0, 0)
    }
    
    let perimeter = polygon.edgeLength * polygon.numOfEdges
    
    let pi: Double = Double.pi
    let cotangent: Double = 1 / tan(pi / Double(polygon.numOfEdges))
    let powOfEdges = 0.25 * pow(Double(polygon.edgeLength), 2) * Double(polygon.numOfEdges)
    let area: Double = powOfEdges * cotangent
    
    return (perimeter, area)
}

print(calculate(polygons: [Polygon(numOfEdges: 4, edgeLength: 4), Polygon(numOfEdges: 3, edgeLength: 3), Polygon(numOfEdges: 5, edgeLength: 5)]))



