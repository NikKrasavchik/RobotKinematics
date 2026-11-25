import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GroupBox {
    id: root
    
    required property real xValue
    required property real yValue
    required property real zValue

    padding: 16

    background: Rectangle {
        color: "#FFFFFF"
        radius: 8

        border.color: "#DCE3EB"
    }

    ColumnLayout {
        anchors.fill: parent

        spacing: 12

        Label {
            text: "Координаты TCP"

            font.pixelSize: 17
            font.bold: true
        }

        RowLayout {
            Layout.fillWidth: true
            
            spacing: 12

            Repeater {
                model: [
                    {axis: "X", value: root.xValue},
                    {axis: "Y", value: root.yValue},
                    {axis: "Z", value: root.zValue}
                ]

                delegate: Rectangle {
                    required property var modelData

                    Layout.fillWidth: true
                    Layout.preferredWidth: 1

                    implicitHeight: 76

                    color: "#F1F5FA"
                    radius: 6

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 12

                        spacing: 4

                        Label {
                            text: modelData.axis + " (м)"

                            font.pixelSize: 13

                            color: "#64748B"
                        }

                        Label {
                            text: modelData.value.toFixed(6)

                            font.pixelSize: 22
                            font.weight: Font.Medium

                            color: "#315D91"
                        }
                    }
                }
            }
        }
    }
}