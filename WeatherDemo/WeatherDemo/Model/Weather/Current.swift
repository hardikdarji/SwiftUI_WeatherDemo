
import Foundation
struct Current : Codable {
	let last_updated_epoch : Int?
	let last_updated : String?
	let temp_c : Double?
	let temp_f : Double?
	let is_day : Int?
	let condition : Condition?
	let wind_mph : Double?
	let wind_kph : Double?
	let wind_degree : Int?
	let wind_dir : String?
	let pressure_mb : Double?
	let pressure_in : Double?
	let precip_mm : Double?
	let precip_in : Double?
	let humidity : Int?
	let cloud : Int?
	let feelslike_c : Double?
	let feelslike_f : Double?
	let vis_km : Double?
	let vis_miles : Double?
	let uv : Double?
	let gust_mph : Double?
	let gust_kph : Double?

	enum CodingKeys: String, CodingKey {

		case last_updated_epoch = "last_updated_epoch"
		case last_updated = "last_updated"
		case temp_c = "temp_c"
		case temp_f = "temp_f"
		case is_day = "is_day"
		case condition = "condition"
		case wind_mph = "wind_mph"
		case wind_kph = "wind_kph"
		case wind_degree = "wind_degree"
		case wind_dir = "wind_dir"
		case pressure_mb = "pressure_mb"
		case pressure_in = "pressure_in"
		case precip_mm = "precip_mm"
		case precip_in = "precip_in"
		case humidity = "humidity"
		case cloud = "cloud"
		case feelslike_c = "feelslike_c"
		case feelslike_f = "feelslike_f"
		case vis_km = "vis_km"
		case vis_miles = "vis_miles"
		case uv = "uv"
		case gust_mph = "gust_mph"
		case gust_kph = "gust_kph"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		last_updated_epoch = try values.decodeIfPresent(Int.self, forKey: .last_updated_epoch)
		last_updated = try values.decodeIfPresent(String.self, forKey: .last_updated)
		temp_c = try values.decodeIfPresent(Double.self, forKey: .temp_c)
		temp_f = try values.decodeIfPresent(Double.self, forKey: .temp_f)
		is_day = try values.decodeIfPresent(Int.self, forKey: .is_day)
		condition = try values.decodeIfPresent(Condition.self, forKey: .condition)
		wind_mph = try values.decodeIfPresent(Double.self, forKey: .wind_mph)
		wind_kph = try values.decodeIfPresent(Double.self, forKey: .wind_kph)
		wind_degree = try values.decodeIfPresent(Int.self, forKey: .wind_degree)
		wind_dir = try values.decodeIfPresent(String.self, forKey: .wind_dir)
		pressure_mb = try values.decodeIfPresent(Double.self, forKey: .pressure_mb)
		pressure_in = try values.decodeIfPresent(Double.self, forKey: .pressure_in)
		precip_mm = try values.decodeIfPresent(Double.self, forKey: .precip_mm)
		precip_in = try values.decodeIfPresent(Double.self, forKey: .precip_in)
		humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
		cloud = try values.decodeIfPresent(Int.self, forKey: .cloud)
		feelslike_c = try values.decodeIfPresent(Double.self, forKey: .feelslike_c)
		feelslike_f = try values.decodeIfPresent(Double.self, forKey: .feelslike_f)
		vis_km = try values.decodeIfPresent(Double.self, forKey: .vis_km)
		vis_miles = try values.decodeIfPresent(Double.self, forKey: .vis_miles)
		uv = try values.decodeIfPresent(Double.self, forKey: .uv)
		gust_mph = try values.decodeIfPresent(Double.self, forKey: .gust_mph)
		gust_kph = try values.decodeIfPresent(Double.self, forKey: .gust_kph)
	}

}
