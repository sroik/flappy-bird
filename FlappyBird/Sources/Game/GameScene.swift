//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let pipeSpawner = PipeSpawner()
    let birds: [Bird]

    init(birds: [Bird] = [Bird()]) {
        self.birds = birds
        super.init(size: .zero)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(birds: [])
    }

    override func didMove(to view: SKView) {
        backgroundColor = .sky

        physicsWorld.gravity = .earthGravity
        physicsWorld.contactDelegate = self

        addChild(pipeSpawner)
        setupScoreLabel()
        setupGround()
        resetBirds()
        pause()
    }

    func restart() {
        resetBirds()
        updateScore()
        birds.forEach { $0.physicsBody?.isDynamic = true }
        pipeSpawner.start(in: frame)
        state = .running(score: 0)
    }

    func pause() {
        pipeSpawner.pause()
        birds.forEach { $0.physicsBody?.isDynamic = false }
    }

    func updateScore() {
        scoreLabel.text = String(format: "Score: %i", state.score)
    }

    private func setupScoreLabel() {
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.9)
        scoreLabel.zPosition = 10
        scoreLabel.fontSize = 30
        addChild(scoreLabel)
        updateScore()
    }

    private func setupGround() {
        floor.size = CGSize(width: frame.width, height: frame.height * 0.25)
        floor.position = floor.size.center
        addChild(floor)

        ceil.size = CGSize(width: frame.width, height: 1)
        ceil.position = CGPoint(x: frame.midX, y: frame.maxY)
        addChild(ceil)
    }

    private func resetBirds() {
        birds.forEach { bird in
            if bird.parent == nil {
                addChild(bird)
            }

            bird.position = CGPoint(
                x: frame.width * CGFloat.random(in: 0.4 ... 0.5),
                y: frame.height * CGFloat.random(in: 0.4 ... 0.7)
            )
        }
    }

    func bird(with body1: SKPhysicsBody, or body2: SKPhysicsBody) -> Bird? {
        return birds.first {
            $0.physicsBody == body1 || $0.physicsBody == body2
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if state == .stopped {
            restart()
        }

        birds.forEach {
            $0.perform(action: .jump)
        }
    }

    private var allBirdsDead: Bool {
        return birds.allSatisfy { $0.isDead }
    }

    private(set) var state: GameState = .stopped
    private let floor = Ground()
    private let ceil = Ground()
    private let scoreLabel = SKLabelNode(fontNamed: "AmericanTypewriter-Bold")
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
            guard let bird = self.bird(with: contact.bodyA, or: contact.bodyB) else {
                return
            }

            bird.physicsBody?.isDynamic = false
            bird.removeFromParent()

            if allBirdsDead {
                state = .stopped
                pause()
            }
        }
    }
}
