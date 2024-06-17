import Foundation

struct Polygon {
    var numberOfEdge: Int
    var length: Int
    
    
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
    guard polygon.numberOfEdge > 2 && polygon.length > 0 else {
        return (0, 0)
    }
    
    let perimeter = polygon.length * polygon.numberOfEdge
    
    let pi: Double = Double.pi
    let cotangent: Double = 1 / tan(pi / Double(polygon.numberOfEdge))
    let powOfnumberOfEdge = 0.25 * pow(Double(polygon.length), 2) * Double(polygon.numberOfEdge)
    let area: Double = powOfnumberOfEdge * cotangent
    
    return (perimeter, area)
}

print(calculate(polygons: [Polygon(numberOfEdge: 4, length: 5), Polygon(numberOfEdge: 3, length: 5), Polygon(numberOfEdge: 5, length: 7)]))
