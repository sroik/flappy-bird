//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

extension Comparable {
    func clamped(from: Self, to: Self) -> Self {
        assert(from <= to, "invalid clamp range")
        return min(max(self, from), to)
    }
}
