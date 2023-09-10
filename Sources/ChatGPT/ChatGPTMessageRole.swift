public enum ChatGPTMessageRole: CustomStringConvertible {
    
    case system
    case user
    case assistant

    public var description: String {
        switch self {
        case .system:
            return "system"
        case .user:
            return "user"
        case .assistant:
            return "assistant"
        }
    }

}