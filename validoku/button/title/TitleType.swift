//
//  MenuType.swift
//  Validoku
//
//  Created by Xiaomi on 09.05.2023.
//

enum TitleType : CustomStringConvertible {
    case Selection
    case NewGame
    case Continue
    case ValidokuDigit
    
    public var description: String {
        switch self {
        case .Selection:
            return "Select game mode"
        case .NewGame:
            return "New game"
        case .Continue:
            return "Continue"
        case .ValidokuDigit:
            return ""
        }
    }
}
