import QtQuick
import QtQuick3D

Model {
    id: root

    property real diameter: 0.1
    property color jointColor: "#64748B"

    source: "#Sphere"

    scale: Qt.vector3d(diameter / 100, diameter / 100, diameter / 100)

    materials: PrincipledMaterial {
        baseColor: root.jointColor
        metalness: 0.2
        roughness: 0.4
    }
}