//
//  ContentDetailView.swift
//  LearningAPP
//
//  Created by UKESH KUMAR on 06/04/23.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        
        VStack {
            
            
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            CodeTextView()
            
            
            if model.hasNextLessson() {
                
                Button(action: {
                    
                    model.nextLesson()
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                            
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            }
            else {
                Button(action: {
                    
                    model.currentConentSelected = nil
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)

                        
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            }
        }.padding()
            .navigationTitle(lesson?.title ?? "")
    }
}


