public class ChatGPTMessage {

    private let role: ChatGPTMessageRole
    private let content: String

    public init(_ role: ChatGPTMessageRole, _ content: String) {
        self.role = role
        self.content = content
    }

    public func getRole() -> ChatGPTMessageRole {
        return self.role
    }

    public func getContent() -> String {
        return self.content
    }

    public func toJSON() -> String {
        return """
        {
            "role": "\(role)",
            "content": "\(encodeSpecialCharacters(content))"
        }
        """
    }

    private func encodeSpecialCharacters(_ string: String) -> String {
        return string.replacingOccurrences(of: "\\", with: "\\\\") 
            .replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\r", with: "\\r")
            .replacingOccurrences(of: "\t", with: "\\t")
            .replacingOccurrences(of: "\"", with: "\\\"")
    }

}