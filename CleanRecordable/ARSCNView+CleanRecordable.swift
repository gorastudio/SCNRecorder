//
//  ARSCNView+CleanRecordable.swift
//  SCNRecorder
//
//  Created by Vladislav Grigoryev on 25.05.2020.
//  SCNRecorder
//
//  Created by Vladislav Grigoryev on 25.05.2020.
//  Copyright © 2020 GORA Studio. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import ARKit

private var cleanRecorderKey: UInt8 = 0
private var cleanVideoRecordingKey: UInt8 = 0

extension ARSCNView: CleanRecordable {

  public var cleanRecorder: CleanRecorder? {
    get { objc_getAssociatedObject(self, &cleanRecorderKey) as? CleanRecorder }
    set {
      let oldRecorder = cleanRecorder
      objc_setAssociatedObject(self, &cleanRecorderKey, nil, .OBJC_ASSOCIATION_RETAIN)
      if delegate === oldRecorder { delegate = oldRecorder?.arSceneViewDelegate }

      guard let recorder = newValue else { return }
      recorder.sceneViewDelegate = delegate
      delegate = recorder
      objc_setAssociatedObject(self, &cleanRecorderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }

  public var cleanVideoRecording: VideoRecording? {
    get { objc_getAssociatedObject(self, &cleanVideoRecordingKey) as? VideoRecording }
    set { objc_setAssociatedObject(self, &cleanVideoRecordingKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
  }

  public var cleanPixelBuffer: CVPixelBuffer? { session.currentFrame?.capturedImage }
}
