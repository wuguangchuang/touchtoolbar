import QtQuick 2.0

import QtQuick.Controls.Styles 1.4
ButtonStyle{
    Item {
        id: info
        property int tHeight: 50
        property int borderWidth: 0
        property var text: "开始升级"
    }
    property alias text: info.text
    property alias height: info.tHeight
    property alias borderWidth: info.borderWidth

    label: Text {
        text: info.text
        color:"#FFFFFFFF"
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
    }
    property color backgroundColor: ((control.enabled == true) ? ((control.pressed == true) ? "#42A5F5" : "#64B5F6") : "#BDBDBD")
    background: Rectangle{

        implicitWidth: 100 
        implicitHeight: info.tHeight
        border.width: info.borderWidth
        color: backgroundColor
        radius: 2
    }

}
