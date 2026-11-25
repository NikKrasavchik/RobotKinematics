import QtQuick
import QtQuick3D
 
Model {
    id: root
 
    required property vector3d startPoint
    required property vector3d endPoint
 
    property real diameter: 0.065
    property color linkColor: "#4779B5"
 
    readonly property vector3d linkVector:
        root.endPoint.minus(root.startPoint)
 
    readonly property real linkLength: Math.sqrt(
        root.linkVector.x * root.linkVector.x +
        root.linkVector.y * root.linkVector.y +
        root.linkVector.z * root.linkVector.z
    )
 
    source: "#Cylinder"
 
    visible: root.linkLength > 0.000001
 
    position: Qt.vector3d(
        (root.startPoint.x + root.endPoint.x) / 2,
        (root.startPoint.y + root.endPoint.y) / 2,
        (root.startPoint.z + root.endPoint.z) / 2
    )
 
    scale: Qt.vector3d(
        root.diameter / 100,
        root.linkLength / 100,
        root.diameter / 100
    )
 
    rotation: root.calculateRotation()
 
    materials: PrincipledMaterial {
        baseColor: root.linkColor
        metalness: 0.15
        roughness: 0.45
    }
 
    function calculateRotation() {
        if (root.linkLength < 0.000001)
            return Qt.quaternion(1, 0, 0, 0)
 
        const target = root.linkVector.normalized()
 
        const dot = Math.max(
            -1,
            Math.min(1, target.y)
        )
 
        if (dot > 0.999999)
            return Qt.quaternion(1, 0, 0, 0)
 
        if (dot < -0.999999)
            return Qt.quaternion(0, 1, 0, 0)
 
        const axis = Qt.vector3d(
            target.z,
            0,
            -target.x
        ).normalized()
 
        const halfAngle = Math.acos(dot) / 2
        const sinHalf = Math.sin(halfAngle)
 
        return Qt.quaternion(
            Math.cos(halfAngle),
            axis.x * sinHalf,
            axis.y * sinHalf,
            axis.z * sinHalf
        )
    }
}