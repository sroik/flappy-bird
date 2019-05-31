//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class CompositePipe: SKNode {
    let size: CGSize
    let upper: Pipe
    let lowwer: Pipe

    init(gap: CGFloat, size: CGSize) {
        self.size = size

        let lowwerHeight = CGFloat.random(in: size.height * 0.3 ... size.height * 0.75)
        let upperHeight = size.height - gap - lowwerHeight

        upper = Pipe(size: CGSize(width: size.width, height: upperHeight))
        lowwer = Pipe(size: CGSize(width: size.width, height: lowwerHeight))
        super.init()
        setup()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(gap: 0, size: .zero)
    }

    private func setup() {
        addChild(upper)
        upper.position = CGPoint(x: size.width / 2, y: size.height - upper.size.height / 2)

        addChild(lowwer)
        lowwer.position = CGPoint(x: size.width / 2, y: lowwer.size.height / 2)

        setupScore()
    }

    private func setupScore() {
        let score = SKNode()
        score.position = CGPoint(x: size.width + Bird.preferredSize.width, y: size.height / 2)
        score.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: size.height))
        score.physicsBody?.isDynamic = false
        score.physicsBody?.categoryBitMask = CollisionCategory.score.rawValue
        addChild(score)
    }
}
