//
//  ZoomedView.swift
//  WildGuard
//
//  Created by Arpit Srivastava on 14/02/24.
//

import SwiftUI
import RealityKit

struct ZoomedView: View {

    let animal: Animal

    @State private var spinX = 0.0
    @State private var spinY = 0.0

    var body: some View {
        RealityView { content in
            let shape = MeshResource.generateSphere(radius: 0.25)
            guard let texture = try? await TextureResource(named: "Earth") else { return }
            var material = UnlitMaterial()
            material.color = .init(texture: .init(texture))
            let model = ModelEntity(mesh: shape, materials: [material])
            model.components.set(GroundingShadowComponent(castsShadow: true))
            model.components.set(InputTargetComponent())
            model.generateCollisionShapes(recursive: false, static: true)
            content.add(model)
        }
        .rotation3DEffect(.radians(spinY), axis: .y)
        .gesture(DragGesture(minimumDistance: 0)
            .targetedToAnyEntity()
            .onChanged { val in
                let startLocation = val.convert(val.startLocation3D, from: .local, to: .scene)
                let currentLocation = val.convert(val.location3D, from: .local, to: .scene)
                let delta = currentLocation - startLocation
                spinX = Double(delta.y) * 5
                spinY = Double(delta.x) * 5
            }
        )
        .onAppear {
            spinX = animal.mapRotationX
            spinY = animal.mapRotationY
        }
    }
}

#Preview {
    ZoomedView(animal: Animal.example)
}
