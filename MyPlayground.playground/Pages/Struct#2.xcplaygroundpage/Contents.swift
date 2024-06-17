import Foundation

//Thiết kế chương trình:
//- đầu vào: một mảng các hình tam giác, chữ nhật, hình tròn (Không cần bước nhập, có thể fix cứng giá trị truyền vào)
//- đầu ra: một mảng chu vi, diện tích và tổng của cả 2 của các hình đa giác trên
//
//Yêu cầu:
//- Dùng struct, tự định nghĩa model thỏa mãn yêu cầu đề bài
//- Chú ý việc tái sử dụng code (tránh lặp code)

enum ShapeError: Error {
    case edgeLengthSmallerThanZero
    case radiusSmallerThanZero
    case invalidTriangle
    case outOfShape
}

protocol Shape {
    var area: Double { get }
    
    var perimeter: Double { get }
}

extension Shape {
    var sumOfBoth: Double {
        return area + perimeter
    }
}

struct Triangle: Shape {
    
    var firstEdgeLength: Double
    var secondEdgeLength: Double
    var thirdEdgeLength: Double
    
    var area: Double {
        let halfOfPerimeter = (firstEdgeLength + secondEdgeLength + thirdEdgeLength) / 2
        
        let halfOfPerimeterMinusFirstEdge = halfOfPerimeter - firstEdgeLength
        
        let halfOfPerimaterMinusSecondEdge = halfOfPerimeter - secondEdgeLength
        
        let halfOfPerimaterMinusThirdEdge = halfOfPerimeter - thirdEdgeLength
        
        return sqrt(Double(halfOfPerimeter * abs(halfOfPerimeterMinusFirstEdge) * abs(halfOfPerimaterMinusSecondEdge) * abs(halfOfPerimaterMinusThirdEdge)))
    }
    
    var perimeter: Double {
        return Double(firstEdgeLength + secondEdgeLength + thirdEdgeLength)
    }
//    
//    var sumOfBoth: Double {
//        return area + Double(perimeter)
//    }
    
    init(firstEdgeLength: Double, secondEdgeLength: Double, thirdEdgeLength: Double) throws {
        guard firstEdgeLength > 0 && secondEdgeLength > 0 && thirdEdgeLength > 0 else {
            throw ShapeError.edgeLengthSmallerThanZero
        }
        
        guard firstEdgeLength > secondEdgeLength + thirdEdgeLength || 
                secondEdgeLength > firstEdgeLength + thirdEdgeLength ||
                thirdEdgeLength > secondEdgeLength + firstEdgeLength else {
            throw ShapeError.invalidTriangle
        }
        
        self.firstEdgeLength = firstEdgeLength
        self.secondEdgeLength = secondEdgeLength
        self.thirdEdgeLength = thirdEdgeLength
    }
}

struct Rectangle: Shape {
    
    var length: Double
    
    var width: Double
    
    var area: Double {
        return (length * width)
    }
    
    var perimeter: Double {
        return ((length + width) * 2)
    }
    
//    var sumOfBoth: Double {
//        return area + (perimeter)
//    }
    
    init(length: Double, width: Double) throws {
        guard length > 0 && width > 0 else {
            throw(ShapeError.edgeLengthSmallerThanZero)
        }
        
        self.length = length
        self.width = width
    }
}

struct Circle: Shape {
    var radius: Double
    
    var area: Double {
        return .pi * pow(radius, 2)
    }
    
    var perimeter: Double {
        return 2 * .pi * radius
    }
//    
//    var sumOfBoth: Double {
//        return area + perimeter
//    }
    
    init(radius: Double) throws{
        guard radius > 0 else {
            throw(ShapeError.radiusSmallerThanZero)
        }
        self.radius = radius
    }
}

func calculatePAndA(shapes: [Shape]) throws -> [(Double, Double, Double)] {
    guard !shapes.isEmpty else {
        throw(ShapeError.outOfShape)
    }
    
    var listOfResult:[(Double, Double, Double)] = []
    
    for shape in shapes {
        listOfResult.append((shape.area, shape.perimeter, shape.sumOfBoth))
    }
    
    return listOfResult
}

do {
    print (try calculatePAndA(shapes: [Rectangle(length: 4.0, width: 5.0)]))
} catch ShapeError.outOfShape {
    print("There is no shapes")
} catch ShapeError.edgeLengthSmallerThanZero {
    print("There are negative inputs length in the init of the shapes")
} catch ShapeError.radiusSmallerThanZero {
    print("There are negative inputs radius length in the init of the shapes")
} catch ShapeError.invalidTriangle {
    print("Your three sides length can't make a triangle")
}

