

import Foundation
struct Designation : Codable {
	let abbreviated : String?
	let expanded : String?

	enum CodingKeys: String, CodingKey {

		case abbreviated = "abbreviated"
		case expanded = "expanded"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		abbreviated = try values.decodeIfPresent(String.self, forKey: .abbreviated)
		expanded = try values.decodeIfPresent(String.self, forKey: .expanded)
	}

}
