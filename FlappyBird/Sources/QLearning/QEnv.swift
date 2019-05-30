//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class QEnv: NSObject {
    init(gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }

    func state(of bird: Bird) -> QState? {
        guard let closest = gameScene.pipe(nextTo: bird) else {
            return nil
        }

        return QState(
            yDistance: Double(bird.frame.minY - closest.lowwer.frame.maxY),
            xDistance: Double(closest.maxX - bird.frame.minX),
            stride: QState.maxState.stride
        )
    }

    private let gameScene: GameScene
}

private extension GameScene {
    func pipe(nextTo bird: Bird) -> CompositePipe? {
        let pipes = pipeSpawner.children
            .compactMap { $0 as? CompositePipe }
            .filter { $0.maxX > bird.frame.minX }

        let closest = pipes.min {
            $0.maxX < $1.maxX
        }

        return closest
    }
}

private extension CompositePipe {
    var maxX: CGFloat {
        return frame.minX + size.width
    }
}
