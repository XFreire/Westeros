//
//  House.swift
//  Westeros
//
//  Created by Alexandre Freire on 25/12/2017.
//  Copyright © 2017 Westeros. All rights reserved.
//

import UIKit

typealias Words = String
typealias Members = Set<Person>

// MARK: - House
final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members = Members()

    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiURL = url
        _members = Members()
    }
}

extension House {
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
   
    func add(person: Person) {
        guard person.house.name == self.name else { return }
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        for person in persons {
            add(person: person)
        }
    }
}

// MARK: - Sigil
final class Sigil {
    let description: String
    private let imageName: String
    var image: UIImage? {
        get {
            return UIImage(named: imageName, in: Bundle(for: type(of: self)), compatibleWith: nil)
        }
    }
        
    init(imageName: String, description: String) {
        self.imageName = imageName
        self.description = description
    }
}

// Mark: - Proxy
extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

// Mark: - Equatable
extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}
// MARK: - Hashable
extension House: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(proxyForEquality)
    }
}

//MARK: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
    
}
