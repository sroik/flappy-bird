//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class Ground: SKShapeNode {
    var size: CGSize = .zero {
        didSet {
            updatePhysics()
        }
    }

    override init() {
        super.init()
        setup()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }

    private func setup() {
        fillColor = .ground
        strokeColor = .clear
        blendMode = .replace
    }

    private func updatePhysics() {
        path = CGPath(rect: CGRect(center: .zero, size: size), transform: nil)
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = CollisionCategory.ground.rawValue
    }
}
