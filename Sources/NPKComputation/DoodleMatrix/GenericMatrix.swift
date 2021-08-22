import Foundation








// MARK: - MATRIX
public protocol GenericMatrix {
    var values: [[Double]] { get set }
    
    var rows: Int { get }
    var rowTuples: [RowTuple] { get }
    var columns: Int { get }
    var columnTuples: [ColumnTuple] { get }
    
    var dimension: Int { get }
    var isValidMatrix: Bool { get }
    var isSquareMatrix: Bool { get }

    subscript( row: Int, column: Int ) -> Double { get set }
    subscript(row: Int) -> RowTuple? { get }
    subscript(col: Int) -> ColumnTuple? { get }

    static func identity(dimension: Int) throws -> GenericMatrix
    var identity: Result<GenericMatrix, MatrixError> { get }

    var determinant: Result<Double, MatrixError> { get }
    var minors:  Result<GenericMatrix, MatrixError> { get }
    var cofactors:  Result<GenericMatrix, MatrixError> { get }
    var adjugate: Result<GenericMatrix, MatrixError> { get }
    var inverse: Result<GenericMatrix, MatrixError> { get }
    
    var description: String { get }
}


extension GenericMatrix {
    public var isValidMatrix: Bool {
        var c: Int = -1
        for r in values { if( c == -1) { c = r.count } else if c != r.count { return false } }
        return true
    }
    
    public var isSquareMatrix: Bool {
        if !self.isValidMatrix { return false }
        return values[0].count == values.count
    }

    public var rows: Int {
        if !self.isValidMatrix { return -1 }
        return values.count
    }
    
    public var rowTuples: [RowTuple] {
        if !self.isValidMatrix { return [] }
        return values.map { RowTuple(values: $0) }
    }
    
    public var columns: Int {
        if !self.isValidMatrix { return -1 }
        return values[0].count
    }
    
    public var columnTuples: [ColumnTuple] {
        if !self.isValidMatrix { return [] }
        var tuples: [ColumnTuple] = []
        for i in 0 ..< self.columns {
            guard let tuple: ColumnTuple = self[i] else { return [] }
            tuples.append(tuple)
        }
        return tuples
    }

    public var dimension: Int {
        if !self.isValidMatrix { return -1 }
        if !self.isSquareMatrix { return -1 }
        return values[0].count
    }

    public subscript(row: Int, column: Int) -> Double {
        get {
            if row < 0 || row >= values.count { return Double.greatestFiniteMagnitude }
            let R: [Double] = values[row]
            if column < 0 || column >= R.count { return Double.greatestFiniteMagnitude }
            return R[column]
        }
        set {
            if row < 0 || row >= values.count { return }
            let R: [Double] = values[row]
            if column < 0 || column >= R.count { return }
            values[row][column] = 0
        }
    }
    
    public subscript(row: Int) -> RowTuple? {
        get {
            if row < 0 || row >= values.count { return nil }
            return RowTuple(values: self.values[row])
        }
    }
    
    public subscript(col: Int) -> ColumnTuple? {
        get {
            if col < 0 || col >= values[0].count { return nil }
            let column: [Double] = values.map { $0[col] }
            return ColumnTuple(values: column)
        }
    }

    public static func identity(dimension: Int) throws -> GenericMatrix {
        var rows: [[Double]] = []
        for i in 0..<dimension {
            var row: [Double] = []
            for j in 0..<dimension {
                row.append(j == i ? 1 : 0)
            }
            rows.append(row)
        }
        return try Matrix( values: rows )
    }
    
    public var identity: Result<GenericMatrix, MatrixError> {
        let dimension: Int = self.rows
        if dimension < 0 { return .failure(.IdentityError(message: "corrupt values"))}
        if dimension != self.columns { return .failure(.IdentityError(message: "rows != columns")) }
        do {
            return .success( try Self.identity(dimension: dimension) )
        } catch {
            return .failure(error as? MatrixError ?? .IdentityError(message: "unknown"))
        }
    }
    
    public var determinant: Result<Double, MatrixError> {
        if !self.isValidMatrix { return .failure(.InvalidMatrixError(message: "Not a valid matrix")) }
        if !self.isSquareMatrix { return .failure(.NotSquareMatrixError(message: "Not a square matrix")) }
        if self.dimension < 2 { return .failure(.InvalidMatrixError(message: "Matrix is too small")) }
        
        let m: [[Double]] = self.values
        switch self.dimension {
        case 2:
            let r: Double = ((m[0][0] * m[1][1]) - (m[1][0] * m[0][1]))
            return .success(r)
            
        case 3:
            /*
             a = m[0][0], b = m[0][1], c = m[0][2]
             d = m[1][0], e = m[1][1], f = m[1][2]
             g = m[2][0], h = m[2][1], i = m[2][2]
             
             |A| =    m[0][0] * (m[1][1] * m[2][2] − m[1][2] * m[2][1])
                    − m[0][1] * (m[1][0] * m[2][2] − m[1][2] * m[2][0])
                    + m[0][2] * (m[1][0] * m[2][1] − m[1][1] * m[2][0])
             */

            let r: Double =   m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1])
                            - m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0])
                            + m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])
            
            return .success(r)

        default:
            // TODO: Implement a general solution here
            return .failure(.Unimplemented(message: "Not doing determinants bigger than 3x3"))
        }
    }
    
    public var minors:  Result<GenericMatrix, MatrixError> {
        if !self.isValidMatrix { return .failure(.InvalidMatrixError(message: "Not a valid matrix")) }
        if !self.isSquareMatrix { return .failure(.NotSquareMatrixError(message: "Not a square matrix")) }
        if self.dimension < 2 { return .failure(.InvalidMatrixError(message: "Matrix is too small")) }
        
        let m: [[Double]] = self.values
        func _minor( a: Double, b: Double, c: Double, d: Double) -> Double {
            return (a * d) - (b * c)
        }

        switch self.dimension {
        case 2:
            let minors: [[Double]] = [
                [ fabs(m[1][1]), fabs(m[1][0]) ],
                [ fabs(m[0][1]), fabs(m[0][0]) ]
            ]
            guard let r: Matrix = try? Matrix(values: minors) else {
                return .failure(.InvalidMatrixError(message: "couldn't form the new matrix of minors"))
            }
            return .success(r)

        case 3:
            let minors: [[Double]] = [
                [
                    _minor(a: m[1][1], b: m[1][2], c: m[2][1], d: m[2][2]),
                    _minor(a: m[1][0], b: m[1][2], c: m[2][0], d: m[2][2]),
                    _minor(a: m[1][0], b: m[1][1], c: m[2][0], d: m[2][1])
                ],
                [
                    _minor(a: m[0][1], b: m[0][2], c: m[2][1], d: m[2][2]),
                    _minor(a: m[0][0], b: m[0][2], c: m[2][0], d: m[2][2]),
                    _minor(a: m[0][0], b: m[0][1], c: m[2][0], d: m[2][1])
                ],
                [
                    _minor(a: m[0][1], b: m[0][2], c: m[1][1], d: m[1][2]),
                    _minor(a: m[0][0], b: m[0][2], c: m[1][0], d: m[1][2]),
                    _minor(a: m[0][0], b: m[0][1], c: m[1][0], d: m[1][1])
                ]
            ]
            guard let r: Matrix = try? Matrix(values: minors) else {
                return .failure(.InvalidMatrixError(message: "couldn't form the new matrix of minors"))
            }
            return .success(r)
            
        default:
            // TODO: Implement a general solution here
            return .failure(.Unimplemented(message: "Not doing determinants bigger than 3x3"))
            
        }
    }
    
    public var cofactors:  Result<GenericMatrix, MatrixError> {
        if !self.isValidMatrix { return .failure(.InvalidMatrixError(message: "Not a valid matrix")) }
        if !self.isSquareMatrix { return .failure(.NotSquareMatrixError(message: "Not a square matrix")) }
        if self.dimension < 2 { return .failure(.InvalidMatrixError(message: "Matrix is too small")) }

        guard let minors: GenericMatrix = try? self.minors.get() else {
            return .failure(.InvalidMatrixError(message: "couldn't get minors"))
        }
        
        var sign: Double = 1
        func flip() { sign = -sign }
        var m: [[Double]] = minors.values
        for r in 0 ..< m.count {
            let row: [Double] = m[r]
            for c in 0 ..< row.count {
                let col: Double = row[c]
                m[r][c] = sign * col
                flip()
            }
        }
        guard let r: Matrix = try? Matrix(values: m) else {
            return .failure(.InvalidMatrixError(message: "couldn't form the new matrix of minors"))
        }
        return .success(r)
    }

    public var adjugate: Result<GenericMatrix, MatrixError> {
        if !self.isValidMatrix { return .failure(.InvalidMatrixError(message: "Not a valid matrix")) }
        if !self.isSquareMatrix { return .failure(.NotSquareMatrixError(message: "Not a square matrix")) }
        if self.dimension < 2 { return .failure(.InvalidMatrixError(message: "Matrix is too small")) }

        guard let cofactors: GenericMatrix = try? self.cofactors.get() else {
            return .failure(.InvalidMatrixError(message: "couldn't get cofactors"))
        }
        
        guard let r: Matrix = try? Matrix(rows: cofactors.columnTuples) else {
            return .failure(.InvalidMatrixError(message: "couldn't form the new matrix of minors"))
        }
        
        return .success(r)
    }
    
    public var inverse: Result<GenericMatrix, MatrixError> {
        if !self.isValidMatrix { return .failure(.InvalidMatrixError(message: "Not a valid matrix")) }
        if !self.isSquareMatrix { return .failure(.NotSquareMatrixError(message: "Not a square matrix")) }
        if self.dimension < 2 { return .failure(.InvalidMatrixError(message: "Matrix is too small")) }

        guard let adjugate: GenericMatrix = try? self.adjugate.get() else {
            return .failure(.InvalidMatrixError(message: "couldn't get adjugate"))
        }

        guard let determinant: Double = try? self.determinant.get() else {
            return .failure(.InvalidMatrixError(message: "couldn't get determinant"))
        }
        if fabs(determinant) < 0.0000001 {
            return .failure(.InvalidMatrixError(message: "got zero determinant"))
        }

        guard let r: GenericMatrix = try? (1/determinant) * adjugate else {
            return .failure(.InvalidMatrixError(message: "unable to multiply adjugate"))
        }
        return .success(r)
    }

    
    
    public var description: String {
        var output: String = "\n[\n"
        for row in self.rowTuples {
            output += "    \(row.description)\n"
        }
        output += "]\n"
        return output
    }

}


/*
         a = m[0][0], b = m[0][1], c = m[0][2]
         d = m[1][0], e = m[1][1], f = m[1][2]
         g = m[2][0], h = m[2][1], i = m[2][2]

*/







/// Scalar Product of a tuple and a scalar
public func * (a: GenericMatrix, b: Double) throws -> GenericMatrix {
    var product: [[Double]] = []
    for r in a.values {
        var row: [Double] = []
        for c in r {
            row.append(c * b)
        }
        product.append(row)
    }
    return try Matrix(values: product)
}

/// Scalar Product of a tuple and a scalar
public func * (b: Double, a: GenericMatrix) throws -> GenericMatrix {
    var product: [[Double]] = []
    for r in a.values {
        var row: [Double] = []
        for c in r {
            row.append(c * b)
        }
        product.append(row)
    }
    return try Matrix(values: product)
}

public func * (a: GenericMatrix, b: GenericMatrix) throws -> GenericMatrix {
    if !a.isSquareMatrix { throw MatrixError.NotSquareMatrixError(message:"matrix a is not square") }
    if !b.isSquareMatrix { throw MatrixError.NotSquareMatrixError(message:"matrix b is not square") }
    if a.rows != b.rows { throw MatrixError.LengthMismatchError(message:"matrix a is not same size as b") }
    
    let count: Int = a.rows
    var product: [[Double]] = []
    for r in 0 ..< count {
        guard let row: RowTuple = a[r] else { throw MatrixError.RowBoundsError(message: "unknown error getting row tuple for \(r)")}
        var rowVal: [Double] = []
        for c in 0 ..< count {
            guard let col: ColumnTuple = b[c] else { throw MatrixError.ColumnBoundsError(message: "unknown error getting column tuple for \(c)")}
            let p: Double = try row * col
            rowVal.append(p)
        }
        product.append(rowVal)
    }
    
    return try Matrix(values: product)
}

/// Multiply the tuple a by the matrix b
///
/// The main condition of matrix multiplication is that the number of columns of the 1st matrix
/// must equal to the number of rows of the 2nd one.
/// As a result of multiplication you will get a new matrix that has the same quantity of rows as
/// the 1st one has and the same quantity of columns as the 2nd one.
/// For example if you multiply a matrix of 'n' x 'k' by 'k' x 'm' size you'll get a new one of 'n' x 'm' dimension.
///
public func * (a: N_Tuple, b: GenericMatrix) throws -> N_Tuple {
    if a.count != b.columns { throw MatrixError.LengthMismatchError(message: "tuple a: \(a.count) != matrix columns: \(b.columns)") }
    // the tuple count must be same as the matrix row count
    // the return tuple count has to be same as the matrix column count
    let columns: [RowTuple] = b.rowTuples
    let products: [Double] = try columns.map { return try a * $0 }
    return RowTuple(values: products)
}






