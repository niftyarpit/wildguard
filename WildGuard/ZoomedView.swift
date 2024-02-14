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
            let shape = MeshResource.generateSphere(radius: 0.25)
            guard let texture = try? await TextureResource(named: "Earth") else { return }
            var material = UnlitMaterial()
            material.color = .init(texture: .init(texture))
            //let material = UnlitMaterial(color: .red, applyPostProcessToneMap: false)
            let model = ModelEntity(mesh: shape, materials: [material])
            model.components.set(GroundingShadowComponent(castsShadow: true))
            content.add(model)
        }
    }
}

#Preview {
    ZoomedView(imageName: "Blue Whale")
}
