import QtQuick 2.0

import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4



Item{

    property int defaultSpacing: 10
    property int labelSize: 25
    property var mSettings: []
    property var refreshing: true


    property bool updateSettings: false
//    signal clickCalibration();

    //坐标页面
    property var usbModeEnabledBox:settingCoordsPage.usbModeEnabledBox
    property var usbModeGroup:settingCoordsPage.usbModeGroup
    property var serialModeGroup:settingCoordsPage.serialModeGroup
    property var usbMode:settingCoordsPage.usbMode
    property var usbModeMouse:settingCoordsPage.usbModeMouse
    property var usbModeTouch:settingCoordsPage.usbModeTouch
    property var serialModeGG:settingCoordsPage.serialModeGG
    property var serialModeEnabledBox:settingCoordsPage.serialModeEnabledBox

    //旋转页面
    property var xMirrorCheckBox:settingSpinPage.xMirrorCheckBox
    property var yMirrorCheckBox:settingSpinPage.yMirrorCheckBox
    property var touchRotationGroup:settingSpinPage.touchRotationGroup
    property var screenRotationGroup:settingSpinPage.screenRotationGroup

    //校准界面
    property var calibrationList:settingCalibratePage.calibrationList
    property var calibrationButtonRow:settingCalibratePage.calibrationButtonRow
    property var caliDataModel: settingCalibratePage.caliDataModel


    id: root

    Keys.enabled: true
    Keys.onPressed: {

        switch (event.key)
        {
        case Qt.Key_1:
            if (usbModeEnabledBox.checked) {
                if (usbModeMouse.checked) {
                    usbModeMouse.checked = false;
                    usbModeTouch.checked = true;
                } else {
                    usbModeMouse.checked = true;
                    usbModeTouch.checked = false;
                    usbModeEnabledBox.checked = false;
                }
            } else {
                usbModeEnabledBox.checked = true;
            }

            break;

        case Qt.Key_2:
            serialModeEnabledBox.checked = !serialModeEnabledBox.checked;

            break;

        case Qt.Key_3:
            if (!xMirrorCheckBox.checked && !yMirrorCheckBox.checked) {
                xMirrorCheckBox.checked = true;
            } else if (xMirrorCheckBox.checked && !yMirrorCheckBox.checked) {
                yMirrorCheckBox.checked = true;
            } else if (xMirrorCheckBox.checked && yMirrorCheckBox.checked) {
                xMirrorCheckBox.checked = false;
            } else {
                xMirrorCheckBox.checked = yMirrorCheckBox.checked = false;
            }

            break;
        case Qt.Key_4:

            var count = touchRotationGroup.buttons.length;
            var button = touchRotationGroup.checkedButton;
//            console.log("count=" + count + " mode=" + button.mode);
            button.checked = false;
            var nextMode = button.mode + 1;
            if (button.mode === (count - 1)) {
                nextMode = 0;
            }
            for (var index = 0; index < count; index++) {
                if (nextMode === touchRotationGroup.buttons[index].mode) {
                    touchRotationGroup.buttons[index].checked = true;
                    break;
                }
            }

            break;
        case Qt.Key_5:
            count = screenRotationGroup.buttons.length;
            button = screenRotationGroup.checkedButton;
//            console.log("count=" + count + " mode=" + button.mode);
            button.checked = false;
            nextMode = button.mode + 1;
            if (button.mode === (count - 1)) {
                nextMode = 0;
            }
            for (var index = 0; index < count; index++) {
                if (nextMode === screenRotationGroup.buttons[index].mode) {
                    screenRotationGroup.buttons[index].checked = true;
                    break;
                }
            }

            break;
//        case Qt.Key_6:
//            count = macOsGroup.buttons.length;
//            button = macOsGroup.checkedButton;
////            console.log("count=" + count + " mode=" + button.mode);
//            button.checked = false;
//            nextMode = button.mode + 1;
//            if (button.mode === (count - 1)) {
//                nextMode = 0;
//            }
//            for (var index = 0; index < count; index++) {
//                if (nextMode === macOsGroup.buttons[index].mode) {
//                    macOsGroup.buttons[index].checked = true;
//                    break;
//                }
//            }

//            break;

        }
    }

    function refreshSettings() {
        console.log("refresh settings")
        refreshing = true;
        var settings = touch.getSettingsInfos();
        var enables = true;
        var buttons;
        var btn;
        if (settings.usbMode !== undefined && settings.usbMode !== -1) {
            for (var i = 0; i < usbModeGroup.buttons.length; i++) {
                btn = usbModeGroup.buttons[i];
                if (btn.mode === settings.usbMode) {
                    btn.checked = true;
                    break;
                }
            }
            enables = true;
        } else {
            enables = false;
        }

        buttons = usbModeGroup.buttons;
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].enabled = enables;
            if (enables === false) {
                buttons[i].checked = false;
            }
        }

        enables = true;
        if (settings.serialMode !== undefined && settings.serialMode !== -1) {
            for (var i = 0; i < serialModeGroup.buttons.length; i++) {
                btn = serialModeGroup.buttons[i];
                if (btn.mode === settings.serialMode) {
                    btn.checked = true;
                    break;
                }
            }
            enables = true;
        } else {
            enables = false;
        }

        buttons = serialModeGroup.buttons;
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].enabled = enables;
            if (enables === false) {
                buttons[i].checked = enables;
            }
        }

        enables = false;
        if (settings.touchRotation !== undefined && settings.touchRotation !== -1) {
            for (var i = 0; i < touchRotationGroup.buttons.length; i++) {
                btn = touchRotationGroup.buttons[i];
                if (btn.mode === settings.touchRotation) {
                    btn.checked = true;
                    break;
                }
            }
            enables = true;
        } else {
            enables = false;
        }
        buttons = touchRotationGroup.buttons;
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].enabled = enables;
            if (enables === false) {
                buttons[i].checked = enables;
            }
        }

        if (settings.screenRotation !== undefined && settings.screenRotation !== -1) {
            for (var i = 0; i < screenRotationGroup.buttons.length; i++) {
                btn = screenRotationGroup.buttons[i];
                if (btn.mode === settings.screenRotation) {
                    btn.checked = true;
                    break;
                }
            }
            enables = true;
        } else {
            enables = false;
        }
        buttons = screenRotationGroup.buttons;
        for (var i = 0; i < buttons.length; i++) {
            buttons[i].enabled = enables;
            if (enables === false) {
                buttons[i].checked = enables;
            }
        }

        if (settings.xMirror !== undefined && settings.xMirror !== -1) {
            xMirrorCheckBox.checked = settings.xMirror === 1;
            xMirrorCheckBox.enabled = true;
        } else {
            xMirrorCheckBox.enabled = false;
        }

        if (settings.yMirror !== undefined && settings.yMirror !== -1) {
            yMirrorCheckBox.checked = settings.yMirror === 1;
            yMirrorCheckBox.enabled = true;
        } else {
            yMirrorCheckBox.enabled = false;
        }

        enables = true;
//        if (settings.mac !== undefined && settings.mac !== -1) {
//            var mac

//            for (var i = 0; i < macOsGroup.buttons.length; i++) {
//                mac = macOsGroup.buttons[i];
//                if (mac.mode === settings.mac) {
//                    mac.checked = true;
//                    break;
//                }
//            }
//        } else {
//            enables = false;
//        }
//        buttons = macOsGroup.buttons;
//        for (var i = 0; i < buttons.length; i++) {
//            buttons[i].enabled = enables;
//            if (enables === false) {
//                buttons[i].checked = enables;
//            }
//        }

        mSettings = settings;
        refreshing = false;
        var connected = touch.isDeviceConnected();
        calibrationButtonRow.enabled = connected;
        calibrationList.enabled = connected;
        if (connected) {
            refreshCalibrationData();

            usbModeEnabledBox.enabled = true;
            serialModeEnabledBox.enabled = true;
//            console.log('usb === ' + settings.usbEnabled);
//            console.log('serial === ' + settings.serialEnabled);
            usbModeEnabledBox.checked = serialModeEnabledBox.checked = true;
            usbModeEnabledBox.checked = settings.usbEnabled === 1;
            serialModeEnabledBox.checked = settings.serialEnabled === 1;
        } else {
            usbModeEnabledBox.enabled = false;
            serialModeEnabledBox.enabled = false;
        }

//        var lockAGC = settings.lockAGC;
//        updateSettings = true;
//        lockAGCcb.checked = lockAGC === 1;
//        clearUpdate.restart()
    }
    Timer{
        id: clearUpdate
        interval: 200
        running: false
        triggeredOnStart: false
        onTriggered: {
            updateSettings = false;
        }
    }

//    id:rootSetting
    property int defaultTopMargin:5
    property int listBtnheight:60
    anchors.top: parent.top
    anchors.topMargin: defaultTopMargin
    SwipeView{
        id: swipeView
        anchors.left: rootitem.right
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        currentIndex: 0
        Rectangle{

            gradient: Gradient{
                GradientStop{position: 0.0;color: "#f6f6f6"}
                GradientStop{position: 1.0;color: "#e3ddf9"}
            }
            SettingCoordsPage{
                id:settingCoordsPage
                anchors.top: parent.top
                anchors.topMargin: 2 * defaultMargin
                anchors.left: parent.left
                anchors.leftMargin: 3 * defaultMargin
            }
        }
        Rectangle{

            gradient: Gradient{
                GradientStop{position: 0.0;color: "#f6f6f6"}
                GradientStop{position: 1.0;color: "#e3ddf9"}
            }
            SettingSpinPage{
                id:settingSpinPage
                anchors.top: parent.top
                anchors.topMargin: 2 * defaultMargin
                anchors.left: parent.left
                anchors.leftMargin: 3 * defaultMargin

            }

        }
        Rectangle{

            gradient: Gradient{
                GradientStop{position: 0.0;color: "#f6f6f6"}
                GradientStop{position: 1.0;color: "#e3ddf9"}
            }
            SettingCalibratePage{
                id:settingCalibratePage
                anchors.top: parent.top
                anchors.topMargin: 2 * defaultMargin
                anchors.left: parent.left
                anchors.leftMargin: 3 * defaultMargin
                onClickCalibration: {
                    mainPage.enterCalibrate();
                }
                Component.onCompleted: {
                    settingCalibratePage.caliDataModel = calibrationDataModel;
                }
            }

        }
        onCurrentIndexChanged: {
            checkBtn = currentIndex;
        }

    }
    //左侧列表
    property int checkBtn:0
    Rectangle
    {
        id : rootitem
        anchors.left: parent.left

        anchors.top: parent.top

        width: 150
        height: parent.height;
        color: "#dedaef"
        ColumnLayout{
            id : lyout
            width: parent.width
            Layout.fillWidth: true

            SettingMyToolButton{
                id:coordsBtn
                width: parent.width
                Layout.preferredHeight: listBtnheight
                Layout.fillWidth: true
                what:0
                textStr:qsTr("Coordinate")
                onClicked: {
                    swipeView.currentIndex = 0;
                    checkBtn = 0;
                }

            }

            SettingMyToolButton{
                id:spinBtn
                width: parent.width
                Layout.preferredHeight: listBtnheight
                Layout.fillWidth: true
                what:1
                textStr:qsTr("Spin")
                onClicked: {
                    swipeView.currentIndex = 1;
                    checkBtn = 1;
                }

            }

            SettingMyToolButton{
                id:calibrationBtn
                width: parent.width
                Layout.preferredHeight: listBtnheight
                Layout.fillWidth: true
                what:2
                textStr:qsTr("Calibrate")
                onClicked: {
                    swipeView.currentIndex = 2;
                    checkBtn = 2;
                }
            }

        }

    }
}


