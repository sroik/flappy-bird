//
//  Copyright © 2019 sroik. All rights reserved.
//

import GameplayKit
import SpriteKit
import UIKit

class GameViewController: UIViewController {
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        gameScene.size = view.bounds.size

        view.addSubview(sceneView)
        sceneView.ignoresSiblingOrder = true
        sceneView.showsFPS = true
        sceneView.showsDrawCount = true
        sceneView.showsNodeCount = true
        sceneView.presentScene(gameScene)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        qdriver.run()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneView.frame = view.bounds
    }

    private lazy var qdriver = QDriver(gameScene: gameScene)
    private let sceneView = SKView()
    private let gameScene = GameScene(birds: (0 ... 100).map { _ in Bird() })
}
