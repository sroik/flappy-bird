//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

final class QAgent {
    let learningRate: Double
    let discount: Double
    var q: QTable

    init(q: QTable, learningRate: Double, discount: Double) {
        self.learningRate = learningRate
        self.discount = discount
        self.q = q
    }
}
