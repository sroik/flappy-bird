//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

enum BirdAction: Int, Hashable, Codable, CaseIterable {
    case none
    case jump
}

enum BirdReward: Int {
    case alive = 1
    case dead = -1000
}

extension BirdReward {
    var doubleValue: Double {
        return Double(rawValue)
    }
}

extension BirdAction {
    static var count: Int {
        return BirdAction.allCases.count
    }

    var doubleValue: Double {
        return Double(rawValue)
    }
}
