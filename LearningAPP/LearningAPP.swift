//
//  LearningAPPApp.swift
//  LearningAPP
//
//  Created by UKESH KUMAR on 06/04/23.
//

import SwiftUI

@main
struct LearningAPP: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
