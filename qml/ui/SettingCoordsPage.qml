import QtQuick 2.0
import QtQuick.Controls 1.4 as Cont1
import QtQuick.Controls 1.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
Item {
    property int  defaultSpacing: 10
    property int labelWidth:200

    property var usbModeEnabledBox:usbModeEnabledBox
    property var usbModeGroup:usbModeGroup
    property var serialModeGroup:serialModeGroup
    property var usbMode:usbMode
    property var usbModeMouse:usbModeMouse
    property var usbModeTouch:usbModeTouch
    property var serialModeGG:serialModeGG
    property var serialModeEnabledBox:serialModeEnabledBox




    ColumnLayout{
        ButtonGroup {
            id: usbModeGroup
            onCheckedButtonChanged: {
                console.log("usb mode:"+checkedButton.mode)
                if (refreshing) return;
                touch.setSettings("usbMode", checkedButton.mode);
            }
        }
        RowLayout {
            spacing: defaultSpacing
            id: usbMode
            Image {
                id: usbIcon;
                visible: true
                Layout.preferredHeight: parent.implicitHeight / 5.0 * 4
                Layout.preferredWidth: parent.implicitHeight  / 5.0 * 4
//                height: parent.implicitHeight / 5.0 * 4
//                width: parent.implicitHeight  / 5.0 * 4
                fillMode: Image.PreserveAspectFit
                source: "qrc:/dialog/images/usb.png";
            }
            Label {
                id: labelView
                text: qsTr("usb coordinate mode") + "(1)"
                Layout.preferredHeight:parent.implicitHeight
                Layout.preferredWidth: labelWidth
//                height: parent.implicitHeight
//                width:labelWidth
                verticalAlignment: Text.AlignVCenter
    //            width: font.pointSize * labelSize
            }

            CheckBox {
                id: usbModeEnabledBox
                onClicked: {
    //                            touch.setCoordsEnabled(1, checked ? 1: 0);
                }

                onCheckedChanged: {
                    usbModeMouse.enabled = checked;
                    usbModeTouch.enabled = ((winVersion === undefined || winVersion !== winXPVersion) ? checked : false)
                    var str = checked?"设置 checked = true":"设置 checked = false";
                    touch.tPrintf(str);
                    touch.setCoordsEnabled(1, checked ? 1: 0);
                }
            }

            RadioButton {
                id: usbModeMouse
                text: qsTr("simulate mouse")
                ButtonGroup.group: usbModeGroup
                property int mode: 1
            }
            RadioButton {
                id: usbModeTouch
                property int mode: 2
                text: qsTr("multitouch")
                ButtonGroup.group: usbModeGroup
                //enabled: ((winVersion === undefined || winVersion !== winXPVersion) ? true : false);
            }
        }
        ButtonGroup {
            id: serialModeGroup
            onCheckedButtonChanged: {
                console.log("serial mode:" + checkedButton.mode)
                if (refreshing) return;
                touch.setSettings("serialMode", checkedButton.mode);
            }
        }
        RowLayout {
            spacing: defaultSpacing
            id: serialModeGG
            anchors.top: usbMode.bottom
            anchors.topMargin: defaultSpacing
            Image {
                id: uartIcon;
                visible: true
                Layout.preferredHeight:parent.implicitHeight / 5.0 * 4
                Layout.preferredWidth: parent.implicitHeight  / 5.0 * 4
//                height: parent.implicitHeight / 5.0 * 4
//                width: parent.implicitHeight  / 5.0 * 4
                fillMode: Image.PreserveAspectFit
                source: "qrc:/dialog/images/serial.png";
            }
            Label {
                text: qsTr("uart coordinate mode") + "(2)"
                Layout.preferredHeight:parent.implicitHeight
                Layout.preferredWidth: labelWidth
//                height: parent.implicitHeight
//                width:labelWidth
                verticalAlignment: Text.AlignVCenter
            }


            CheckBox {
                id: serialModeEnabledBox
                onClicked: {

                }

                onCheckedChanged: {
                    var str = checked?"设置 checked = true":"设置 checked = false";
                    touch.setCoordsEnabled(2, checked ? 1: 0);
                }
            }
            RadioButton {
                visible: false
                text: qsTr("exclude touch size")
                ButtonGroup.group: serialModeGroup
                property int mode: 1
            }
            RadioButton {
                visible: false
                property int mode: 2
                text: qsTr("include touch size")
                checked: true
                ButtonGroup.group: serialModeGroup
            }
        }
    }


}
