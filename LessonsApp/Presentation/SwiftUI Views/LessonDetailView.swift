//
//  LessonDetailView.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/26/22.
//

import SwiftUI

struct LessonDetailView: View {
    
    @State var presentingVidewView = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 30) {
                ZStack {
                    Image("test")
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
            VideoView()
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

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LessonDetailView()
    }
}
