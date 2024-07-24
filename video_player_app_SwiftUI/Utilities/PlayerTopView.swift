//
//  PlayerTopView.swift
//  video_player_app_SwiftUI
//
//  Created by Aysema Çam on 23.07.2024.
//

import SwiftUI

struct PlayerTopView: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String

    var body: some View {
        Spacer()
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(.vertical)
                    .foregroundColor(.white)
            }
            Text(title)
                .font(.title3)
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            
            Button(action: {
                print("list.bullet.rectangle.fill")
            }) {
                Image(systemName: "arrow.rectanglepath")
                    .resizable()
            }
            .padding(10)
            .foregroundColor(.white)
            .frame(width: 39, height: 37)
            
            Button(action: {
                print("search")
            }) {
                Image(systemName: "music.note")
                    .resizable()
            }
            .padding(10)
            .foregroundColor(.white)
            .frame(width: 34, height: 37)
            
            Button(action: {
                print("rectangle.and.paperclip")
            }) {
                Image(systemName: "list.dash.header.rectangle")
                    .resizable()
            }
            .padding(10)
            .foregroundColor(.white)
            .frame(width: 37, height: 37)
            
            Button(action: {
                print("person.fill.badge.plus")
            }) {
                Image(systemName: "link")
                    .resizable()
            }
            .padding(10)
            .foregroundColor(.white)
            .frame(width: 37, height: 37)
        }
      
    }
    
}

#Preview {
    PlayerTopView(title: "Sample Title")
}
