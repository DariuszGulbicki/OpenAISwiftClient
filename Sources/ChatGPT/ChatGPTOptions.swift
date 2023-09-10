public class ChatGPTOptions {

    private var temperature: Double
    private var topP: Double
    private var n: Int
    private var stop: [String]
    private var maxTokens: Int
    private var presencePenalty: Double
    private var frequencyPenalty: Double

    private var functions: String

    private var functionCall: String

    public init() {
        self.temperature = 0.9
        self.topP = 1
        self.n = 1
        self.stop = []
        self.maxTokens = 150
        self.presencePenalty = 0
        self.frequencyPenalty = 0
        self.functions = ""
        self.functionCall = ""
    }

    public func setTemperature(temperature: Double) {
        self.temperature = temperature
    }

    public func temperature(temperature: Double) -> ChatGPTOptions {
        self.temperature = temperature
        return self
    }

    public func getTemperature() -> Double {
        return self.temperature
    }

    public func setTopP(topP: Double) {
        self.topP = topP
    }

    public func topP(topP: Double) -> ChatGPTOptions {
        self.topP = topP
        return self
    }

    public func getTopP() -> Double {
        return self.topP
    }

    public func setN(n: Int) {
        self.n = n
    }

    public func n(n: Int) -> ChatGPTOptions {
        self.n = n
        return self
    }

    public func getN() -> Int {
        return self.n
    }

    public func setStop(stop: [String]) {
        self.stop = stop
    }

    public func stop(stop: [String]) -> ChatGPTOptions {
        self.stop = stop
        return self
    }

    public func getStop() -> [String] {
        return self.stop
    }

    public func setMaxTokens(maxTokens: Int) {
        self.maxTokens = maxTokens
    }

    public func maxTokens(maxTokens: Int) -> ChatGPTOptions {
        self.maxTokens = maxTokens
        return self
    }

    public func getMaxTokens() -> Int {
        return self.maxTokens
    }

    public func setPresencePenalty(presencePenalty: Double) {
        self.presencePenalty = presencePenalty
    }

    public func presencePenalty(presencePenalty: Double) -> ChatGPTOptions {
        self.presencePenalty = presencePenalty
        return self
    }

    public func getPresencePenalty() -> Double {
        return self.presencePenalty
    }

    public func setFrequencyPenalty(frequencyPenalty: Double) {
        self.frequencyPenalty = frequencyPenalty
    }

    public func frequencyPenalty(frequencyPenalty: Double) -> ChatGPTOptions {
        self.frequencyPenalty = frequencyPenalty
        return self
    }

    public func getFrequencyPenalty() -> Double {
        return self.frequencyPenalty
    }

    public func setFunctions(functions: String) {
        self.functions = functions
    }

    public func functions(functions: String) -> ChatGPTOptions {
        self.functions = functions
        return self
    }

    public func getFunctions() -> String {
        return self.functions
    }

    public func setFunctionCall(functionCall: String) {
        self.functionCall = functionCall
    }

    public func functionCall(functionCall: String) -> ChatGPTOptions {
        self.functionCall = functionCall
        return self
    }

    public func getFunctionCall() -> String {
        return self.functionCall
    }

    public func toJSON() -> String {
        var out = """
            "temperature": \(temperature),
            "top_p": \(topP),
            "n": \(n),
            "stop": \(stop),
            "max_tokens": \(maxTokens),
            "presence_penalty": \(presencePenalty),
            "frequency_penalty": \(frequencyPenalty),
        """
        if (functions != "") {
            out += "functions: \(functions),"
        }
        if (functionCall != "") {
            out += "function_call: \(functionCall),"
        }
        return out
    }

}