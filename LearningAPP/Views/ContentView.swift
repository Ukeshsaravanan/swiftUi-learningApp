//
//  ContentView.swift
//  LearningAPP
//
//  Created by UKESH KUMAR on 06/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                if model.currentModule != nil {
                    
                    ForEach(0..<model.currentModule!.content.lessons.count, id: \.self) { index in
                        
                        let lesson = model.currentModule!.content.lessons[index]
                        
                        NavigationLink(destination: ContentDetailView()
                            .onAppear(perform: {model.beginLesson(index)})
                        , label: {
                            
                            ZStack(alignment: .leading) {
                                
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .frame(height: 66)
                                
                                HStack (spacing: 30) {
                                    
                                    Text(String(index + 1))
                                        .bold()
                                    
                                    VStack (alignment: .leading) {
                                        Text(lesson.title)
                                            .bold()
                                        Text(lesson.duration)
                                    }
                                }.padding()
                            }.padding(.bottom,5)
                        })
                        
                        
                    }
                }
            }.padding()
                .navigationTitle("Learn \(model.currentModule?.category ?? "")")
                .accentColor(.black)
        }
    }
}

