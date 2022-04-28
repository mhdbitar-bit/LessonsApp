//
//  LessonDetailView.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import SwiftUI

struct LessonDetailView: View {
    
    @State var presentingVidewView = false
    var lesson: Lesson
    var image: UIImage
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 30) {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
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
                
                Text(lesson.name)
                    .foregroundColor(Color.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Text(lesson.description)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .font(.body)
                    .padding(.horizontal)
                
                Button {
                    print("TEst")
                } label: {
                    HStack {
                        Spacer()
                        HStack {
                            Text("Next lesson")
                            
                            Image(systemName: "chevron.forward")
                        }
                    }
                    .padding(.trailing)
                }
                
                Spacer()
            }
        }
        .background(Color("BackgroundColor"))
        .sheet(isPresented: $presentingVidewView) {
            VideoView(videoURL: lesson.videoUrl)
        }
        .navigationBarItems(trailing: Button(action: {
            print("test")
        }, label: {
            HStack {
                Image(systemName: "icloud.and.arrow.down")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                
                Text("Download")
            }
        }))
    }
    
    private func openVideo() {
        self.presentingVidewView = true
    }
}
