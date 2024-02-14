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
            model.components.set(InputTargetComponent())
            model.generateCollisionShapes(recursive: false, static: true)
            //model.collision = CollisionComponent(shapes: [.generateSphere(radius: 0.25)])
            content.add(model)
        }
        .gesture(TapGesture()
            .targetedToAnyEntity()
            .onEnded { val in
                guard let modelEntity = val.entity as? ModelEntity else { return }
                let newMaterial = UnlitMaterial(color: .blue)
                modelEntity.model?.materials = [newMaterial]
            }
        )
        .gesture(DragGesture(minimumDistance: 0)
            .targetedToAnyEntity()
            .onChanged { val in
                guard let parent = val.entity.parent else { return }
                let newPosition = val.convert(val.location3D, from: .local, to: parent)
                val.entity.position = [newPosition.x, newPosition.y, val.entity.position.z]
            }
        )
    }
}

#Preview {
    ZoomedView(imageName: "Blue Whale")
}
