import QtQuick 2.0
import QtQuick.Controls 1.4 as Cont1
import QtQuick.Controls 1.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
Item {
    property int  defaultSpacing: 10
    property int labelWidth:200
    signal clickCalibration();

    property var caliDataModel: null

    property var calibrationList:calibrationList
    property var caliDataDelegate: calibrationDataDelegate
    property var calibrationButtonRow:calibrationButtonRow
    property var  refreshBtn:refreshBtn

    ColumnLayout{
        RowLayout {
            id: calibrationButtonRow
            spacing: 10

            MyButton{
                id:calibrationStartBtn
                textStr: qsTr("calibration")
                imageSource:"qrc:/dialog/images/calibrate_blue.png"
                clickBtn: 1
                onClicked: {
                    clickCalibration();
                }
            }
            MyButton{
                id:refreshBtn
                textStr: qsTr("refresh")
                imageSource:"qrc:/dialog/images/refresh_blue.png"
                clickBtn: 2
                onClicked: {
                    refreshCalibrationData();
                }
            }

            MyButton{
                id:setBtn
                textStr: qsTr("set")
                imageSource:"qrc:/dialog/images/setting_blue.png"
                clickBtn: 3
                onClicked: {
                    showProgessing();
                    touch.setCalibrationDatas(createCalibrationData());
                    hideProgessing();var result = touch.saveCalibration();
                    if (result === false) {
                        showToast(qsTr("save data failure"));
                    } else {
                        showToast(qsTr("set success"));
                    }
                }
            }

            MyButton{
                id:saveBtn
                textStr: qsTr("save")
                imageSource:"qrc:/dialog/images/save_blue.png"
                clickBtn: 4
                onClicked: {
                    calibrationfileDialog.mode = 1;
                    focus = true;
                    calibrationfileDialog.open();
                }
            }

            MyButton{
                id:readBtn
                textStr: qsTr("read")
                imageSource:"qrc:/dialog/images/read_blue.png"
                clickBtn: 5
                onClicked: {
                    calibrationfileDialog.mode = 0;
                    focus = true;
                    calibrationfileDialog.open();
                }
            }

            MyButton{
                id:hidBtn
                textStr: calibrationList.visible === true ? qsTr("hide datas") : qsTr("show datas")
                imageSource:calibrationList.visible === true ? "qrc:/dialog/images/hide_blue.png" : "qrc:/dialog/images/show_blue.png"
                clickBtn: 6
                onClicked: {
                    calibrationList.visible = !calibrationList.visible;
                    resetCalibrationData();
                }
            }
            MyButton{

                textStr: qsTr("factory reset")
                imageSource: "qrc:/dialog/images/restort_blue.png"
                clickBtn: 7
                onClicked: {
                    showProgessing();
                    resetCalibrationData();
                    touch.saveCalibration();
                    hideProgessing();
                }
            }

//            Button {
//                text: qsTr("factory reset")
//                onClicked: {
//                    showProgessing();
//                    resetCalibrationData();
//                    touch.saveCalibration();
//                    hideProgessing();
//                }
//            }
        }

        ListView {
            id: calibrationList
        //                    anchors.top: calibrationButtonRow.bottom
        //                    anchors.topMargin: 10
            anchors.left: parent.left
//            anchors.leftMargin: labelView.width + 10
            Layout.preferredHeight: 260
            Layout.preferredWidth: parent.width
//            width: parent.width
//            height: 260
            spacing: 15
            visible: true

            header: RowLayout {
                Layout.preferredHeight:50
                Layout.preferredWidth: parent.width

                spacing: 15

                Label {
                    topPadding: 10
                    bottomPadding: 15
                    text: qsTr("Number")
                    horizontalAlignment: Text.left
                    Layout.preferredWidth:calibrationTextWidth

                }
                Label {
                    topPadding: 10
                    bottomPadding: 15
                    text: qsTr("target point %1").arg("X")
                    horizontalAlignment: Text.Center
//                    width: calibrationTextWidth
                    Layout.preferredWidth:calibrationTextWidth

                }
                Label {
                    topPadding: 10
                    bottomPadding: 15
                    text: qsTr("target point %1").arg("Y")
                    horizontalAlignment: Text.Center
//                    width: calibrationTextWidth
                    Layout.preferredWidth:calibrationTextWidth

                }
                Label {
                    topPadding: 10
                    bottomPadding: 15
                    text: qsTr("collect point %1").arg("X")
                    horizontalAlignment: Text.Center
//                    width: calibrationTextWidth
                    Layout.preferredWidth:calibrationTextWidth

                }
                Label {
                    topPadding: 10
                    bottomPadding: 15
                    text: qsTr("collect point %1").arg("Y")
                    horizontalAlignment: Text.Center
//                    width: calibrationTextWidth
                    Layout.preferredWidth:calibrationTextWidth

                }
            }

            delegate: caliDataDelegate
            model: caliDataModel
        }
    }
    property real calibrationLabelWidth: 50
    property real calibrationTextWidth: 130
    Component {
        id: calibrationDataDelegate
        RowLayout {
            spacing: 15

            Label {
                text: "" + index
                Layout.preferredHeight:parent.implicitHeight
                Layout.preferredWidth: calibrationTextWidth
//                height: parent.implicitHeight
//                width: calibrationTextWidth
                font.pixelSize: height
                horizontalAlignment: Text.left
                verticalAlignment: Text.Center
            }

            CaliTextEdit {

                Layout.preferredWidth: calibrationTextWidth
//                width: calibrationTextWidth
                maxValue: maxX
                onTextChanged: targetX = text;
                value: targetX
            }
            CaliTextEdit {
                Layout.preferredWidth: calibrationTextWidth
//                width: calibrationTextWidth
                maxValue: maxY
                onTextChanged: targetY = text;
                value: targetY
            }
            CaliTextEdit {
                Layout.preferredWidth: calibrationTextWidth
//                width: calibrationTextWidth
                maxValue: maxX
                onTextChanged: collectX = text;
                value: collectX

            }
            CaliTextEdit {
                Layout.preferredWidth: calibrationTextWidth
//                width: calibrationTextWidth
                maxValue: maxY
                onTextChanged: {
                    collectY = text;
                }
                value: collectY

            }



        }
    }

}
