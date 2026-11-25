import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D

Frame {
    id: root

    required property var framePositions
    required property var frameRotations

    padding: 16

    background: Rectangle {
        color: "#FFFFFF"
        radius: 8

        border.color: "#DCE3EB"
    }

    ColumnLayout {
        anchors.fill: parent

        spacing: 12

        RowLayout {
            Layout.fillWidth: true

            Label {
                text: "Визуализация"

                font.pixelSize: 17
                font.bold: true
            }

            Item {
                Layout.fillWidth: true
            }

            Button {
                text: "Камера по-умолчанию"

                onClicked: {
                    cameraPivot.eulerRotation = Qt.vector3d(-25, 35, 0)
                    camera.z = 420
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.minimumHeight: 300

            color: "#E8EDF3"
            radius: 6

            clip: true

            View3D {
                id: view
                anchors.fill: parent

                camera: camera

                environment: SceneEnvironment {
                    backgroundMode: SceneEnvironment.Color

                    clearColor: "#E8EDF3"

                    antialiasingMode: SceneEnvironment.MSAA
                    antialiasingQuality: SceneEnvironment.High
                }

                Node {
                    id: cameraPivot

                    eulerRotation: Qt.vector3d(-25, 35, 0)

                    PerspectiveCamera {
                        id: camera

                        z: 420

                        clipNear: 1
                        clipFar: 2000
                    }
                }

                DirectionalLight {
                    eulerRotation: Qt.vector3d(-45, -35, 0)

                    brightness: 1.2

                    ambientColor: "#707070"
                }

                DirectionalLight {
                    eulerRotation: Qt.vector3d(-30, 140, 0)

                    brightness: 0.5
                }

                Model {
                    source: "#Cube"

                    position: Qt.vector3d(0, -2, 0)
                    scale: Qt.vector3d(4, 0.02, 4)

                    materials: PrincipledMaterial {
                        baseColor: "#D5DDE7"
                        roughness: 0.9
                    }

                    opacity: 0.25
                }

                Node {
                    id: robotSpace

                    eulerRotation.x: -90

                    scale: Qt.vector3d(100, 100, 100)

                    Model { // X
                        source: "#Cube"

                        position: Qt.vector3d(0.25, 0, 0)

                        scale: Qt.vector3d(0.005, 0.00015, 0.00015)

                        materials: PrincipledMaterial {
                            baseColor: "#D65C5C"
                        }
                    }

                    Model { // Y
                        source: "#Cube"

                        position: Qt.vector3d(0, 0.25, 0)

                        scale: Qt.vector3d(0.00015, 0.005, 0.00015)

                        materials: PrincipledMaterial {
                            baseColor: "#44965C"
                        }
                    }

                    Model { // Z
                        source: "#Cube"

                        position: Qt.vector3d(0, 0, 0.25)

                        scale: Qt.vector3d(0.00015, 0.00015, 0.005)

                        materials: PrincipledMaterial {
                            baseColor: "#4779B5"
                        }
                    }

                    Model {
                        source: "#Cylinder"
                        
                        position: Qt.vector3d(0, 0, 0.025)

                        eulerRotation.x: 90

                        scale: Qt.vector3d(0.0023, 0.0005, 0.0024)

                        materials: PrincipledMaterial {
                            baseColor: "#475569"
                            metalness: 0.2
                            roughness: 0.6
                        }
                    }

                    Repeater3D {
                        model: Math.max(0, root.framePositions.length - 1)

                        delegate: RobotLink {
                            required property int index
                            
                            startPoint: root.framePositions[index]
                            endPoint: root.framePositions[index + 1]

                            diameter: 0.065
                        }
                    }

                    Repeater3D {
                        model: Math.max(0, root.framePositions.length - 1)

                        delegate: RobotJoint {
                            required property int index

                            position: root.framePositions[index]

                            diameter: 0.1
                        }
                    }

                    RobotTcp {
                        visible: root.framePositions.length > 0 && root.frameRotations.length > 0

                        position: root.framePositions.length > 0
                            ? root.framePositions[root.framePositions.length - 1]
                            : Qt.vector3d(0, 0, 0)

                        rotation: root.frameRotations.length > 0
                            ? root.frameRotations[root.frameRotations.length - 1]
                            : Qt.quaternion(1, 0, 0, 0)
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                
                acceptedButtons: Qt.LeftButton

                property real lastX: 0
                property real lastY: 0

                onPressed: function(mouse) {
                    lastX = mouse.x
                    lastY = mouse.y
                }

                onPositionChanged: function(mouse) {
                    if (!pressed)
                        return

                    const dx = mouse.x - lastX
                    const dy = mouse.y - lastY

                    const pitchMax = Math.min(85, cameraPivot.eulerRotation.x - dy * 0.4)
                    const pitch = Math.max(-85, pitchMax)

                    cameraPivot.eulerRotation = Qt.vector3d(pitch, cameraPivot.eulerRotation.y - dx * 0.4, 0)

                    lastX = mouse.x
                    lastY = mouse.y
                }

                onWheel: function(wheel) {
                    const zMin = Math.min(1000, camera.z - wheel.angleDelta.y * 0.2)
                    camera.z = Math.max(80, zMin)

                    wheel.accepted = true
                }
           }
        }
    }
}