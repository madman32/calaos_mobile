/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import "."

Item {
    id: scrollBar

    property Flickable listObject

    y: orientation == Qt.Vertical ?listObject.y:listObject.y+listObject.height
    height: orientation == Qt.Vertical ?listObject.height: 5
    width: orientation == Qt.Vertical ?5:listObject.width
    anchors.right: orientation == Qt.Vertical ?parent.right:undefined
    anchors.top: orientation == Qt.Vertical ?undefined:listObject.bottom
    opacity: 1

    // The properties that define the scrollbar's state.
    // position and pageSize are in the range 0.0 - 1.0.  They are relative to the
    // height of the page, i.e. a pageSize of 0.5 means that you can see 50%
    // of the height of the view.
    // orientation can be either Qt.Vertical or Qt.Horizontal
    property real position: orientation == Qt.Vertical ?listObject.visibleArea.yPosition:listObject.visibleArea.xPosition
    property real pageSize: orientation == Qt.Vertical ?listObject.visibleArea.heightRatio:listObject.visibleArea.widthRatio
    property int orientation : Qt.Vertical

    // Size the bar to the required size, depending upon the orientation.
    Rectangle {
        x: orientation == Qt.Vertical ? 1 : (scrollBar.position * (scrollBar.width-2 * calaosApp.density) + 1 * calaosApp.density)
        y: orientation == Qt.Vertical ? (scrollBar.position * (scrollBar.height-2 * calaosApp.density) + 1 * calaosApp.density) : 1 * calaosApp.density
        width: orientation == Qt.Vertical ? (parent.width-2 * calaosApp.density) : (scrollBar.pageSize * (scrollBar.width-2 * calaosApp.density))
        height: orientation == Qt.Vertical ? (scrollBar.pageSize * (scrollBar.height-2 * calaosApp.density)) : (parent.height-2 * calaosApp.density)
        radius: orientation == Qt.Vertical ? (width/2 * calaosApp.density - 1 * calaosApp.density) : (height/2 * calaosApp.density - 1 * calaosApp.density)
        color: "#3ab4d7"
        opacity: listObject.visibleArea.heightRatio == 1?0:0.27
    }
}
