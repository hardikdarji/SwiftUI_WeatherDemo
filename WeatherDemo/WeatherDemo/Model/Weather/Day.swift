
import Foundation
struct Day : Codable {
	let maxtemp_c : Double?
	let mintemp_c : Double?
	let condition : Condition?
	
	enum CodingKeys: String, CodingKey {

		case maxtemp_c = "maxtemp_c"
		case mintemp_c = "mintemp_c"
		case condition = "condition"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		maxtemp_c = try values.decodeIfPresent(Double.self, forKey: .maxtemp_c)
		mintemp_c = try values.decodeIfPresent(Double.self, forKey: .mintemp_c)
		condition = try values.decodeIfPresent(Condition.self, forKey: .condition)
	}

}
