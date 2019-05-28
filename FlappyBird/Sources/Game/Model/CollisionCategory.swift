//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

struct CollisionCategory: OptionSet {
    var rawValue: UInt32
    
    static let bird = CollisionCategory(rawValue: 1 << 0)
    static let ground = CollisionCategory(rawValue: 1 << 1)
    static let pipe =  CollisionCategory(rawValue: 1 << 2)
    static let score =  CollisionCategory(rawValue: 1 << 3)
    
    static let birdCollision: CollisionCategory = [.ground, .pipe]
    static let birdContact: CollisionCategory = [.ground, .pipe, .score]
}
