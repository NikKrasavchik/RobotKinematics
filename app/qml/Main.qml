import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: robot_app

    width: 800
    height: 600

    minimumWidth: 500
    minimumHeight: 500

    visible: true
    title: "Robot Kinematics"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24

        Label {
            text: "Robot model"
            font.pixelSize: 20
            font.bold: true
        }

        ComboBox {
            Layout.fillWidth: true

            model: controller.modelNames

            currentIndex: controller.currentModelIndex

            onActivated: function(index) {
                controller.selectModel(index)
            }
        }

        Label {
            text: "Joint angles"
            font.pixelSize: 20
            font.bold: true
        }

        Repeater {
            model: controller.jointAngles.length

            delegate: RowLayout {
                id: jointRow

                required property int index

                Layout.fillWidth: true
                Layout.minimumHeight: 40

                spacing: 12

                Label {
                    text: "Joint " + jointRow.index
                    Layout.preferredWidth: 60
                }

                Slider {
                    id: angleSlider

                    Layout.fillWidth: true
                    Layout.minimumWidth: 150
                    Layout.preferredHeight: 40

                    from: -180
                    to: 180
                    stepSize: 1

                    value: controller.jointAngles[jointRow.index]

                    onMoved: {
                        controller.setJointAngle(jointRow.index, angleSlider.value)
                    }
                }

                Label {
                    text: Number(controller.jointAngles[index]).toFixed(1) + "°"

                    Layout.preferredWidth: 80

                    horizontalAlignment: Text.AlignRight
                }
            }
        }

        Button {
            text: "Reset angles"
            Layout.fillWidth: true

            onClicked: controller.resetAngles()
        }

        Item {
            Layout.fillHeight: true
        }

        Label {
            text: "TCP coordinates"
            font.pixelSize: 20
            font.bold: true
        }

        GridLayout {
            columns: 2

            columnSpacing: 24
            rowSpacing: 8

            Label {
                text: "X:"
            }

            Label {
                text: controller.tcpX.toFixed(6) + " m"
            }

            Label {
                text: "Y:"
            }

            Label {
                text: controller.tcpY.toFixed(6) + " m"
            }

            Label {
                text: "Z:"
            }

            Label {
                text: controller.tcpZ.toFixed(6) + " m"
            }
        }
    }
}