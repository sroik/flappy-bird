//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

struct QState {
    var velocity: Double
    var yDistance: Double
    var xDistance: Double
    var stride: Double
}

extension QState {
    static let maxState = QState(
        velocity: 100,
        yDistance: 1024,
        xDistance: 1024,
        stride: 1024
    )

    var yIndex: Int {
        let clamped = yDistance.clamped(from: 0, to: QState.maxState.yDistance)
        return Int(ceil(clamped / stride))
    }

    var xIndex: Int {
        let clamped = xDistance.clamped(from: 0, to: QState.maxState.xDistance)
        return Int(ceil(clamped / stride))
    }

    var vIndex: Int {
        let clamped = velocity.clamped(from: 0, to: QState.maxState.velocity)
        return Int(ceil(clamped / stride))
    }
}
