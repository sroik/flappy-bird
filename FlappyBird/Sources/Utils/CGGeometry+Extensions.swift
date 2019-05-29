//
//  Copyright © 2019 sroik. All rights reserved.
//

import UIKit

extension CGFloat {
    static let earthGravity: CGFloat = 9.807
    static let moonGravity: CGFloat = 1.62
    static let marsGravity: CGFloat = 3.711
    static let flappyGravity: CGFloat = 5.0
}

extension CGVector {
    static let earthGravity = CGVector(dx: 0.0, dy: -.earthGravity)
    static let moonGravity = CGVector(dx: 0.0, dy: -.moonGravity)
    static let marsGravity = CGVector(dx: 0.0, dy: -.marsGravity)
    static let flappyGravity = CGVector(dx: 0.0, dy: -.flappyGravity)
}

extension CGSize {
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }

    init(center: CGPoint, radius: CGFloat) {
        self.init(
            center: center,
            size: CGSize(width: 2 * radius, height: 2 * radius)
        )
    }

    init(center: CGPoint, size: CGSize) {
        self.init(
            x: center.x - size.width / 2,
            y: center.y - size.height / 2,
            width: size.width,
            height: size.height
        )
    }
}
