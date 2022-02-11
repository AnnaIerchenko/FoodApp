//
//  Cart.swift
//  FoodApp
//
//  Created by Ierchenko Anna  on 2/9/22.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}
