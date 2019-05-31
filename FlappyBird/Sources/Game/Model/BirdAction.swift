//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

enum BirdAction: Int, Hashable, Codable, CaseIterable {
    case none
    case jump
}

extension BirdAction {
    static var count: Int {
        return BirdAction.allCases.count
    }

    var doubleValue: Double {
        return Double(rawValue)
    }
}
