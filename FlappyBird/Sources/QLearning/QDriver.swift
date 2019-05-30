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
        self.agent = QAgent(q: QTable(), learningRate: 0.25, discount: 0.9)
        super.init()
        restoreQTable()
    }

    func run() {
        isRunning = true
        gameScene.delegate = self
    }

    private func runNextEpisode() {
        print("EPISODE ", episode)

        gameScene.restart()
        episode += 1

        if episode % episodesPerBackup == 0 {
            backupQTable()
        }
    }

    private func learn() {
        gameScene.birds.forEach { bird in
            learn(bird: bird)
        }
    }

    private func learn(bird: Bird) {
        guard !bird.isDead, let state = env.state(of: bird) else {
            return
        }

        let action = agent.action(for: state)

        perform(action: action, bird: bird) { [unowned bird, unowned self] in
            guard let futureState = self.env.state(of: bird) else {
                return
            }

            self.agent.learn(
                state: state,
                action: action,
                futureState: futureState,
                reward: bird.isDead ? .dead : .alive
            )
        }
    }

    func perform(action: BirdAction, bird: Bird, then completion: @escaping PerformCallback) {
        bird.perform(action: action)
        completions.append(completion)
    }

    private var completions: [PerformCallback] = []
    private let episodesPerBackup: Int = 100
    private var episode: Int = 0
    private var isRunning: Bool = false
    private let gameScene: GameScene
}

extension QDriver: SKSceneDelegate {
    typealias PerformCallback = () -> Void

    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        guard isRunning else {
            return
        }

        completions.forEach { $0() }
        completions = []

        switch gameScene.state {
        case .running:
            learn()
        case .stopped:
            runNextEpisode()
        }
    }
}
