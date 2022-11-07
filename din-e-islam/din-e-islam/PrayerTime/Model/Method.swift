

import Foundation
struct Method : Codable {
	let id : Int?
	let name : String?
	let params : Params?
	let location : Location?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case params = "params"
		case location = "location"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		params = try values.decodeIfPresent(Params.self, forKey: .params)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
	}

}
