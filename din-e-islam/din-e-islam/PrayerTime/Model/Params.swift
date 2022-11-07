

import Foundation
struct Params : Codable {
	let fajr : Double?
	let isha : Double?

	enum CodingKeys: String, CodingKey {

		case fajr = "Fajr"
		case isha = "Isha"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		fajr = try values.decodeIfPresent(Double.self, forKey: .fajr)
		isha = try values.decodeIfPresent(Double.self, forKey: .isha)
	}

}
