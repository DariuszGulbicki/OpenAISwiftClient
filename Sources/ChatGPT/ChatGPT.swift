import Rest
import Foundation
import LoggingCamp

public class ChatGPT {

    public typealias messageSelector = (ChatGPTResponse) -> String?
    public typealias callback = (ChatGPTResponse, ChatGPTMessages) -> Void

    let logger = Logger("ChatGPT")

    public static var openAIQuarry = RestQuarry(baseURL: "https://api.openai.com/v1", logger: Logger("ChatGPT Quarry"))

    public static func generateCompletion(_ apiKey: String, _ model: ChatGPTModel, _ messages: ChatGPTMessages, _ options: ChatGPTOptions = ChatGPTOptions(), _ logger: Logger = Logger("ChatGPT")) -> ChatGPTResponse {
        let chatCompletionRequest = RestQuarryRequestBuilder().uri("chat/completions")
        .method("POST")
        .body("""
        {
            "model": "\(model.getAPIModelName())",
            \(options.toJSON())
            "messages": \(messages.toJSON())
        }
        """)
        .header("Content-Type", "application/json")
        .header("Authorization", "Bearer \(apiKey)")
        .build()
        logger.debug("Prepared request: \(chatCompletionRequest.getBody())")
        logger.debug("Sending request to OpenAI API")
        let res = openAIQuarry.query(request: chatCompletionRequest)
        let body = res.getBody()
        logger.debug("Received response from OpenAI API: \(body)")
        logger.debug("Parsing JSON")
        let json = try! JSONSerialization.jsonObject(with: Data(body.utf8), options: []) as! [String: Any]
        logger.debug("Parsing JSON into ChatGPTResponse")
        return ChatGPTResponse.fromJSON(json)
    }

    private let apiKey: String
    private let model: ChatGPTModel
    private let options: ChatGPTOptions

    private var messageLimit = 10
    private var totalUsage = 0

    private var conversation: ChatGPTMessages

    public init(_ apiKey: String, _ model: ChatGPTModel, _ serverPrompt: String? = nil, _ options: ChatGPTOptions = ChatGPTOptions()) {
        self.apiKey = apiKey
        self.model = model
        self.options = options
        self.conversation = (serverPrompt != nil) ? ChatGPTMessages.system(serverPrompt!) : ChatGPTMessages.empty()
    }

    public func setConversationLimit(_ limit: Int) {
        self.messageLimit = limit
    }

    public func getConversationLimit() -> Int {
        return self.messageLimit
    }

    public func getTotalUsage() -> Int {
        return self.totalUsage
    }

    @discardableResult
    public func prompt(_ prompt: String) -> ChatGPTResponse {
        let messages = self.conversation.user(prompt)
        ensureConversationLimit()
        let response = ChatGPT.generateCompletion(self.apiKey, self.model, messages, self.options, self.logger)
        self.totalUsage += response.getUsage().getTotalTokens()
        if (response[0] != nil) {
            self.conversation.assistant(response[0]!)
        }
        ensureConversationLimit()
        return response
    }

    @discardableResult
    public func prompt(_ prompt: String, _ selctor: @escaping messageSelector) -> String? {
        let messages = self.conversation.user(prompt)
        ensureConversationLimit()
        let response = ChatGPT.generateCompletion(self.apiKey, self.model, messages, self.options, self.logger)
        self.totalUsage += response.getUsage().getTotalTokens()
        let out = selctor(response)
        if (out != nil) {
            self.conversation.assistant(out!)
        }
        ensureConversationLimit()
        return out
    }

    public func prompt(_ prompt: String, _ callback: @escaping callback) {
        let messages = self.conversation.user(prompt)
        let response = ChatGPT.generateCompletion(self.apiKey, self.model, messages, self.options, self.logger)
        self.totalUsage += response.getUsage().getTotalTokens()
        callback(response, self.conversation)
    }

    public func promptSilently(_ prompt: String) -> ChatGPTResponse {
        let messages = self.conversation.user(prompt)
        let response = ChatGPT.generateCompletion(self.apiKey, self.model, messages, self.options, self.logger)
        self.totalUsage += response.getUsage().getTotalTokens()
        return response
    }

    public func promptSilently(_ prompt: String, _ selctor: @escaping messageSelector) -> String? {
        let messages = self.conversation.user(prompt)
        let response = ChatGPT.generateCompletion(self.apiKey, self.model, messages, self.options, self.logger)
        self.totalUsage += response.getUsage().getTotalTokens()
        let out = selctor(response)
        return out
    }

    public func addMessage(_ role: ChatGPTMessageRole, _ message: String) {
        self.conversation.add(role, message)
        ensureConversationLimit()
    }

    public func addUserMessage(_ message: String) {
        self.conversation.user(message)
        ensureConversationLimit()
    }

    public func addAssistantMessage(_ message: String) {
        self.conversation.assistant(message)
        ensureConversationLimit()
    }

    private func ensureConversationLimit() {
        if (self.conversation.getMessages().count > self.messageLimit) {
            self.conversation.removeLast()
        }
    }

}