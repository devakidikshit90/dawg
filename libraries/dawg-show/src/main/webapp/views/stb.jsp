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
<!--
The main page for viewing the stb metadata, trace, remote, and video.
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@page import="com.comcast.video.dawg.common.MetaStb"%>
<%@page import="com.comcast.video.stbio.Key"%>
<%@page import="com.comcast.video.dawg.show.ViewConstants"%>
<%@page import="com.comcast.video.dawg.show.key.Remote"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page isELIgnored="false" %>

<%
Remote remote = (Remote) request.getAttribute(ViewConstants.REMOTE);
Boolean mobile = (Boolean) request.getAttribute(ViewConstants.MOBILE);
MetaStb stb = (MetaStb) request.getAttribute(ViewConstants.STB_PARAM);
String remoteName = (String) request.getAttribute(ViewConstants.SELECTED_REMOTE_TYPE);
String traceHost = (String) request.getAttribute(ViewConstants.TRACE_HOST);
String videoUrl = (String) request.getAttribute(ViewConstants.VIDEO_URL);
String audioUrl = (String) request.getAttribute(ViewConstants.AUDIO_URL);
String videoCamera = (String) request.getAttribute(ViewConstants.VIDEO_CAMERA);
String hdVideoUrl = (String) request.getAttribute(ViewConstants.HD_VIDEO_URL);
boolean videoAvail = (Boolean) request.getAttribute(ViewConstants.VIDEO_AVAILABLE);
boolean traceAvail = (Boolean) request.getAttribute(ViewConstants.TRACE_AVAILABLE);
boolean irAvail = (Boolean) request.getAttribute(ViewConstants.IR_AVAILABLE);
String deviceId = (String) request.getAttribute(ViewConstants.DEVICE_ID);
boolean supported = (Boolean) request.getAttribute(ViewConstants.SUPPORTED);
String stdRemotePage = "/views/remotes/" + remote.getImageSubpath() + "/standard/standardremote.jsp";
String miniRemotePage = "/views/remotes/" + remote.getImageSubpath() + "/mini/miniremote.jsp";
String fullVideoUrl = "http://" + videoUrl + "/axis-cgi/mjpg/video.cgi"
+ (videoCamera != null ? "?camera=" + videoCamera : "");
String fullAudioUrlMP3Extension = "http://" + audioUrl + ":8080/play1.mp3";
String fullAudioUrlOGGExtension = "http://" + audioUrl + ":8080/play1.ogg";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="height:100%;width:100%;">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dawg Show</title>

        <link rel="stylesheet" type="text/css" href='<c:url value="/css/stb.css" />'>
        <link rel="stylesheet" type="text/css" href='<c:url value="/css/menu.css" />'>
        <link rel="stylesheet" type="text/css" href='<c:url value="/css/keymap.css" />'>
        <link rel="stylesheet" type="text/css" href='<c:url value="/css/trace.css" />'>

        <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.9.1.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/ui/1.10.2/jquery-ui.js" type="text/javascript"></script>

        <script type="text/javascript" src='<c:url value="/js/jquery.gracefulWebSocket.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/jquery.alphanum.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/image-util.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/RemoteSelector.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/Date.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/Logger.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/StandardRemote.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/keys.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/ComparisonPrompt.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/VideoSnapper.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/SingleLayoutManager.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/LayoutDelegator.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/LayoutUtil.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/TextOverlay.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/DropDownMenu.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/VideoRenderer.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/SerialManager.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/directTune.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/validateInput.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/power.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/jsmpg.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/FrameRateOperator.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/HoverManager.js" />'></script>

        <!-- Populate javascript variables. Will set the remote to the correct remote for this stb -->
       <jsp:include page="/views/globalVars.jsp" />
       <jsp:include page="/views/remoteTypeSelector.jsp" />
       <script type="text/javascript">
           var deviceId = '<%=deviceId %>';
       </script>

    </head>
    <body class="showBody" onresize="LayoutDelegator.draw()">

        <!-- prompt divs -->
        <div id="faded" class="promptFade"></div>
   

        <% if (!supported)  { %>
            <div id="notsupported">
                <jsp:include page="/views/bns-bar.jsp" />
            </div>
        <% } %>


        <div id="mainDiv" class="singleMainDiv">
            <!-- Video, metadata, trace div -->
            <div id="vmt" class="vmt">

                <!-- Video, metadata div -->
                <div id="vm" class="vm">
                    <div id="videoDiv" class="videoDiv">
                        <% if (hdVideoUrl != null) { %>
                            <canvas id="video" class="video" data-videourl="<%=hdVideoUrl%>"></canvas>
                        <% } else { %>
                            <img id="video" class="video"
                                            src="<%= fullVideoUrl%>"
                                            alt=""></img>
                            <audio id="audio" autoplay>
                            	<source src="<%=fullAudioUrlOGGExtension%>" type="audio/ogg">
  								<source src="<%=fullAudioUrlMP3Extension%>" type="audio/mpeg">
							</audio>
                            	
                            <% if (!videoAvail)  {%>
                                <canvas id="videoNotAvailableOverlay" class="videoNotAvailableOverlay"></canvas>
                            <% } %>
                        <% } %>
                    </div>
                </div>
            </div>
            <div id="standardRemoteDiv" class="standardRemoteDiv">
                <div id="remote" class="remoteContainer">
                    <jsp:include page="<%=stdRemotePage %>" />
                </div>
                <% if (!irAvail)  {%>
                    <canvas id="stdRemoteNotAvailableOverlay" class="stdRemoteNotAvailableOverlay"></canvas>
                <% } %>
            </div>
            <img id="mute" src='<c:url value="/images/remotes/xr2/keys/mute.png" />' onmousedown="clickRemoteButton(event,'MUTE', true)" onmouseup="clickRemoteButton(event,'MUTE', false)"  alt="" style="position:absolute"/>
            
        </div>
		
        <script type="text/javascript">

            
            var audio = document.getElementById('audio');

			document.getElementById('mute').addEventListener('click', function (e)
			{
			    e = e || window.event;
			    audio.muted = !audio.muted;
			    e.preventDefault();
			}, false);
            
        </script>
    </body>
</html>
