//
//  ListTopView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import SwiftUI

struct ListTopView: View {
    var body: some View {
        HStack {
            Text("Folders")
                .font(.title2)
                .foregroundColor(.primary)

            Spacer()

            Button(action: {
                print("list.bullet.rectangle.fill")
            }) {
                Image(systemName: "list.bullet.rectangle")
            }
            .padding(8)
            .foregroundColor(.primary)

            Button(action: {
                print("search")
            }) {
                Image(systemName: "magnifyingglass")
            }
            .padding(8)
            .foregroundColor(.primary)

            Button(action: {
                print("rectangle.and.paperclip")
            }) {
                Image(systemName: "rectangle.and.paperclip")
            }
            .padding(8)
            .foregroundColor(.primary)

            Button(action: {
                print("person.fill.badge.plus")
            }) {
                Image(systemName: "person.fill.badge.plus")
            }
            .padding(8)
            .foregroundColor(.primary) 

        }
        .padding()
        .background(Color.clear)
    }
}

struct ListTopView_Previews: PreviewProvider {
    static var previews: some View {
        ListTopView()
            .preferredColorScheme(.light) // Light mode önizleme
        ListTopView()
            .preferredColorScheme(.dark)  // Dark mode önizleme
    }
}
