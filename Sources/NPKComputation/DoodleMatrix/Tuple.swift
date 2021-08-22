//
//  File.swift
//  
//
//  Created by DoodleBytes on 8/19/21.
//

import Foundation



// MARK: - TUPLE
public protocol N_Tuple {
    var axis: Axis { get }
    var values: [Double] { get }
    var count: Int { get }
    subscript( index: Int ) -> Double { get }
    var description: String { get }
}

extension N_Tuple {
    public var count: Int {
        return values.count
    }
    
    public subscript( index: Int ) -> Double {
        get { return self.values[index] }
    }
    
    public var description: String {
        var string: String = "["
        var spacer: String = ""
        for item in self.values {
            string += "\(spacer)\(item.formatted)"
            spacer = ",  "
        }
        string += "]"
        return string
    }
}

public struct RowTuple: N_Tuple {
    public let axis: Axis = .row
    public let values: [Double]
    public init(values: [Double]) {
        self.values = values
    }
}

public struct ColumnTuple: N_Tuple {
    public let axis: Axis = .column
    public let values: [Double]
    public init(values: [Double]) {
        self.values = values
    }
}



/// Dot Product of two equal length tuples
public func * (a: N_Tuple, b: N_Tuple) throws -> Double {
    if a.count != b.count { throw MatrixError.LengthMismatchError(message: "tuple a: \(a.count) != b: \(b.count)") }
    return zip(a.values, b.values).map { $0.0 * $0.1 }.reduce(0) { $0 + $1 }
}

/// Scalar Product of a tuple and a scalar
public func * (a: N_Tuple, b: Double) -> N_Tuple {
    return a.axis.tuple( for: a.values.map { $0 * b } )
}

/// Scalar Product of a tuple and a scalar
public func * (b: Double, a: N_Tuple) -> N_Tuple {
    return a.axis.tuple( for: a.values.map { $0 * b } )
}



