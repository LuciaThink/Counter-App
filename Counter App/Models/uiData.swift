//
//  uiData.swift
//  Counter App
//
//  Created by Lucia Pettway on 5/1/23.
//

import Foundation

struct UIData: Identifiable {
    var id: String = UUID().uuidString
    var description: String
    var key: String
}
