//
//  LessonDetailView.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import SwiftUI

struct LessonDetailView: View {
    var body: some View {
        
        VStack(alignment: .center, spacing: 30) {
            ZStack {
                Image("test")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: .infinity, height: 300)
                    .overlay(
                        Color.black
                            .opacity(0.2)
                    )
                
                Button {
                    openVideo()
                } label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .frame(width: 50, height: 50)
                    
                }
                
            }
            
            Text("How To Capture Unique iPhone Street Photography")
                .foregroundColor(Color.white)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Text("Street photography allows you to capture really interesting photos… Photos that tell unique stories of strangers. Of course, it can be scary to get started with street photography. After all, you’re taking photos of people you don’t know... But honestly, you have nothing to worry about. And once you get started, it can become quite addictive!")
                .fontWeight(.regular)
                .foregroundColor(Color.white)
                .font(.body)
                .padding(.horizontal)
            
            Button {
                print("TEst")
            } label: {
                
            }
            
            Spacer()
        }
        .background(Color("BackgroundColor"))
        .navigationBarItems(trailing: Button(action: {
            print("test")
        }, label: {
            Text("Test")
        }))
        .ignoresSafeArea()
    }
    
    private func openVideo() {
        
    }
}

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetailView()
    }
}
