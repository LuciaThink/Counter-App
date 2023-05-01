//
//  countData.swift
//  Counter App
//
//  Created by Lucia Pettway on 5/1/23.
//

import Foundation

struct CountData: Identifiable {
    var id: String = UUID().uuidString
    var count: Int
}
