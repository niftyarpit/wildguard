//
//  CategoryStack.swift
//  WildGuard
//
//  Created by Paul Hudson on 27/01/2024.
//

import SwiftUI

struct CategoryStack: View {
    var type: AnimalType

    var body: some View {
        VStack {
            Image(systemName: type.icon)
                .resizable()
                .fontWeight(.light)
                .scaledToFit()
                .frame(height: 60)

            Text(type.rawValue.capitalized)
                .font(.title)

            Text(type.description)
                .multilineTextAlignment(.center)

            Spacer()
        }
        .padding()
        .foregroundStyle(.white)
        .background(type.background)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    CategoryStack(type: .earth)
}
