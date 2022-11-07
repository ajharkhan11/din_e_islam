

import Foundation
struct Meta : Codable {
	let latitude : Double?
	let longitude : Double?
	let timezone : String?
	let method : Method?
	let latitudeAdjustmentMethod : String?
	let midnightMode : String?
	let school : String?
	let offset : Offset?

	enum CodingKeys: String, CodingKey {

		case latitude = "latitude"
		case longitude = "longitude"
		case timezone = "timezone"
		case method = "method"
		case latitudeAdjustmentMethod = "latitudeAdjustmentMethod"
		case midnightMode = "midnightMode"
		case school = "school"
		case offset = "offset"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
		method = try values.decodeIfPresent(Method.self, forKey: .method)
		latitudeAdjustmentMethod = try values.decodeIfPresent(String.self, forKey: .latitudeAdjustmentMethod)
		midnightMode = try values.decodeIfPresent(String.self, forKey: .midnightMode)
		school = try values.decodeIfPresent(String.self, forKey: .school)
		offset = try values.decodeIfPresent(Offset.self, forKey: .offset)
	}

}
