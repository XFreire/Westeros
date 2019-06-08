//
//  Season.swift
//  Westeros
//
//  Created by Alexandre Freire on 01/02/2018.
//  Copyright © 2018 Westeros. All rights reserved.
//

import Foundation
typealias Episodes = Set<Episode>
final class Season {
    
    // Mark: - Properties
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    // Mark: - Initialization
    init(name: String, releaseDate: Date, episodes: Episodes = Episodes()) {
        self.name = name
        self.releaseDate = releaseDate
        _episodes = episodes
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }
    
    func add(episode: Episode) {
        guard episode.season == self else { return }
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach { add(episode: $0) }
    }
}

// Mark: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: releaseDate)
        return "\(name), release date: \(date). Number of episodes: \(count)"
    }
}

// Mark: - Proxy
extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate) \(count)"
    }
    
    var proxyForComparison: Date {
        return releaseDate
    }
}

// Mark: - Equatable
extension Season: Equatable {
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}
// MARK: - Hashable
extension Season: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(proxyForEquality)
    }
}

//MARK: - Comparable
extension Season: Comparable {
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
