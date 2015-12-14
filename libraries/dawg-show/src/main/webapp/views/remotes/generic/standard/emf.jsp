<%--

    Copyright 2010 Comcast Cable Communications Management, LLC

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>
<%--Enter, Mute, Fav keys of generic remote --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="width:100%;height:100%">
    <div>
        <table class="genericRemoteKeyTable">
            <tbody>
                <tr class="genericRemoteKeyRow">
                    <td class="genericRemoteButtonStyle genericRemoteKeyCol">
                        <a id="senter" onmousedown="clickRemoteButton(event,'ENTER', true)" onmouseup="clickRemoteButton(event,'ENTER', false)">ENTER</a>
                    </td>
                    <td class="genericRemoteButtonStyle genericRemoteKeyCol">
                        <a id="smute" onmousedown="clickRemoteButton(event,'MUTE', true)" onmouseup="clickRemoteButton(event,'MUTE', false)"> MUTE</a>
                    </td>
                    <td class="genericRemoteButtonStyle genericRemoteKeyCol">
                        <a id="sfav" onmousedown="clickRemoteButton(event,'FAV', true)" onmouseup="clickRemoteButton(event,'FAV', false)">FAV</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</html>
