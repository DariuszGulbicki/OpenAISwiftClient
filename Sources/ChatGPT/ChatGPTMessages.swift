public class ChatGPTMessages {

    public static func system(_ text: String) -> ChatGPTMessages {
        let messages = ChatGPTMessages()
        return messages.add(.system, text)
    }

    public static func empty() -> ChatGPTMessages {
        let messages = ChatGPTMessages()
        return messages.add(.system, "")
    }

    private var messages: [ChatGPTMessage] = []

    private init() {}

    @discardableResult
    public func add(_ message: ChatGPTMessage) -> ChatGPTMessages {
        self.messages.append(message)
        return self
    }

    @discardableResult
    public func add(_ role: ChatGPTMessageRole, _ content: String) -> ChatGPTMessages {
        self.messages.append(ChatGPTMessage(role, content))
        return self
    }

    @discardableResult
    public func user(_ text: String) -> ChatGPTMessages {
        return self.add(.user, text)
    }

    @discardableResult
    public func assistant(_ text: String) -> ChatGPTMessages {
        return self.add(.assistant, text)
    }

    public func getMessages() -> [ChatGPTMessage] {
        return self.messages
    }

    public func count() -> Int {
        return self.messages.count
    }
    public func get(_ index: Int = 1) -> ChatGPTMessage {
        return self.messages[index]
    }

    public func getLast() -> ChatGPTMessage? {
        return self.messages.last
    }
    public func remove(_ index: Int) {
        self.messages.remove(at: index)
    }

    public func removeFirst() {
        self.messages.removeFirst()
    }

    public func removeLast() {
        self.messages.removeLast()
    }

    public func removeLast(_ count: Int) {
        for _ in 0..<count {
            self.removeLast()
        }
    }

    public func removeFirst(_ count: Int) {
        for _ in 0..<count {
            self.removeFirst()
        }
    }

    public func clear() {
        self.messages = []
    }

    public func toJSON() -> String {
        var messages = "["
        for (index, message) in self.messages.enumerated() {
            messages += message.toJSON()
            if (index != self.messages.count - 1) {
                messages += ","
            }
        }
        messages += "]"
        return messages
    }

}