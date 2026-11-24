import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
 
ApplicationWindow {
    id: root
 
    width: 800
    height: 650
 
    minimumWidth: 600
    minimumHeight: 580
 
    visible: true
 
    title: "Robot Kinematics"
    color: "#F1F4F8"
 
    palette.window: "#F1F4F8"
    palette.base: "#FFFFFF"
    palette.button: "#FFFFFF"
    palette.text: "#334155"
    palette.buttonText: "#334155"
    palette.windowText: "#334155"
    palette.highlight: "#4779B5"
    palette.highlightedText: "#FFFFFF"
 
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
 
        spacing: 16
 
        ColumnLayout {
            Layout.fillWidth: true
 
            spacing: 4
 
            Label {
                text: "Robot Kinematics"
 
                font.pixelSize: 26
                font.bold: true
 
                color: "#243247"
            }
 
            Label {
                text: "Forward kinematics"
 
                font.pixelSize: 13
 
                color: "#64748B"
            }
        }
 
        Frame {
            Layout.fillWidth: true
 
            padding: 16
 
            background: Rectangle {
                color: "#FFFFFF"
                radius: 8
 
                border.color: "#DCE3EB"
            }
 
            RowLayout {
                anchors.fill: parent
 
                spacing: 16
 
                Label {
                    text: "Robot model"
 
                    font.pixelSize: 15
                    font.weight: Font.Medium
                }
 
                Item {
                    Layout.fillWidth: true
                }
 
                ComboBox {
                    Layout.preferredWidth: 180
 
                    model: controller.modelNames
 
                    currentIndex: controller.currentModelIndex
 
                    onActivated: function(index) {
                        controller.selectModel(index)
                    }
                }
            }
        }
 
        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
 
            padding: 16
 
            background: Rectangle {
                color: "#FFFFFF"
                radius: 8
 
                border.color: "#DCE3EB"
            }
 
            ColumnLayout {
                anchors.fill: parent
 
                spacing: 8
 
                RowLayout {
                    Layout.fillWidth: true
 
                    Label {
                        text: "Joint angles"
 
                        font.pixelSize: 17
                        font.bold: true
                    }
 
                    Item {
                        Layout.fillWidth: true
                    }
 
                    Label {
                        text: "Degrees"
                        color: "#64748B"
                    }
                }
 
                Rectangle {
                    Layout.fillWidth: true
 
                    implicitHeight: 1
 
                    color: "#E2E8F0"
                }
 
                Repeater {
                    model: controller.jointAngles.length
 
                    delegate: JointControl {
                        required property int index
 
                        Layout.fillWidth: true
                        Layout.fillHeight: true
 
                        jointIndex: index
 
                        angle: controller.jointAngles[index]
 
                        onAngleEdited: function(newAngle) {
                            controller.setJointAngle(
                                index,
                                newAngle
                            )
                        }
                    }
                }
 
                Rectangle {
                    Layout.fillWidth: true
 
                    implicitHeight: 1
 
                    color: "#E2E8F0"
                }
 
                Button {
                    text: "Reset angles"
 
                    Layout.alignment: Qt.AlignRight
 
                    onClicked: controller.resetAngles()
                }
            }
        }
 
        TcpDisplay {
            Layout.fillWidth: true
 
            xValue: controller.tcpX
            yValue: controller.tcpY
            zValue: controller.tcpZ
        }
    }
}