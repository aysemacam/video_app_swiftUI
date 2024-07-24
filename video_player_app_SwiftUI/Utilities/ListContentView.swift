//
//  ListContentView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import Foundation
import SwiftUI

struct ListContentView: View {
    var title: String
    var subtitle: String
    var imageUrl: String
    
    var body: some View {
        HStack {
            if let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 90, height: 60)
                            .cornerRadius(7)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 90, height: 60)
                            .cornerRadius(7)
                    case .failure:
                        Image(systemName: "folder.fill")
                            .resizable()
                            .frame(width: 90, height: 60)
                            .cornerRadius(7)
                    @unknown default:
                        Image(systemName: "folder.fill")
                            .resizable()
                            .frame(width: 90, height: 60)
                            .cornerRadius(7)
                    }
                }
            } else {
                Image(systemName: "folder.fill")
                    .resizable()
                    .frame(width: 90, height: 60)
                    .cornerRadius(7)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
       
    }
}

struct ListContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListContentView(title: "Example Title", subtitle: "Example Subtitle", imageUrl: "https://example.com/image.jpg")
    }
}
