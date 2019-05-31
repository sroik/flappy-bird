//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

struct BirdState: Codable, Hashable {
    var yDistance: Double
    var xDistance: Double
    var gap: Double
}

extension BirdState {
    static var size: Int {
        return 3
    }

    var row: [Double] {
        return [
            yDistance,
            xDistance,
            gap
        ]
    }
}
