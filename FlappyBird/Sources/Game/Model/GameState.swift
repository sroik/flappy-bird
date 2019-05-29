//
//  Copyright © 2019 sroik. All rights reserved.
//

import UIKit

enum GameState: Hashable {
    case running(score: Int)
    case stopped
}

extension GameState {
    var isRunning: Bool {
        switch self {
        case .running: return true
        case .stopped: return false
        }
    }

    var score: Int {
        switch self {
        case let .running(score): return score
        case .stopped: return 0
        }
    }
}
