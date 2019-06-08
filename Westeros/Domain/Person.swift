//
//  Character.swift
//  Westeros
//
//  Created by Alexandre Freire on 25/12/2017.
//  Copyright © 2017 Westeros. All rights reserved.
//

import Foundation

let PersonKey = "PersonKey"
let PersonDidCreateNotificationName = "PersonDidCreateNotificationName"

final class Person {
    let name: String
    let house: House
    private let _alias: String?
    
    var alias: String {
        return _alias ?? ""
    }
    
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        _alias = alias
        self.house = house
        
        sendPersonDidCreateNotification()
    }
    
    func sendPersonDidCreateNotification() {
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name(PersonDidCreateNotificationName), object: self, userInfo: [PersonKey: self])
        notificationCenter.post(notification)
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison: String {
        return "\(fullName)"
    }
    
}

extension Person: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(proxyForEquality)
    }
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Comparable {
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
    
}
