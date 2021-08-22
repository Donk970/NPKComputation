import Foundation

/**
 The purpose of this playground is to develop the calculations to calculate
 the correct amounts of the three components of the General Hydroponics
 Flora series nutrients to achieve a specified N-P-K ratio for a specified
 total disolved solids value.
 */

func * (r: NPKRatio, n: Double) -> NPKRatio {
    return NPKRatio(n: r.n * n, p: r.p * n, k: r.k * n, label: r.label)
}
func * (n: Double, r: NPKRatio) -> NPKRatio {
    return NPKRatio(n: r.n * n, p: r.p * n, k: r.k * n, label: r.label)
}

/**
 A struct containing the N-P-K percentages for a nutrient solution
 */
public struct NPKRatio {
    let label: String
    let micro: Bool
    let n: Double
    let p: Double
    let k: Double
    
    public init(n: Double, p: Double, k: Double, micro: Bool = false, label: String) {
        self.n = n
        self.p = p
        self.k = k
        self.label = label
        self.micro = micro
    }
    
    public var column: ColumnTuple {
        return ColumnTuple(values: [self.n, self.p, self.k])
    }
    
    public var matrix: Matrix? {
        let values: [[Double]] = [
            [self.n],
            [self.p],
            [self.k]
        ]
        return Matrix(values: values)
    }
    
    var constants: ColumnTuple {
        return ColumnTuple(values: [self.n, self.p, self.k])
    }
}

