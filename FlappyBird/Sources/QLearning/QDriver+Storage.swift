//
//  Copyright © 2019 sroik. All rights reserved.
//

import Foundation

/* Dumpest way ever to store the data. But it's the fastest way in development */
extension QDriver {
    func restoreQTable() {
        guard let data = UserDefaults.standard.value(forKey: "qtable") as? Data else {
            return
        }

        do {
            agent.q = try JSONDecoder().decode(QTable.self, from: data)
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }

    func backupQTable() {
        do {
            let data = try JSONEncoder().encode(agent.q)
            UserDefaults.standard.set(data, forKey: "qtable")
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
