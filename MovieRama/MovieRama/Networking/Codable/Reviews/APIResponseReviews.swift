//
//  Copyright © 2022 Panagiotis Mourgias
//  All rights reserved.
//

import Foundation

struct APIResponseReviews: Codable {
    let id, page: Int
    let authors: [APIResponseAuthor]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page
        case authors = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct APIResponseAuthor: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

struct AuthorDetails: Codable {
    let name, username: String
    private let avatarPath: String?
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
    
    var avatar: String? {
        let path = avatarPath?.dropFirst() ?? ""
        return String(path)
    }
}
