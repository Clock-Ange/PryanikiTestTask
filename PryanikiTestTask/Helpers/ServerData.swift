//
//  ServerData.swift
//  PryanikiTestTask
//
//  Created by Геннадий Махмудов on 02.02.2021.
//

import Foundation


struct ServerData: Codable {
    let data: Array<ViewData>
    let view: Array<String>
}
struct ViewData: Codable {
    let name: String
    let data: ComponentData
}
struct ComponentData: Codable {
    let url: String?
    let text: String?
    let selectedId: Int?
    let variants: Array<Variant>?
}
struct Variant: Codable {
    let id: Int
    let text: String
}
