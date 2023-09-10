public enum ChatGPTModel {

    case gpt3Turbo
    case gpt3Turbo_16k
    case gpt3Turbo_16k_0613
    case gpt3Turbo_0613
    case gpt3Turbo_0301
    case gpt4
    case gpt4_0613
    case gpt4_0314

    public func getAPIModelName() -> String {
        switch self {
        case .gpt3Turbo:
            return "gpt-3.5-turbo"
        case .gpt3Turbo_16k:
            return "gpt-3.5-turbo-16k"
        case .gpt3Turbo_16k_0613:
            return "gpt-3.5-turbo-16k-0613"
        case .gpt3Turbo_0613:
            return "gpt-3.5-turbo-0613"
        case .gpt3Turbo_0301:
            return "gpt-3.5-turbo-0301"
        case .gpt4:
            return "gpt-4"
        case .gpt4_0613:
            return "gpt-4-0613"
        case .gpt4_0314:
            return "gpt-4-0314"
        }
    }

    public static func fromAPIModelName(_ apiModelName: String) -> ChatGPTModel {
        switch apiModelName {
        case "gpt-3.5-turbo":
            return .gpt3Turbo
        case "gpt-3.5-turbo-16k":
            return .gpt3Turbo_16k
        case "gpt-3.5-turbo-16k-0613":
            return .gpt3Turbo_16k_0613
        case "gpt-3.5-turbo-0613":
            return .gpt3Turbo_0613
        case "gpt-3.5-turbo-0301":
            return .gpt3Turbo_0301
        case "gpt-4-0613":
            return .gpt4_0613
        case "gpt-4":
            return .gpt4
        case "gpt-4-0314":
            return .gpt4_0314
        default:
            return .gpt3Turbo
        }
    }

}