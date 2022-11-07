

import Foundation
struct Month : Codable {
	let number : Int?
	let en : String?
	let ar : String?

	enum CodingKeys: String, CodingKey {

		case number = "number"
		case en = "en"
		case ar = "ar"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		number = try values.decodeIfPresent(Int.self, forKey: .number)
		en = try values.decodeIfPresent(String.self, forKey: .en)
		ar = try values.decodeIfPresent(String.self, forKey: .ar)
	}

}
