/**
 * Copyright 2010 Comcast Cable Communications Management, LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.comcast.video.stbio.meta;

/**
 * Meta data necessary to access the video of a set top box
 * @author Kevin Pearson
 *
 */
public interface VideoMeta {
    /**
     * The url of the video service
     * @return
     */
    String getVideoSourceUrl();

    /**
     * The number used to identify which camera to use at {@link VideoMeta#getVideoUrl()}
     * @return
     */
    String getVideoCamera();
    
    /**
     * The url of the audio service
     * @return
     */
    String getAudioUrl();
}
