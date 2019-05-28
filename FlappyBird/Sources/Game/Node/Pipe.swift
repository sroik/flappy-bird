//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class Pipe: SKShapeNode {
    
    let size: CGSize
    
    init(size: CGSize) {
        self.size = size
        super.init()
        setup()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(size: .zero)
    }
    
    private func setup() {
        path = CGPath(rect: CGRect(center: .zero, size: size), transform: nil)
        fillColor = .grass
        strokeColor = .clear
        blendMode = .replace
        setupPhysics()
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = CollisionCategory.pipe.rawValue
    }
}
