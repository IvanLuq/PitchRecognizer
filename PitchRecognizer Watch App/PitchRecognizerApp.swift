//
//  PitchRecognizerApp.swift
//  PitchRecognizer Watch App
//
//  Created by admin on 12/11/25.
//

@main
struct PitchRecognizerApp: App {
    @StateObject private var viewModel = PitchRecognizerViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainPitchView()
            }
            .environmentObject(viewModel)
        }
    }
}
