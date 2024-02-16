//
//  ContentView.swift
//  WildGuard
//
//  Created by Paul Hudson on 27/01/2024.
//

import SwiftUI
import RealityKit

struct ContentView: View {

    @State private var dataController = DataController()
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @State private var isImmersiveSpaceOpen = false

    var body: some View {
        TabView(selection: $dataController.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag("home")

            ForEach(AnimalType.allCases, id: \.self) { type in
                CategoryView(type: type)
                    .tabItem {
                        Label(type.rawValue.capitalized, systemImage: type.icon)
                    }
                    .tag(type.rawValue)
            }
        }
        .environment(dataController)

        Button("Toggle Immersive Space") {
            if isImmersiveSpaceOpen {
                Task {
                    await dismissImmersiveSpace()
                }
            } else {
                Task {
                    await openImmersiveSpace(id: "Space")
                }
            }

            isImmersiveSpaceOpen.toggle()
        }
    }
}

#Preview {
    ContentView()
}
