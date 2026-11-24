import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: root

    required property int jointIndex
    required property real angle

    property real minimumAngle: -180
    property real maximumAngle: 180

    signal angleEdited(real newAngle)

    spacing: 12

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 36

    Label {
        text: "Joint " + root.jointIndex

        Layout.preferredWidth: 60

        font.pixelSize: 14
        font.weight: Font.Medium
        color: "#475569"
    }

    Slider {
        Layout.fillWidth: true

        from: root.minimumAngle
        to: root.maximumAngle

        stepSize: 0.1

        value: root.angle

        onMoved: {
            root.angleEdited(value)
        }
    }

    TextField {
        id: angleField

        Layout.preferredWidth: 90

        text: root.angle.toFixed(2)

        horizontalAlignment: Text.AlignRight

        selectByMouse: true

        validator: DoubleValidator {
            bottom: root.minimumAngle
            top: root.maximumAngle
            decimals: 2

            notation: DoubleValidator.StandardNotation
            locale: "C"
        }

        onEditingFinished: {
            if (acceptableInput) {
                root.angleEdited(Number(text))
            }

            text = Qt.binding(function() {
                return root.angle.toFixed(2)
            })
        }
    }

    Label {
        text: "°"
    }
}