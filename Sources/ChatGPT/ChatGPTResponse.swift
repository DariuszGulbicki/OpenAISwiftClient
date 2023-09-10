public class ChatGPTResponse: CustomStringConvertible {

    public class Choice: CustomStringConvertible {

        public class Message: CustomStringConvertible {

            public class FunctionCall: CustomStringConvertible {

                private let name: String
                private let arguments: String

                public var description: String {
                    return "\(self.name)(\(self.arguments))"
                }

                public init(_ name: String, _ arguments: String) {
                    self.name = name
                    self.arguments = arguments
                }

                public func getName() -> String {
                    return self.name
                }

                public func getArguments() -> String {
                    return self.arguments
                }

            }

            private let role: String
            private let content: String?
            private let functionCall: FunctionCall?

            public var description: String {
                return self.content ?? self.functionCall?.getName() ?? "ChatGPTResponse.Choice.Message"
            }

            public init(_ role: String, _ content: String?, _ functionCall: FunctionCall?) {
                self.role = role
                self.content = content
                self.functionCall = functionCall
            }

            public func getRole() -> String {
                return self.role
            }

            public func getContent() -> String? {
                return self.content
            }

            public func getFunctionCall() -> FunctionCall? {
                return self.functionCall
            }

        }

        private let index: Int
        private let message: Message
        private let finishReason: String

        public var description: String {
            return self.message.getContent() ?? self.message.getFunctionCall()?.getName() ?? "ChatGPTResponse.Choice"
        }

        public init(_ index: Int, _ message: Message, _ finishReason: String) {
            self.index = index
            self.message = message
            self.finishReason = finishReason
        }

        public func getIndex() -> Int {
            return self.index
        }

        public func getMessage() -> Message {
            return self.message
        }

        public func getFinishReason() -> String {
            return self.finishReason
        }

    }

    public class Usage: CustomStringConvertible {

        private let promptTokens: Int
        private let completionTokens: Int
        private let totalTokens: Int

        public var description: String {
            return "ChatGPTResponse.Usage(promptTokens: \(self.promptTokens), completionTokens: \(self.completionTokens), totalTokens: \(self.totalTokens))"
        }

        public init(_ promptTokens: Int, _ completionTokens: Int, _ totalTokens: Int) {
            self.promptTokens = promptTokens
            self.completionTokens = completionTokens
            self.totalTokens = totalTokens
        }

        public func getPromptTokens() -> Int {
            return self.promptTokens
        }

        public func getCompletionTokens() -> Int {
            return self.completionTokens
        }

        public func getTotalTokens() -> Int {
            return self.totalTokens
        }

    }

    private let id: String
    private let object: String
    private let created: Int
    private let model: ChatGPTModel
    private let choices: [Choice]
    private let usage: Usage

    public var description: String {
        return self.choices[0].getMessage().getContent() ?? self.choices[0].getMessage().getFunctionCall()?.getName() ?? self.object
    }

    public static func fromJSON(_ json: [String: Any]) -> ChatGPTResponse {
        let id = json["id"] as! String
        let object = json["object"] as! String
        let created = json["created"] as! Int
        let model = ChatGPTModel.fromAPIModelName(json["model"] as! String)
        let choices = json["choices"] as! [[String: Any]]
        var choicesOut = [Choice]()
        for choice in choices {
            let index = choice["index"] as! Int
            let message = choice["message"] as! [String: Any]
            let role = message["role"] as! String
            let content = message["content"] as! String?
            let functionCall = message["function_call"] as! [String: Any]?
            var functionCallOut: Choice.Message.FunctionCall? = nil
            if (functionCall != nil) {
                let name = functionCall!["name"] as! String
                let arguments = functionCall!["arguments"] as! String
                functionCallOut = Choice.Message.FunctionCall(name, arguments)
            }
            let messageOut = Choice.Message(role, content, functionCallOut)
            let finishReason = choice["finish_reason"] as! String
            choicesOut.append(Choice(index, messageOut, finishReason))
        }
        let usage = json["usage"] as! [String: Any]
        let promptTokens = usage["prompt_tokens"] as! Int
        let completionTokens = usage["completion_tokens"] as! Int
        let totalTokens = usage["total_tokens"] as! Int
        let usageOut = Usage(promptTokens, completionTokens, totalTokens)
        return ChatGPTResponse(id, object, created, model, choicesOut, usageOut)
    }

    public init(_ id: String, _ object: String, _ created: Int, _ model: ChatGPTModel, _ choices: [Choice], _ usage: Usage) {
        self.id = id
        self.object = object
        self.created = created
        self.model = model
        self.choices = choices
        self.usage = usage
    }

    public subscript(index: Int) -> String? {
        return self.choices[index].getMessage().getContent()
    }

    public func getId() -> String {
        return self.id
    }

    public func getObject() -> String {
        return self.object
    }

    public func getCreated() -> Int {
        return self.created
    }

    public func getModel() -> ChatGPTModel {
        return self.model
    }

    public func getChoices() -> [Choice] {
        return self.choices
    }

    public func getUsage() -> Usage {
        return self.usage
    }

}