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
        RealityView { content, attachments in
            let shape = MeshResource.generateSphere(radius: 0.25)
            guard let texture = try? await TextureResource(named: "Earth") else { return }
            var material = UnlitMaterial()
            material.color = .init(texture: .init(texture))
            let model = ModelEntity(mesh: shape, materials: [material])
            model.components.set(GroundingShadowComponent(castsShadow: true))
            model.components.set(InputTargetComponent())
            model.generateCollisionShapes(recursive: false, static: true)
            content.add(model)

            let pitch = Transform(pitch: Float(animal.mapRotationX * -1)).matrix
            let yaw = Transform(yaw: Float(animal.mapRotationY)).matrix
            model.transform.matrix = pitch * yaw

            if let entity = attachments.entity(for: "name") {
                entity.position = [0, -0.3, 0]
                content.add(entity)
            }
        } update: { content, attachments in

            guard let entity = content.entities.first else { return }
            let pitch = Transform(pitch: Float((animal.mapRotationX + spinX) * -1)).matrix
            let yaw = Transform(yaw: Float(animal.mapRotationY + spinY)).matrix
            entity.transform.matrix = pitch * yaw

        } attachments: {
            Attachment(id: "name") {
                Text("Location of \(animal.englishName)")
                    .font(.extraLargeTitle)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
            .targetedToAnyEntity()
            .onChanged { val in
                let startLocation = val.convert(val.startLocation3D, from: .local, to: .scene)
                let currentLocation = val.convert(val.location3D, from: .local, to: .scene)
                let delta = currentLocation - startLocation
                spinX = Double(delta.y) * 5
                spinY = Double(delta.x) * 5
            }
        )
//        .gesture(
//            TapGesture()
//            .targetedToAnyEntity()
//            .onEnded { value in
//                var transform = value.entity.transform
//                transform.translation += [0.1, 0, 0]
//                value.entity.move(to: transform, relativeTo: value.entity, duration: 3, timingFunction: .easeInOut)
//            }
//        )
    }
}

#Preview {
    ZoomedView(animal: Animal.example)
}
