//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .sky
        physicsWorld.gravity = .marsGravity
        physicsWorld.contactDelegate = self
        
        setupBird()
        setupFloor()
    }
    
    private func setupFloor() {
        addChild(floor)

        let floorSize = CGSize(width: frame.width, height: floorHeight)
        floor.path = CGPath(rect: CGRect(center: .zero, size: floorSize), transform: nil)
        floor.position = floorSize.center
        floor.fillColor = .black
        floor.strokeColor = .clear
        floor.physicsBody = SKPhysicsBody(rectangleOf: floorSize)
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.categoryBitMask = CollisionCategory.ground.rawValue
    }
    
    private func setupBird() {
        addChild(bird)
        bird.position = frame.center
        bird.physicsBody?.categoryBitMask = CollisionCategory.bird.rawValue
        bird.physicsBody?.collisionBitMask = CollisionCategory.groundPipe.rawValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        bird.jump()
    }

    private let floorHeight: CGFloat = Device.size.height / 4
    private let floor = SKShapeNode()
    private let bird = Bird()
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact)
    }
}
