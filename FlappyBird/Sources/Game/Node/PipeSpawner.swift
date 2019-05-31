//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class PipeSpawner: SKNode {
    let gap: CGFloat
    let velocity: CGFloat
    let idle: TimeInterval
    let width: CGFloat

    init(
        idle: TimeInterval = 2,
        velocity: CGFloat = 125,
        width: CGFloat = 100,
        gap: CGFloat = 150
    ) {
        self.width = width
        self.velocity = velocity
        self.idle = idle
        self.gap = gap
        super.init()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }

    func stop() {
        removeAllActions()
        removeAllChildren()
    }

    func pause() {
        speed = 0
    }

    func unpause() {
        speed = 1
    }

    func start(in space: CGRect) {
        self.space = space
        stop()
        unpause()
        updateMoveAction()

        let spawn = SKAction.run(spawnPipe)
        let wait = SKAction.wait(forDuration: idle)
        let spawnThenWait = SKAction.sequence([spawn, wait])
        let spawnThenWaitForever = SKAction.repeatForever(spawnThenWait)
        run(spawnThenWaitForever)
    }

    func spawnPipe() {
        let pipe = CompositePipe(gap: gap, size: pipeSize)
        pipe.position = spawnPoint
        pipe.zPosition = -1
        pipe.run(moveAction)
        addChild(pipe)
    }

    private func updateMoveAction() {
        let distance = CGFloat(space.width + width * 2)
        let duration = TimeInterval(distance / velocity)
        let move = SKAction.moveBy(x: -distance, y: 0, duration: duration)
        let remove = SKAction.removeFromParent()
        moveAction = SKAction.sequence([move, remove])
    }

    private var spawnPoint: CGPoint {
        return CGPoint(x: space.width, y: 0)
    }

    private var pipeSize: CGSize {
        return CGSize(width: width, height: space.height)
    }

    private var moveAction: SKAction = SKAction()
    private var space: CGRect = .zero
}
