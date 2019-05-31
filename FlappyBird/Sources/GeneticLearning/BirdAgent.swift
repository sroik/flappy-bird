//
//  Copyright © 2019 sroik. All rights reserved.
//

import SmartMachine
import Surge

final class BirdAgent {
    var bird: Bird
    var genes: NeuralNetwork
    var mutationRate: Double = 0.1
    var mutationRange: Double = 0.25

    var isAlive: Bool {
        return bird.parent != nil
    }

    init(bird: Bird) {
        self.bird = bird
        self.genes = NeuralNetwork()
        self.genes.add(layer: .input(size: BirdState.size))
        self.genes.add(layer: .fullyConnected(size: 12, activation: .relu))
        self.genes.add(layer: .fullyConnected(size: BirdAction.count, activation: .relu))
        self.genes.compile(biasInitializer: .random)
    }

    init(bird: Bird, genes: NeuralNetwork) {
        self.bird = bird
        self.genes = genes
    }

    func action(for state: BirdState) -> BirdAction {
        let input = Matrix(row: state.row)
        let output = genes.predict(input)[row: 0]
        let optimal = output.max()
        let optimalIndex = output.firstIndex { $0 == optimal } ?? 0

        guard let action = BirdAction(rawValue: optimalIndex) else {
            assertionFailure("index out of range")
            return .none
        }

        return action
    }

    func evolve(to genes: NeuralNetwork) {
        self.genes = NeuralNetwork(layers: genes.layers)
    }

    func mutate() {
        genes.layers.indices.forEach { index in
            mutate(layer: &genes.layers[index])
        }
    }

    private func mutate(layer: inout Layer) {
        mutateBiases(of: &layer)
        mutateWeights(of: &layer)
    }

    private func mutateBiases(of layer: inout Layer) {
        for index in 0 ..< layer.biases.count {
            layer.biases[index] = mutated(gen: layer.biases[index])
        }
    }

    private func mutateWeights(of layer: inout Layer) {
        for r in 0 ..< layer.weights.rows {
            for c in 0 ..< layer.weights.columns {
                layer.weights[r, c] = mutated(gen: layer.weights[r, c])
            }
        }
    }

    private func mutated(gen: Double) -> Double {
        guard Double.random(in: 0 ... 1) < mutationRate else {
            return gen
        }

        return gen + Double.random(in: 0 ... 2) * mutationRange - mutationRange
    }
}
