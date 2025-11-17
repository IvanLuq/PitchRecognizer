//
//  PitchRecognizerApp.swift
//  PitchRecognizer Watch App
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
