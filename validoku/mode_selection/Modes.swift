public enum Modes : CustomStringConvertible {
    case Rare
    case Medium
    case WellDone
    case Burned
    case PVP
    case Custom
    case Shable
    
    public var description: String {
        switch self {
        case .Rare:
            return "Rare"
        case .Medium:
            return "Medium"
        case .WellDone:
            return "Well-done"
        case .Burned:
            return "Burned"
        case .PVP:
            return "PVP"
        case .Custom:
            return "Custom"
        case .Shable:
            return "Shable"
        }
    }
}
