//
//  ContentModel.swift
//  LearningAPP
//
//  Created by UKESH KUMAR on 06/04/23.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    @Published var currentModule: Module?
    
    var currentModuleIndex = 0
    
    @Published var currentLesson: Lesson?
    
    var currentLessonIndex = 0
    
    @Published var lessonDescription = NSAttributedString()
    
    
    var styleData: Data?
    
    @Published var currentConentSelected: Int?
    
    init() {
        getLocalData()
    }
    
    func getLocalData() {
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            self.modules = modules
            
        }
        catch {
            print("Couldn't parse local data")
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
        } catch {
            print("Couldn't parse style data")
        }
    }
    
    func beginModule(_ moduleid: Int) {
        
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
                
                currentModuleIndex = index
                break
            }
        }
        
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex:Int) {
        
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLessson() -> Bool {
        
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        } else {
            return false
        }
    }
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        
        var data = Data()
        
        if styleData != nil {
            data.append(self.styleData!)
        }
        
        data.append(Data(htmlString.utf8))
        
        do {
            
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                
            resultString = attributedString
            
            
        } catch {
            print("Couldn't turn html into attributed string")
        }
        
        return resultString
    }
    
    
}
