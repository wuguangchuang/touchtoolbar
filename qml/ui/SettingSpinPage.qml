import QtQuick 2.0
import QtQuick.Controls 1.4 as Cont1
import QtQuick.Controls 1.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

Item {
    property int  defaultSpacing: 10
    property int labelWidth:200

    property var xMirrorCheckBox:xMirrorCheckBox
    property var yMirrorCheckBox:yMirrorCheckBox
    property var touchRotationGroup:touchRotationGroup
    property var screenRotationGroup:screenRotationGroup


    ColumnLayout{
        RowLayout {
            spacing: defaultSpacing
            Image {
                id: turnOver;
                visible: true
                Layout.preferredHeight:parent.implicitHeight / 5.0 * 4
                Layout.preferredWidth: parent.implicitHeight  / 5.0 * 4
//                height: parent.implicitHeight / 5.0 * 4
//                width: parent.implicitHeight  / 5.0 * 4
                fillMode: Image.PreserveAspectFit
                source: "qrc:/dialog/images/touch_rotate.png";
            }
            Label {
                text: qsTr("turn over") + "(3)"
                Layout.preferredHeight:defaultSpacing
                Layout.preferredWidth: labelWidth
//                width: labelWidth
//                height: defaultSpacing
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            CheckBox {
                text: qsTr("turn over X")
                id: xMirrorCheckBox
                anchors.rightMargin: 10
                onCheckedChanged: {
                    if (refreshing) return;
                    touch.setSettings("xMirror", checked ? 1 : 0);
                }
            }
            CheckBox {
                id: yMirrorCheckBox
                text: qsTr("turn over Y")
                anchors.rightMargin: 10
                onCheckedChanged: {
                    if (refreshing) return;
                    touch.setSettings("yMirror", checked ? 1 : 0);
                }
            }

//            Button {
//                text: qsTr("factory reset")
//                onClicked: {
//                    var def = touch.resetXYOrientation();
//                    if (def & 0xff) {
//                        xMirrorCheckBox.checked = true;
//                    } else {
//                        xMirrorCheckBox.checked = false;
//                    }
//                    if (def & 0xff00) {
//                        yMirrorCheckBox.checked = true;
//                    } else {
//                        yMirrorCheckBox.checked = false;
//                    }
//                }
//            }
            MyButton{
                textStr: qsTr("factory reset")
                imageSource:"qrc:/dialog/images/restort_blue.png"
                onClicked: {
                    var def = touch.resetXYOrientation();
                    if (def & 0xff) {
                        xMirrorCheckBox.checked = true;
                    } else {
                        xMirrorCheckBox.checked = false;
                    }
                    if (def & 0xff00) {
                        yMirrorCheckBox.checked = true;
                    } else {
                        yMirrorCheckBox.checked = false;
                    }
                }
            }
        }
        ButtonGroup {
            id: touchRotationGroup
            onCheckedButtonChanged: {
                if (refreshing) return;
                console.log("触摸框旋转");
                touch.setSettings("touchRotation", checkedButton.mode);
            }
        }
        RowLayout {
            spacing: defaultSpacing
            Image {
                id: touchSpin;
                visible: true
                Layout.preferredHeight:parent.implicitHeight
                Layout.preferredWidth: parent.implicitHeight / 5.0 * 4
//                height: parent.implicitHeight
//                width: parent.implicitHeight / 5.0 * 4
                fillMode: Image.PreserveAspectFit
                source: "qrc:/dialog/images/touch_spin.png";
            }
            Label {
                text: qsTr("touch clockwise rotation") + "(4)"
                Layout.preferredHeight:defaultSpacing
                Layout.preferredWidth: labelWidth
//                width: labelWidth
//                height: defaultSpacing
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            RadioButton {
                property int mode: 0
                text: "0°"
                checked: true
                ButtonGroup.group: touchRotationGroup
                anchors.rightMargin: 10
            }
            RadioButton {
                property int mode: 1
                text: "90°"
                ButtonGroup.group: touchRotationGroup
                anchors.rightMargin: 10
            }
            RadioButton {
                property int mode: 2
                text: "180°"
                ButtonGroup.group: touchRotationGroup
                anchors.rightMargin: 10
            }
            RadioButton {
                property int mode: 3
                text: "270°"
                ButtonGroup.group: touchRotationGroup
                anchors.rightMargin: 10
            }

//            Button {
//                text: qsTr("factory reset")

//                onClicked: {
//                    var def = touch.resetTouchRotation();
//                    var btn;
//                    for (var i = 0; i < touchRotationGroup.buttons.length; i++) {
//                        btn = touchRotationGroup.buttons[i];
//                        if (btn.mode === def) {
//                            btn.checked = true;
//                        } else {
//                            btn.checked = false;
//                        }
//                    }

//                }
//            }
            MyButton{
                textStr: qsTr("factory reset")
                imageSource:"qrc:/dialog/images/restort_blue.png"
                onClicked: {
                    var def = touch.resetTouchRotation();
                    var btn;
                    for (var i = 0; i < touchRotationGroup.buttons.length; i++) {
                        btn = touchRotationGroup.buttons[i];
                        if (btn.mode === def) {
                            btn.checked = true;
                        } else {
                            btn.checked = false;
                        }
                    }
                }
            }
        }

        ButtonGroup {
            id: screenRotationGroup
            onCheckedButtonChanged: {
                if (refreshing) return;
                console.log("屏幕旋转")
                touch.setSettings("screenRotation", checkedButton.mode);
            }
        }
        RowLayout {
            spacing: defaultSpacing
            Image {
                id: screenSpin;
                visible: true
                Layout.preferredHeight:parent.implicitHeight / 5.0 * 4
                Layout.preferredWidth: parent.implicitHeight / 5.0 * 4
//                height: parent.implicitHeight / 5.0 * 4
//                width: parent.implicitHeight  / 5.0 * 4
                fillMode: Image.PreserveAspectFit
                source: "qrc:/dialog/images/screen_spin.png";
            }
            Label {
                text: qsTr("screen clockwise rotation") + "(5)"
                Layout.preferredHeight:defaultSpacing
                Layout.preferredWidth: labelWidth
//                width: labelWidth
//                height: defaultSpacing
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            RadioButton {
                property int mode: 0
                text: "0°"
                checked: true
                ButtonGroup.group: screenRotationGroup
                anchors.rightMargin: 10
            }
            RadioButton {
                property int mode: 1
                text: "90°"
                ButtonGroup.group: screenRotationGroup
                anchors.rightMargin: 10
            }
            RadioButton {
                property int mode: 2
                text: "180°"
                ButtonGroup.group: screenRotationGroup
                anchors.rightMargin: 10
            }
            RadioButton {
                property int mode: 3
                text: "270°"
                ButtonGroup.group: screenRotationGroup
                anchors.rightMargin: 10
            }
//            Button {
//                text: qsTr("factory reset")
//                onClicked: {
//                    var def = touch.resetScreenRotation();
//                    var btn;
//                    for (var i = 0; i < screenRotationGroup.buttons.length; i++) {
//                        btn = screenRotationGroup.buttons[i];
//                        if (btn.mode === def) {
//                            btn.checked = true;
//                        } else {
//                            btn.checked = false;
//                        }
//                    }

//                }
//            }
            MyButton{
                textStr: qsTr("factory reset")
                imageSource:"qrc:/dialog/images/restort_blue.png"
                onClicked: {
                    var def = touch.resetScreenRotation();
                    var btn;
                    for (var i = 0; i < screenRotationGroup.buttons.length; i++) {
                        btn = screenRotationGroup.buttons[i];
                        if (btn.mode === def) {
                            btn.checked = true;
                        } else {
                            btn.checked = false;
                        }
                    }
                }
            }
        }
    }

}
