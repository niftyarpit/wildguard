//
//  WildGuardApp.swift
//  WildGuard
//
//  Created by Paul Hudson on 27/01/2024.
//

import SwiftUI

@main
struct WildGuardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        WindowGroup(for: String.self) { $string in
            if let string {
                Image(string)
                    .resizable()
                    .scaledToFill()
            }
        }
        .defaultSize(width: 1000, height: 1000)
    }
}

