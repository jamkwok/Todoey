
//
//  Message.swift
//  Flash Chat
//
//  This is the model class that represents the blueprint for an item

class Item: Codable {
    var title: String
    var done: Bool = false
    
    init(titleText: String) {
        title = titleText
    }
}

