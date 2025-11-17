//
//  PitchRecognizerViewModel.swift
//  PitchRecognizer
//

import Foundation
import Combine

final class PitchRecognizerViewModel: ObservableObject {
    @Published var isListening: Bool = false
    @Published var currentNote: String = "--"

    // Later we’ll inject services here (audio, settings, etc.)

    func toggleListening() {
        isListening.toggle()
        if isListening {
            startFakeDetection()
        } else {
            stopFakeDetection()
        }
    }

    private var timer: Timer?

    private func startFakeDetection() {
        // TEMP: simulate changing notes every 0.5s
        let notes = ["C", "D", "E", "F", "G", "A", "B", "C#"]
        var idx = 0

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.currentNote = notes[idx % notes.count]
            idx += 1
        }
    }

    private func stopFakeDetection() {
        timer?.invalidate()
        timer = nil
        currentNote = "--"
    }
}
