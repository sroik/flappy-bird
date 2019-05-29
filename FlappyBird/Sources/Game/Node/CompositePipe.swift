//
//  Copyright © 2019 sroik. All rights reserved.
//

import SpriteKit

final class CompositePipe: SKNode {
    let gap: CGFloat
    let size: CGSize

    init(gap: CGFloat, size: CGSize) {
        self.size = size
        self.gap = gap
        super.init()
        setup()
    }

    required convenience init?(coder aDecoder: NSCoder) {
        self.init(gap: 0, size: .zero)
    }

    private func setup() {
        let lowwerHeight = CGFloat.random(in: size.height * 0.3 ... size.height * 0.65)
        let upperHeight = size.height - gap - lowwerHeight

        let upper = Pipe(size: CGSize(width: size.width, height: upperHeight))
        let lowwer = Pipe(size: CGSize(width: size.width, height: lowwerHeight))

        addChild(upper)
        upper.position = CGPoint(x: size.width / 2, y: size.height - upperHeight / 2)

        addChild(lowwer)
        lowwer.position = CGPoint(x: size.width / 2, y: lowwerHeight / 2)

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
