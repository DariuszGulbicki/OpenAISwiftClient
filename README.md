# SwiftOpenAICleint

A Swift client for the [OpenAI API](https://beta.openai.com/docs/api-reference).

## Support

This library supports the following API functions:

- [x] [Chat](https://beta.openai.com/docs/api-reference/chat)
- [ ] [Audio](https://beta.openai.com/docs/api-reference/audio)
- [ ] [Embeddings](https://beta.openai.com/docs/api-reference/embeddings)
- [ ] [Files](https://beta.openai.com/docs/api-reference/files)
- [ ] [Images](https://beta.openai.com/docs/api-reference/images)
- [ ] [Models](https://beta.openai.com/docs/api-reference/models)
- [ ] [Moderations](https://beta.openai.com/docs/api-reference/moderations)

## Installation

You can install this package using Swift Package Manager.

```swift
.package(url: "https://github.com/DariuszGulbicki/SwiftOpenAIClient.git", from: "0.0.1")
```

## Usage

To use this library, you need to have an OpenAI API key. You can get one [here](https://beta.openai.com/).

### Chat

To use ChatGPT api you will need to import the `ChatGPT` library.

```swift
import ChatGPT
```

Then you can use either a single API call or a ChatGPT instance that keeps the state of the conversation.

Lets start with a single API call.

```swift
// Start by sending a request to the API
// ChatGPTMessages is used to represent system, user and agent messages. .empty means that server message will be empty.
// This will return a ChatGPTResponse object that contains the response from the API.
let completion = ChatGPT.generateCompletion("apiKey", .gpt4, ChatGPTMessages.empty().user("Hello ChatGPT!"))
// Now lets get the first completion proposed by ChatGPT
let firstCompletion = completion[0]
// And print the response
print(firstCompletion)
```

Now we will used the instance method that automatically saves certain number of messages and allows you to continue the conversation.
As well as keep the total number of tokens used.

```swift
// Create a ChatGPT instance
let chat = ChatGPT("apiKey", .gpt4)
// Send a message to ChatGPT
let response = chat.prompt("Hello ChatGPT!")
// Print the response
print(response)
// Send message without saving the response int the conversation
let response1 = chat.promptSilently("This message will not be saved in the conversation")
// Send another message
let response2 = chat.prompt("How are you?")
// Print the response
print(response2)
// Print the total number of tokens used
print("Tokens used: \(chat.getTotalUsage())")
```

## License

This library is licensed under the MIT license. See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome. Feel free to open a pull request or issue on GitHub!