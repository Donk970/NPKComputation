

public struct Matrix: GenericMatrix, Codable {
    public var values: [[Double]]
    
    public init( values: [[Double]]) throws {
        self.values = values
        if !self.isValidMatrix { throw MatrixError.InvalidMatrixError(message: "Tried to initialize with an invalid matrix") }
    }
    
    public init( rows: [N_Tuple]) throws {
        self.values = rows.map { $0.values }
        if !self.isValidMatrix { throw MatrixError.InvalidMatrixError(message: "Tried to initialize with an invalid matrix") }
    }
    
    public init( columns: [N_Tuple]) throws {
        let count: Int = columns[0].count
        var values: [[Double]] = Array<[Double]>(repeating: [], count: count)
        for column in columns {
            for i in 0 ..< column.count {
                values[i].append(column[i])
            }
        }
        self.values = values
        if !self.isValidMatrix { throw MatrixError.InvalidMatrixError(message: "Tried to initialize with an invalid matrix") }
    }
}



