//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class GeneticEvolver: NSObject {
    let env: BirdEnvironment
    let agents: [BirdAgent]

    init(gameScene: GameScene) {
        self.gameScene = gameScene
        self.agents = gameScene.birds.map(BirdAgent.init(bird:))
        self.env = BirdEnvironment(gameScene: gameScene)
        super.init()
    }

    func run() {
        isRunning = true
        gameScene.delegate = self
        gameScene.observer = self
        runNextEpisode()
    }

    private func runNextEpisode() {
        print("Episode ", episode)

        leaderboard = []
        gameScene.restart()
        episode += 1
    }

    private func performActions() {
        agents.filter { $0.isAlive }.forEach { agent in
            guard let state = env.state(of: agent.bird) else {
                return
            }

            let action = agent.action(for: state)
            agent.bird.perform(action: action)
        }
    }

    private func evolve() {
        agents.forEach { agent in
            if survivedBirds.contains(agent.bird.identifier) {
                return
            }

            if let survived = self.agent(withId: survivedBirds.randomElement()) {
                agent.evolve(to: survived.genes)
                agent.mutate()
            }
        }
    }

    private func agent(withId id: BirdIdentifier?) -> BirdAgent? {
        return id.flatMap { agentsMap[$0] }
    }

    private var survivedBirds: [String] {
        return leaderboard.suffix(evolutionSize)
    }

    private lazy var agentsMap: [BirdIdentifier: BirdAgent] = {
        Dictionary(uniqueKeysWithValues: agents.map { agent in
            (agent.bird.identifier, agent)
        })
    }()

    private var leaderboard: [BirdIdentifier] = []
    private let evolutionSize: Int = 2
    private var episode: Int = 0
    private var isRunning: Bool = false
    private let gameScene: GameScene
}

extension GeneticEvolver: SKSceneDelegate, GameSceneObserver {
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        guard isRunning else {
            return
        }

        switch gameScene.state {
        case .running:
            performActions()
        case .stopped:
            evolve()
            runNextEpisode()
        }
    }

    func gameScene(_ scene: GameScene, birdDidDie bird: Bird) {
        leaderboard.append(bird.identifier)
    }
}
