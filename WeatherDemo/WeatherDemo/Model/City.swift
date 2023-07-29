

import Foundation
struct City : Identifiable, Hashable {
    var id: UUID = UUID()
    var name : String = ""
    init(name: String = "")
    {
        self.name = name
    }
}
