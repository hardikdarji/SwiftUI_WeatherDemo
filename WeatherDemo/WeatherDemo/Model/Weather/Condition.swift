

import Foundation
struct Condition : Codable {
	let text : String?
	let icon : String?
	let code : Int?

	enum CodingKeys: String, CodingKey {

		case text = "text"
		case icon = "icon"
		case code = "code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		code = try values.decodeIfPresent(Int.self, forKey: .code)
	}

}
