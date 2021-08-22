//
//  File.swift
//  
//
//  Created by DoodleBytes on 8/22/21.
//

import Foundation

extension NutrientComponentSystem {
    
    // General Hydroponics Flora NPK constants
    public static let generalHydroponicsFlora: NutrientComponentSystem = NutrientComponentSystem(
        a: NPKRatio(n: 5.0, p: 0.0, k: 1.0, micro: true, label: "General Hydroponics Flora Micro"),
        b: NPKRatio(n: 2.0, p: 1.0, k: 6.0, label: "General Hydroponics Flora Grow"),
        c: NPKRatio(n: 0.0, p: 5.0, k: 4.0, label: "General Hydroponics Flora Bloom"),
        label: "General Hydroponics Flora Series",
        description: """
The General Hydroponics Flora Series is a three part nutrient system consisting of
Micro, Grow and Bloom.  Micro is mostly Nitrogen with some potassium but also carries the
micro nutrients.
"""
    )
    
}
