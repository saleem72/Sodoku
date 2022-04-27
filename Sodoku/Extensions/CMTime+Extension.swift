//
//  CMTime+Extension.swift
//  MusicApp
//
//  Created by Yousef on 11/24/21.
//

import AVKit

//extension CMTime {
//    var String: String {
//        let secondsPlay = self.seconds
//        if !secondsPlay.isNaN {
//            let hours = Int(secondsPlay / 3600)
//            let restTime = secondsPlay.truncatingRemainder(dividingBy: 3600)
//            let minutes = Int(restTime / 60)
//            let second = Int(restTime.truncatingRemainder(dividingBy: 60))
//            if hours > 0 {
//                return Swift.String(format: "%02d:%02d:%02d", arguments: [hours, minutes, second])
//            } else {
//                return Swift.String(format: "%02d:%02d", arguments: [minutes, second])
//            }
//        } else {
//            return "00:00"
//        }
//
//
//    }
//}

extension CMTime {
    var roundedSeconds: TimeInterval {
        let secondsToPlay = seconds
        if !secondsToPlay.isNaN {
            return secondsToPlay.rounded()
        } else {
            return .zero
        }
    }

    var hours:  Int { return Int(roundedSeconds / 3600) }
    var minute: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 3600) / 60) }
    var second: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 60)) }

    var positionalTime: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            String(format: "%02d:%02d",
                   minute, second)
    }
    
    var toDescription: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            "00:" + String(format: "%02d:%02d",
                           minute, second)
    }
}


extension TimeInterval {
    var hours:  Int { return Int(self / 3600) }
    var minute: Int { return Int(self.truncatingRemainder(dividingBy: 3600) / 60) }
    var second: Int { return Int(self.truncatingRemainder(dividingBy: 60)) }

    var positionalTime: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            String(format: "%02d:%02d",
                   minute, second)
    }
    
    var toDescription: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            String(format: "%02d:%02d",
                           minute, second)
    }
}
