import QtQuick
import QtQuick3D

Node {
    id: root

    property real axisLingth: 0.15
    property real axisDiameter: 0.012

    RobotJoint {
        diameter: 0.045
        jointColor: "#D65C5C"
    }

    RobotLink {
        startPoint: Qt.vector3d(0, 0, 0)
        endPoint: Qt.vector3d(0, root.axisLingth, 0)

        diameter: root.axisDiameter
        linkColor: "#44965C"
    }

    RobotLink {
        startPoint: Qt.vector3d(0, 0, 0)
        endPoint: Qt.vector3d(0, 0, root.axisLingth)

        diameter: root.axisDiameter
        linkColor: "#4779B5"
    }
}