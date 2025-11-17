//
//  SettingsView.swift
//  PitchRecognizer
//


import SwiftUI

struct SettingsView: View {
    // Option A: simple storage
    @AppStorage("baseFrequencyHz") private var baseFrequencyHz: Double = 440.0
    @AppStorage("accidentalPreference") private var accidentalPreferenceRaw: String = AccidentalPreference.sharps.rawValue

    private var accidentalPreference: AccidentalPreference {
        get { AccidentalPreference(rawValue: accidentalPreferenceRaw) ?? .sharps }
        set { accidentalPreferenceRaw = newValue.rawValue }
    }

    var body: some View {
        Form {
            Section("Base Frequency") {
                // Very simple stepper for now
                Stepper(value: $baseFrequencyHz, in: 430...450, step: 1) {
                    Text("\(Int(baseFrequencyHz)) Hz")
                }
            }

            Section("Accidentals") {
                Picker("Display as", selection: $accidentalPreferenceRaw) {
                    ForEach(AccidentalPreference.allCases) { option in
                        Text(option.displayName).tag(option.rawValue)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
