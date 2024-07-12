//
//  CountryModel.swift
//  Assignment
//
//  Created by Swapnil Adnak on 10/07/24.
//

struct CountryModel: Codable {
    let status: String
    let statusCode: Int
    let version: String
    let access: String
    let total: Int
    let offset: Int
    let limit: Int
    let data: [String: CountryInfo]
    
    private enum CodingKeys: String, CodingKey {
        case status
        case statusCode = "status-code"
        case version
        case access
        case total
        case offset
        case limit
        case data
    }
}

struct CountryInfo: Codable {
    let country: String
    let region: String
}
