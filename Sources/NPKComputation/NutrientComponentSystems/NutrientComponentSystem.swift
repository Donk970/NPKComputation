import Foundation


public struct NutrientComponentRatio: N_Tuple {
    public let axis: Axis = .column
    public let system: NutrientComponentSystem
    
    public let values: [Double]
    var a: Double { return self[0] }
    var b: Double { return self[1] }
    var c: Double { return self[2] }
}

/**
 A struct describing the NPKRatio's of a three part nutrient system
 */
public struct NutrientComponentSystem {
    public let a: NPKRatio
    public let b: NPKRatio
    public let c: NPKRatio
    public let label: String
    public let description: String
    
    public init( a: NPKRatio, b: NPKRatio, c: NPKRatio, label: String, description: String ) {
        self.a = a
        self.b = b
        self.c = c
        self.label = label
        self.description = description
    }
    
    public var constants: GenericMatrix {
        return Matrix(columns: [self.a.column, self.b.column, self.c.column])
    }

    public func componentRatio( for target: NPKRatio ) -> NutrientComponentRatio? {
        let constants: GenericMatrix = self.constants
        guard let inverted: GenericMatrix = try? constants.inverse.get(),
              let solution: N_Tuple = try? target.column * inverted else {
            return nil
        }
        
        // convert from raw tuple to the NutrientComponentRatio tuple
        return NutrientComponentRatio(system: self, values: solution.values)
    }
}


