import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQml 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Button {
    property string textStr:""
    property string imageSource:""
    property int clickBtn:1
    id:rootBtn
//    width: 150
//    height: 40
    Layout.preferredWidth: 150
    Layout.preferredHeight: 40

    contentItem: Item{
        RowLayout{
            id:btnRect
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            Image {
                id: btnIcon
                visible: true
//                height: rootBtn.height / 5.0 * 4
                Layout.preferredHeight: rootBtn.height / 5.0 * 4
                Layout.preferredWidth: rootBtn.height / 5.0 * 4
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                source: imageSource

            }

            Text{
                id:btnText
                text:textStr
                anchors.left: btnIcon.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }

        }



    }
}
