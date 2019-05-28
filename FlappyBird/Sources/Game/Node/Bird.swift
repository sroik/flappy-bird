//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class Bird: SKShapeNode {
    
    static let preferredSize = CGSize(width: 30, height: 30)
    
    init(size: CGSize = Bird.preferredSize) {
        self.size = size
        super.init()
        setup()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    func perform(action: BirdAction) {
        switch action {
        case .jump: jump()
        default: break
        }
    }
    
    private func jump() {
        physicsBody?.velocity = .zero
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
    }
    
    private func setup() {
        path = CGPath(rect: CGRect(center: .zero, size: size), transform: nil)
        blendMode = .replace
        fillColor = .sun
        strokeColor = .clear
        setupPhysics()
    }
    
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.mass = 0.1
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.categoryBitMask = CollisionCategory.bird.rawValue
        physicsBody?.collisionBitMask = CollisionCategory.birdCollision.rawValue
        physicsBody?.contactTestBitMask = CollisionCategory.birdContact.rawValue
    }

    private let size: CGSize
}
