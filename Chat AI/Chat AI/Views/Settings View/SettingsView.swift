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
                    Toggle("Enable Dark Mode", isOn: $viewModel.darkModeEnabled)
                        .font(.system(size: CGFloat(viewModel.userFontSize)))
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
                        VStack(alignment: .leading) {
                            Text("Enable related chat")
                                .font(.system(size: CGFloat(viewModel.userFontSize)))
                            Text("Enabling this feeds the prior messages in the current conversation to the API.")
                                .font(.system(size: CGFloat(viewModel.userFontSize-2)))
                        }
                       
                        Spacer()
                        Toggle("Enable related chat", isOn: $viewModel.enabledRelatedChat)
                            .labelsHidden()
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
                        Stepper("Font Size: \(viewModel.userFontSize)", value: $viewModel.userFontSize, in: 10...20)
                            .font(.system(size: CGFloat(viewModel.userFontSize)))
                    }
                }
                
                // About
                Section("Useful links") {
//                        Text("The app uses GPT-3 API to generate high-quality text content from user prompts or keywords.").font(.system(size: CGFloat(viewModel.userFontSize)))
                    LinkSettingsView(title: "Privacy Policy", urlTitle: "vikingskullapps.com/privacy-policy", url: "https://vikingskullapps.com/apps/chat-ai-app/privacy/", fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "Terms of Service", urlTitle: "vikingskullapps.com/terms-conditions", url: "https://vikingskullapps.com/apps/chat-ai-app/terms-conditions/", fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "OpenAI Website", urlTitle: "openai.com", url: "https://openai.com/", fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "Generate API Key", urlTitle: "openai.com/account", url: "https://platform.openai.com/account/api-keys", fontSize: viewModel.userFontSize)
                }
                
                // Contact
                Section("Tell me what you think") {
                    LinkSettingsIconCell(icon: "star.fill", cellLabel: "Review", buttonText: "Rate the app", fontSize: viewModel.userFontSize) {
                        rateApp()
                    }
                    LinkSettingsIconCell(icon: "envelope.fill", cellLabel: "Provide feedback", buttonText: "Contact me", fontSize: viewModel.userFontSize) {
                        openURL(url: K.Links.contactURL)
                    }
                }
                
                // Other
                Section("Other") {
                    //LinkSettingsView(title: "Buy me a coffee", urlTitle: "buymeacoffee.com", url: K.Links.butMeACoffeeURL, fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "Instagram", urlTitle: "@vikingskullapps", url: K.Links.instagramURL, fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "Website", urlTitle: "vikingskullapps.com", url: K.Links.websiteURL, fontSize: viewModel.userFontSize)
                    LinkSettingsView(title: "Get Motivated", urlTitle: "Quoto App", url: K.Links.quotoURL, fontSize: viewModel.userFontSize)
                }
            }
            
            RegularButton("Save") {
                viewModel.persistSettings()
                dismiss()
            }
        }
        .navigationTitle("Chat AI Settings")
        .alert("Disable related chat",
               isPresented: Binding<Bool>(get: { !viewModel.enabledRelatedChat },
                                          set: { _ in }
                                         ),
               actions: {
            Button("OK", role: .cancel, action: {})
        }, message: {
            Text("By disabling related chat, this will mean all messages in the current conversation are not related.")
        })
        .onAppear() {
            sliderValue = Double(viewModel.maxTokens)
        }
        .preferredColorScheme(viewModel.darkModeEnabled ? .dark : .light)
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
                .font(.system(size: CGFloat(fontSize)-2))
        }
    }
}

//MARK: - IconCell
struct LinkSettingsIconCell: View {
    
    var icon: String
    var cellLabel: String
    var buttonText: String
    let fontSize: Int
    var buttonTapped: (() -> Void)
    
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "\(icon)")
                Text(cellLabel)
                    .font(.system(size: CGFloat(fontSize)))
                Spacer()
                Button {
                    buttonTapped()
                } label: {
                    Text("\(buttonText)")
                        .font(.system(size: CGFloat(fontSize)-2))
                }
            }
        }
    }
    
}

//MARK: - SettingsViewModel
class SettingsViewModel: ObservableObject {
    @Published var darkModeEnabled = false
    @Published var apiKey = ""
    @Published var showAPIKey = false
    @Published var maxTokens = 500
    @Published var model = "ada"
    @Published var enabledRelatedChat = true
    @Published var userIcon = ""
    @Published var userFontSize = 14
    
    var models = ["davinci", "curie", "babbage", "ada"]
    var emojiIcons = [String]()
    
    init() {
        // Userdefaults
        let userSettings = UserPreferences.shared
        
        darkModeEnabled = userSettings.darkModeEnabled
        apiKey = userSettings.apiKey
        maxTokens = userSettings.maxTokens
        model = userSettings.model
        enabledRelatedChat = userSettings.enabledRelatedChat
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
        defaults.set(darkModeEnabled, forKey: K.userDefaultKeys.settings.darkModelEnabled)
        defaults.set(maxTokens, forKey: K.userDefaultKeys.settings.maxToken)
        defaults.set(model, forKey: K.userDefaultKeys.settings.model)
        defaults.set(enabledRelatedChat, forKey: K.userDefaultKeys.settings.enabledRelatedChat)
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
