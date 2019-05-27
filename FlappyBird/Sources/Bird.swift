//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class Bird: SKShapeNode {
    
    static let preferredSize = CGSize(width: 20, height: 20)
    
    init(size: CGSize = Bird.preferredSize) {
        self.size = size
        super.init()
        setup()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func jump() {
        physicsBody?.velocity = .zero
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5))
    }
    
    private func setup() {
        path = CGPath(rect: CGRect(center: .zero, size: size), transform: nil)
        fillColor = .black
        strokeColor = .black
        
        setupPhysics()
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = true
    }

    private let size: CGSize
}
