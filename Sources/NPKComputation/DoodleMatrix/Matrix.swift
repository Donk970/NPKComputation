

public struct Matrix: GenericMatrix, Codable {
    public var values: [[Double]]
    
    public init( values: [[Double]]) {
        self.values = values
    }
    
    public init( rows: [N_Tuple]) {
        self.values = rows.map { $0.values }
    }
    
    public init( columns: [N_Tuple]) {
        let count: Int = columns[0].count
        var values: [[Double]] = Array<[Double]>(repeating: [], count: count)
        for column in columns {
            for i in 0 ..< column.count {
                values[i].append(column[i])
            }
        }
        self.values = values
    }
}



