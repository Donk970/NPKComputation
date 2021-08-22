//
//  File.swift
//
//
//  Created by DoodleBytes on 8/22/21.
//

import Foundation

extension NutrientComponentSystem {
    
    // General Hydroponics Flora NPK constants
    public static let foxFarm: NutrientComponentSystem = NutrientComponentSystem(
        a: NPKRatio(n: 6.0, p: 4.0, k: 4.0, label: "Fox Farm Grow Big"),
        b: NPKRatio(n: 0.01, p: 0.3, k: 0.7, label: "Fox Farm Big Bloom"),
        c: NPKRatio(n: 2.0, p: 8.0, k: 4.0, label: "Fox Farm Tiger Bloom"),
        label: "Fox Farm",
        description: """
The Fox Farm Series is a three part nutrient system consisting of
Micro, Grow and Bloom.  Micro is mostly Nitrogen with some potassium but also carries the
micro nutrients.
"""
    )
    
}
