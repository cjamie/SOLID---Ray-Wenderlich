/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import AVKit
import Foundation

protocol MediaPlayer {
    func play()
    func pause()
    func stream() throws -> AVPlayerItem
}

//extension MediaPlayer  {
//    func hello()
//}

protocol Downloadable {
    func download() throws -> URLSessionDataTask
}

protocol Seekable {
    func seek(to time: Measurement<UnitDuration>) throws
}

class MP4: MediaPlayer, Downloadable {
    private let url: URL

    // MARK: - Init
    
    init(url: URL) {
        self.url = url
    }

    // MARK: - MediaPlayer
    
    func play() {
        // play the content
    }

    func pause() {
        // pause the content
    }

    func stream() -> AVPlayerItem {
        // set up the item to stream
        return AVPlayerItem(url: url)
    }

    // MARK: - Downloadable
    
    func download() -> URLSessionDataTask {
        // produce a task to download the content
        return URLSession.shared.dataTask(with: url)
    }

}

class HLS: MediaPlayer, Seekable {
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    func play() {
        // play the content
    }

    func pause() {
        // pause the content
    }

    func seek(to _: Measurement<UnitDuration>) {
        // seek to a specific part of the stream
    }

    func stream() -> AVPlayerItem {
        // set up the item to stream
        return AVPlayerItem(url: url)
    }
}
