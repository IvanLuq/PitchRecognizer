//
//  AppSettings.swift
//  PitchRecognizer
//
//  Created by admin on 15/11/25.
//

import Foundation

enum AccidentalPreference: String, Codable, CaseIterable, Identifiable {
    case sharps  // e.g. C#
    case flats   // e.g. Db

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .sharps: return "Sharps (#)"
        case .flats:  return "Flats (♭)"
        }
    }
}

struct AppSettings: Codable {
    var baseFrequencyHz: Double
    var accidentalPreference: AccidentalPreference

    static let `default` = AppSettings(
        baseFrequencyHz: 440.0,
        accidentalPreference: .sharps
    )
}
