//
//  ViewExtensions.swift
//  Chat AI
//
//  Created by Ben Clarke on 24/02/2023.
//

import Foundation
import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

