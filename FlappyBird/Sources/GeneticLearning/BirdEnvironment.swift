//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class BirdEnvironment: NSObject {
    init(gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }

    func state(of bird: Bird) -> BirdState? {
        guard let closest = gameScene.pipe(nextTo: bird) else {
            return nil
        }

        return BirdState(
            yDistance: Double(bird.frame.minY - closest.lowwer.frame.maxY),
            xDistance: Double(closest.maxX - bird.frame.minX),
            gap: Double(gameScene.pipeSpawner.gap)
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

private extension Bird {
    var velocity: Double {
        return Double(physicsBody?.velocity.dy ?? 0)
    }
}

private extension CompositePipe {
    var maxX: CGFloat {
        return frame.minX + size.width
    }
}
