//
//  File.swift
//
//
//  Created by DoodleBytes on 8/22/21.
//

import Foundation

extension NutrientComponentSystem {
    
    // General Hydroponics Flora NPK constants
    public static let EarthJuice: NutrientComponentSystem = NutrientComponentSystem(
        a: NPKRatio(n: 2.0, p: 1.0, k: 0.0, label: "Earth Juice Grow"),
        b: NPKRatio(n: 0.0, p: 3.0, k: 2.0, label: "Earth Juice Bloom"),
        c: NPKRatio(n: 0.03, p: 0.01, k: 0.1, micro: true, label: "Earth Juice XATALYST"),
        label: "Earth Juice",
        description: """
The Earth Juice Series is a three part nutrient system consisting of ...
"""
    )
    
}
