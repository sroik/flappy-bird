//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class QEnv: NSObject {
    init(gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }

    func state(of bird: Bird) -> QState {
        guard let closest = gameScene.pipe(nextTo: bird) else {
            return .maxState
        }

        return QState(
            velocity: Double(bird.velocity),
            yDistance: Double(bird.frame.minY - closest.lowwer.frame.maxY),
            xDistance: Double(closest.frame.minX - bird.frame.maxX),
            stride: QState.maxState.stride
        )
    }

    private let gameScene: GameScene
}

private extension GameScene {
    func pipe(nextTo bird: Bird) -> CompositePipe? {
        let pipes = pipeSpawner.children
            .compactMap { $0 as? CompositePipe }
            .filter { $0.frame.minX > bird.frame.maxX }

        let closest = pipes.min {
            $0.lowwer.frame.minX < $1.lowwer.frame.minX
        }

        return closest
    }
}
