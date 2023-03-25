//
//  SettingsView.swift
//  Chat AI
//
//  Created by Ben Clarke on 19/02/2023.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SettingsViewModel()
    @State var sliderValue : Double = 500
        
    //MARK: - Body
    var body: some View {
        VStack {
            Form {
                Section("Chat Settings") {
                    VStack(alignment: .leading) {
                        Text("API Key")
                            .font(.system(size: CGFloat(viewModel.userFontSize)))
                        HStack {
                            if viewModel.showAPIKey {
                                TextField("API Key", text: $viewModel.apiKey)
                            } else {
                                SecureField("API Key", text: $viewModel.apiKey)
                            }
                            IconButton(imageName: viewModel.showAPIKey ? "eye.slash.fill" : "eye.fill", width: 20, height: 15) {
                                viewModel.showAPIKey.toggle()
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Max tokens: \(viewModel.maxTokens)")
                            .font(.system(size: CGFloat(viewModel.userFontSize)))
                        HStack {
                            Text("100").font(.system(size: CGFloat(viewModel.userFontSize)-2))
                            Slider(value: $sliderValue, in: 100...2000, step: 10)
                                .tint(.black)
                                .onChange(of: sliderValue) { _ in
                                    viewModel.maxTokens = Int(sliderValue)
                                }
                            Text("2000").font(.system(size: CGFloat(viewModel.userFontSize)-2))
                        }
                        
                    }
                    
                    HStack {
                        Text("Model")
                            .font(.system(size: CGFloat(viewModel.userFontSize)))
                        Spacer()
                        Picker("Select Model", selection: $viewModel.model) {
                            ForEach(viewModel.models, id: \.self) {
                                Text($0)
                            }
                        }.labelsHidden()
                    }
                    
                    HStack {
                        Text("User Icon")
                            .font(.system(size: CGFloat(viewModel.userFontSize)))
                        Spacer()
                        Picker("Select emoji icon", selection: $viewModel.userIcon) {
                            ForEach(viewModel.emojiIcons, id: \.self) {
                                Text($0)
                            }
                        }
                        .labelsHidden()
                    }
                    
                    HStack {
                        Stepper("Font Size: \(viewModel.userFontSize)", value: $viewModel.userFontSize, in: 10...24)
                            .font(.system(size: CGFloat(viewModel.userFontSize)))
                    }
                }
                
                // About
                Section("About") {
                        Text("The app uses GPT-3 API to generate high-quality text content from user prompts or keywords.").font(.system(size: CGFloat(viewModel.userFontSize)))
                    LinkSettingsView(title: "OpenAI Website", urlTitle: "openai.com", url: "https://openai.com/", fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "Generate API Key", urlTitle: "openai.com/account", url: "https://platform.openai.com/account/api-keys", fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "OpenAI API", urlTitle: "openai.com/docs", url: "https://platform.openai.com/docs/introduction", fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "Chat GPT", urlTitle: "chat.openai.com", url: "https://chat.openai.com/chat", fontSize: viewModel.userFontSize)
                }
                
                // Credits
                Section("Credits") {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Ben Clarke")
                                .font(.system(size: CGFloat(viewModel.userFontSize)))
                            Text("👨🏼‍💻 Developer")
                                .font(.system(size: CGFloat(viewModel.userFontSize)-2))
                        }
                        Spacer()
                        Link("Github", destination: URL(string: K.URLs.github)!)
                            .foregroundColor(.black)
                            .font(.system(size: CGFloat(viewModel.userFontSize)))
                    }
                }
            }
            
            RegularButton("Save") {
                viewModel.persistSettings()
                dismiss()
            }
        }
        .navigationTitle("Chat AI Settings")
        .onAppear() {
            sliderValue = Double(viewModel.maxTokens)
        }
    }
}

//MARK: - LinkSettingsView
struct LinkSettingsView: View {
    let title: String
    let urlTitle: String
    let url: String
    let fontSize: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: CGFloat(fontSize)))
            }
            Spacer()
            Link(urlTitle, destination: (URL(string: url) ?? URL(string: "https://openai.com/"))!)
                .foregroundColor(.black)
                .font(.system(size: CGFloat(fontSize)))
        }
    }
}

//MARK: - SettingsViewModel
class SettingsViewModel: ObservableObject {
    @Published var apiKey = ""
    @Published var showAPIKey = false
    @Published var maxTokens = 500
    @Published var model = "ada"
    @Published var userIcon = ""
    @Published var userFontSize = 14
    
    var models = ["davinci", "curie", "babbage", "ada"]
    var emojiIcons = [String]()
    
    init() {
        // Userdefaults
        let userSettings = UserPreferences.shared
        apiKey = userSettings.apiKey
        maxTokens = userSettings.maxTokens
        model = userSettings.model
        userIcon = userSettings.userIcon
        userFontSize = userSettings.fontSize
        
        // Emoji Setup
        let emojiRanges = [
            0x1F601...0x1F64F,
            0x1F680...0x1F6FF,
            0x1F900...0x1F9FF,
            0x1F1E6...0x1F1FF
        ]
        
        for range in emojiRanges {
            for i in range {
                guard let scalar = UnicodeScalar(i) else { continue }
                
                if scalar.properties.isEmoji && scalar.properties.isEmojiPresentation {
                    let emoji = String(scalar)
                    emojiIcons.append(emoji)
                }
            }
        }
    }
    
    func persistSettings() {
        let defaults = UserDefaults.standard
        KeychainWrapper.standard.set(apiKey, forKey: K.Keychain.apiKey)
        ChatNetworkManager.shared.updateClient(with: apiKey)
        defaults.set(maxTokens, forKey: K.userDefaultKeys.settings.maxToken)
        defaults.set(model, forKey: K.userDefaultKeys.settings.model)
        defaults.set(userIcon, forKey: K.userDefaultKeys.settings.userIcon)
        defaults.set(userFontSize, forKey: K.userDefaultKeys.settings.fontSize)
        print(userFontSize, "THE CURRENT SAVED FONT SIZE")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
