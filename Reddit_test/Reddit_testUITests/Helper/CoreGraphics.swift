//
//  CoreGraphics.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//    Copyright © 2020 Artem Belenkov. All rights reserved.
//

import CoreGraphics

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }

    func maxSwipeOffset(swipeLengthX: CGFloat = 0.7, swipeLengthY: CGFloat = 0.7) -> CGSize {
        CGSize(
            width: width * swipeLengthX,
            height: height * swipeLengthY
        )
    }
}

extension CGPoint {
    func vector(to point: CGPoint) -> CGVector {
        CGVector(dx: point.x - x, dy: point.y - y)
    }

    func swipeVectors(direction vector: CGVector) -> (startVector: CGVector, stopVector: CGVector) {
        let startVector = CGVector(
            dx: x + vector.dx / 2,
            dy: y + vector.dy / 2
        )

        let stopVector = CGVector(
            dx: x - vector.dx / 2,
            dy: y - vector.dy / 2
        )

        return (startVector, stopVector)
    }
}

extension CGVector {
    func normalize(in frame: CGRect) -> CGVector {
        CGVector(
            dx: dx / frame.width,
            dy: dy / frame.height
        )
    }
}
