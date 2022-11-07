

import Foundation
struct Weekday : Codable {
	let en : String?
	let ar : String?

	enum CodingKeys: String, CodingKey {

		case en = "en"
		case ar = "ar"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		en = try values.decodeIfPresent(String.self, forKey: .en)
		ar = try values.decodeIfPresent(String.self, forKey: .ar)
	}

}
