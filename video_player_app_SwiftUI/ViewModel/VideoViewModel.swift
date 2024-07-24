//
//  VideoViewModel.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import SwiftUI

class VideoViewModel: ObservableObject {
    @Published var videos: [Video] = []
    @Published var customItems: [Category] = [
        Category(title: "Flowers", imageName: "camera.macro"),
        Category(title: "Music", imageName: "music.note"),
        Category(title: "Nature", imageName: "tree.fill"),
        Category(title: "Animals", imageName: "cat.fill"),
        Category(title: "Moview", imageName: "movieclapper.fill"),
        Category(title: "Snow", imageName: "snowflake")

    ]

    private let apiKey = "45070802-922c9dbab911a14e7d81c3b6b"

    func fetchVideos(query: String) {
        guard let url = URL(string: "https://pixabay.com/api/videos/?key=\(apiKey)&q=\(query)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let videoResponse = try decoder.decode(VideoResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.videos = videoResponse.hits
                        print(self.videos)
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}



