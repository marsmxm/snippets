//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by CL10102-M on 2022/5/12.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
