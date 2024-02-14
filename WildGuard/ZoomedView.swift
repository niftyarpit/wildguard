//
//  ZoomedView.swift
//  WildGuard
//
//  Created by Arpit Srivastava on 14/02/24.
//

import SwiftUI
import RealityKit

struct ZoomedView: View {

    let imageName: String

    var body: some View {
        RealityView { content in
            let shape = MeshResource.generateBox(size: 0.25)
            let material = SimpleMaterial(color: .red, isMetallic: true)
            let model = ModelEntity(mesh: shape, materials: [material])
            model.components.set(GroundingShadowComponent(castsShadow: true))
            content.add(model)
        }
    }
}

#Preview {
    ZoomedView(imageName: "Blue Whale")
}
