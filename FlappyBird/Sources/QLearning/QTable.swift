//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

struct QTable: Codable {
    /* It can be generic instead of typealias */
    typealias T = Int
    typealias Grid = [[[[T]]]]

    var grid: Grid

    /**
     yn: y-distance grid size
     xn: x-distance grid size
     vn: y-velocity grid size
     an: number of actions
     */
    init(yn: Int, xn: Int, vn: Int, an: Int = BirdAction.count) {
        let actions = Array(repeating: 0, count: an)
        let velocities = Array(repeating: actions, count: vn)
        let xdists = Array(repeating: velocities, count: xn)
        let ydists = Array(repeating: xdists, count: yn)
        self.grid = ydists
    }

    init(maxState: QState = QState.maxState, an: Int = BirdAction.count) {
        self.init(
            yn: maxState.yIndex + 1,
            xn: maxState.xIndex + 1,
            vn: maxState.vIndex + 1,
            an: an
        )
    }

    init(grid: Grid) {
        self.grid = grid
    }

    subscript(state state: QState) -> [T] {
        get {
            return self[y: state.yIndex, x: state.xIndex, v: state.vIndex]
        }
        set {
            self[y: state.yIndex, x: state.xIndex, v: state.vIndex] = newValue
        }
    }

    subscript(state state: QState, a a: Int) -> T {
        get {
            return self[y: state.yIndex, x: state.xIndex, v: state.vIndex, a: a]
        }
        set {
            self[y: state.yIndex, x: state.xIndex, v: state.vIndex, a: a] = newValue
        }
    }

    subscript(y y: Int, x x: Int, v v: Int) -> [T] {
        get {
            return grid[y][x][v]
        }
        set {
            grid[y][x][v] = newValue
        }
    }

    subscript(y y: Int, x x: Int, v v: Int, a a: Int) -> T {
        get {
            return grid[y][x][v][a]
        }
        set {
            grid[y][x][v][a] = newValue
        }
    }
}
