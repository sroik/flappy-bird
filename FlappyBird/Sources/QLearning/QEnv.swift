//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class QEnv: NSObject {
    var state: QState = QState.maxState

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        super.init()
    }

    @discardableResult
    func perform(action: BirdAction) -> BirdReward {
        bird.perform(action: action)
        updateState()

        switch gameScene.state {
        case .stopped: return .dead
        case .running: return .alive
        }
    }

    private func updateState() {
        guard let closest = gameScene.nextPipe() else {
            return
        }

        state = QState(
            velocity: Double(gameScene.bird.velocity),
            yDistance: Double(bird.frame.minY - closest.lowwer.frame.maxY),
            xDistance: Double(closest.frame.minX - bird.frame.maxX),
            stride: QState.maxState.stride
        )
    }

    private var bird: Bird {
        return gameScene.bird
    }

    private let gameScene: GameScene
}

private extension GameScene {
    func nextPipe() -> CompositePipe? {
        let pipes = pipeSpawner.children
            .compactMap { $0 as? CompositePipe }
            .filter { $0.frame.minX > bird.frame.maxX }

        let closest = pipes.min {
            $0.lowwer.frame.minX < $1.lowwer.frame.minX
        }

        return closest
    }
}
