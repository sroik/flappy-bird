//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .sky
        physicsWorld.gravity = .earthGravity
        physicsWorld.contactDelegate = self
        
        setupBird()
        setupFloor()
        setupPipeSpawner()
    }
    
    private func setupFloor() {
        addChild(floor)
        floor.size =  CGSize(width: frame.width, height: frame.height / 4)
        floor.position = floor.size.center
    }
    
    private func setupBird() {
        addChild(bird)
        bird.position = CGPoint(x: frame.width * 0.25, y: frame.height * 0.5)
    }

    private func setupPipeSpawner() {
        addChild(pipeSpawner)
        pipeSpawner.start(in: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        bird.perform(action: .jump)
    }

    private var pipeSpawner = PipeSpawner()
    private let floor = Floor()
    private let bird = Bird()
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact)
    }
}
