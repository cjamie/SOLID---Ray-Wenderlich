
import AVKit
import Foundation

struct NotSupported: Error {
    private let line: UInt = #line
}

protocol MediaPlayer {
    func play()
    func pause()
    func seek(to time: Measurement<UnitDuration>) throws
    func download() throws -> URLSessionDataTask
    func stream() throws -> AVPlayerItem
}

class MP4: MediaPlayer {
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

    func seek(to _: Measurement<UnitDuration>) throws {
        throw NotSupported()
    }

    func download() -> URLSessionDataTask {
        // produce a task to download the content
        return URLSession.shared.dataTask(with: url)
    }

    func stream() -> AVPlayerItem {
        // set up the item to stream
        return AVPlayerItem(url: url)
    }
}

class HLS: MediaPlayer {
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

    func download() throws -> URLSessionDataTask {
        throw NotSupported()
    }
}
