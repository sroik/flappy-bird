//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

final class QAgent {
    let learningRate: Double
    let discount: Double
    var explorationRate: Double
    var q: QTable

    init(q: QTable, learningRate: Double, discount: Double, explorationRate: Double = 0) {
        self.learningRate = learningRate
        self.discount = discount
        self.explorationRate = explorationRate
        self.q = q
    }

    func action(for state: QState) -> BirdAction {
        if explorationRate > 0, Double.random(in: 0 ... 1) < explorationRate {
            return BirdAction.allCases.randomElement() ?? .none
        }

        let actions = q[state: state]
        let optimal = actions.max()
        let index = actions.firstIndex { $0 == optimal } ?? 0

        guard let action = BirdAction(rawValue: index) else {
            assertionFailure("invalid action")
            return .none
        }

        return action
    }

    /* Bellman equation */
    func learn(state: QState, futureState: QState, reward: BirdReward) {
        let action = self.action(for: state)
        let futureAction = self.action(for: futureState)
        let past = (1 - learningRate) * Double(q[state: state, a: action.rawValue])
        let learnt = learningRate * (reward.doubleValue + discount * futureAction.doubleValue)
        q[state: state, a: action.rawValue] = Int(past) + Int(learnt)
    }
}
