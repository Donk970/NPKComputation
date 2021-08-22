//
//  File.swift
//  
//
//  Created by DoodleBytes on 8/19/21.
//

import Foundation




public enum MatrixError: Error {
    case Unknown( message: String )
    case Unimplemented( message: String )
    case IdentityError( message: String )
    case RowBoundsError( message: String )
    case ColumnBoundsError( message: String )
    case LengthMismatchError( message: String )
    case InvalidMatrixError( message: String )
    case NotSquareMatrixError( message: String )
}




public enum Axis: Int {
    case row = 1
    case column
    
    public func tuple(for values: [Double]) -> N_Tuple {
        switch self {
        case .row: return RowTuple(values: values)
        case .column: return ColumnTuple(values: values)
        }
    }
}




extension Double {
    var formatted: String {
        return String(format: "%.2f", self)
    }
}
