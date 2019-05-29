//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class QDriver: NSObject {
    let agent: QAgent
    let env: QEnv

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        self.env = QEnv(gameScene: gameScene)
        self.agent = QAgent(q: QTable(), learningRate: 0.1, discount: 0.99)
        super.init()
        restoreQTable()
    }

    func run() {
        isRunning = true
        gameScene.delegate = self
    }
    
    private func runNextEpisode() {
        gameScene.restart()
        episode += 1
        
        if episode % episodesPerBackup == 0 {
            backupQTable()
        }
    }

    private let episodesPerBackup: Int = 1000
    private var episode: Int = 0
    private var isRunning: Bool = false
    private let gameScene: GameScene
}

extension QDriver: SKSceneDelegate {
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        guard isRunning else {
            return
        }

        switch gameScene.state {
        case .running:
            env.perform(action: .none)
            

        case .stopped:
            runNextEpisode()
        }
    }
}
