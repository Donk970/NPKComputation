import Foundation

/**
 The purpose of this playground is to develop the calculations to calculate
 the correct amounts of the three components of the General Hydroponics
 Flora series nutrients to achieve a specified N-P-K ratio for a specified
 total disolved solids value.
 */

func * (r: NPKRatio, n: Double) -> NPKRatio {
    return NPKRatio(n: r.n * n, p: r.p * n, k: r.k * n)
}
func * (n: Double, r: NPKRatio) -> NPKRatio {
    return NPKRatio(n: r.n * n, p: r.p * n, k: r.k * n)
}

/**
 A struct containing the N-P-K percentages for a nutrient solution
 */
public struct NPKRatio {
    let n: Double
    let p: Double
    let k: Double

    // General Hydroponics Flora NPK constants
    public static let micro: NPKRatio = NPKRatio(n: 5.0, p: 0.0, k: 1.0)
    public static let grow: NPKRatio = NPKRatio(n: 2.0, p: 1.0, k: 6.0)
    public static let bloom: NPKRatio = NPKRatio(n: 0.0, p: 5.0, k: 4.0)
    
    public var column: ColumnTuple {
        return ColumnTuple(values: [self.n, self.p, self.k])
    }
    
    
//    var matrix: Matrix? {
//        var columns: [ColumnTuple] = [
//
//        ]
//        var values: [[Double]] = [
//            [],
//            [],
//            []
//        ]
//        return try? Matrix(values: values)
    
    
    /**
     Given a target ratio of this instance of NPKRatio calculate the nutrient mix.
     
     This is a problem where you basically have three variables that have to be solved for:
     m, the amount of micro to add, g, the amount of Grow to add and b, the amount of Bloom
     to add but we have only two equations.  This means that we will have to make one of the
     variables a constant and then solve for the other two variables.
     
     In the General Hydroponics three part Flora series the Micro component seems to be almost
     all nitrogen without any other components so we will make m a constant and solve for the other
     two.  This can be done as an iteration
     */
    public var mix: MGBRatio {
        
        
        return MGBRatio(micro: 0.333333, grow: 0.333333, bloom: 0.333333)
    }
}
