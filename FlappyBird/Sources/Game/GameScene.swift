//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = .sky
        physicsWorld.gravity = .earthGravity
        physicsWorld.contactDelegate = self
        
        addChild(bird)
        addChild(pipeSpawner)
        addChild(floor)
        
        setupScoreLabel()
        resetBird()
        resetFloor()
        pause()
    }
    
    func restart() {
        resetBird()
        updateScore()
        bird.physicsBody?.isDynamic = true
        pipeSpawner.start(in: frame)
    }
    
    func pause() {
        pipeSpawner.pause()
        bird.physicsBody?.isDynamic = false
    }
    
    func updateScore() {
        scoreLabel.text = String(format: "Score: %i", state.score)
    }
    
    private func setupScoreLabel() {
        scoreLabel.position = CGPoint( x: frame.midX, y: frame.height * 0.85)
        scoreLabel.zPosition = 10
        scoreLabel.fontSize = 40
        addChild(scoreLabel)
        updateScore()
    }
    
    private func resetFloor() {
        floor.size =  CGSize(width: frame.width, height: frame.height * 0.25)
        floor.position = floor.size.center
    }
    
    private func resetBird() {
        bird.position = CGPoint(x: frame.width * 0.25, y: frame.height * 0.5)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        switch state {
        case .stopped:
            restart()
            state = .running(score: 0)
            bird.perform(action: .jump)
        case .running:
            bird.perform(action: .jump)
        }
    }

    private var state: GameState = .stopped
    private var pipeSpawner = PipeSpawner()
    private let floor = Floor()
    private let bird = Bird()
    private let scoreLabel = SKLabelNode(fontNamed: "SanFranciscoText-Semibold")
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard state.isRunning else {
            return
        }
        
        switch (contact.bodyA.categoryBitMask, contact.bodyB.categoryBitMask) {
        case (CollisionCategory.score.rawValue, _), (_, CollisionCategory.score.rawValue):
            state = .running(score: state.score + 1)
            updateScore()
        case (_, _):
            state = .stopped
            pause()
        }
    }
}
