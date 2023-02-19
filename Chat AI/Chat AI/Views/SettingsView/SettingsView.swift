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

    //MARK: - Body
    var body: some View {
        VStack {
            Form {
                Section("Chat Settings") {
                    Text("API Key")
                    Text("Model")
                    Text("Token")
                }
                
                Section("Credits") {
                    VStack(alignment: .leading) {
                        Text("Ben Clarke")
                        Text("👨🏼‍💻 Developer")
                            .font(.system(size: 10))
                    }
                }
            }
            
            Button("Save") {
                //TODO: - handle save
                dismiss()
            }.roundedButton()
        }
        .navigationTitle("Chat AI Settings")
        
    }
}

//MARK: - SettingsViewModel
class SettingsViewModel: ObservableObject {
    @Published var apiKey = ""
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
