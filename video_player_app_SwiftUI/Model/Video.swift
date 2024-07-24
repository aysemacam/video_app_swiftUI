//
//  Video.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import Foundation

struct VideoResponse: Codable {
    let total: Int
    let totalHits: Int
    let hits: [Video]
}

struct Video: Codable, Identifiable {
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let duration: Int
    let videos: VideoFiles
    let views: Int
    let downloads: Int
    let likes: Int
    let comments: Int
    let user_id: Int
    let user: String
    let userImageURL: String
}

struct VideoFiles: Codable {
    let large: VideoFile
    let medium: VideoFile
    let small: VideoFile
    let tiny: VideoFile
}

struct VideoFile: Codable {
    let url: String
    let width: Int
    let height: Int
    let size: Int
    let thumbnail: String
}
