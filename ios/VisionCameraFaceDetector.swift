import Foundation
import VisionCamera
import UIKit
import AVFoundation
import Vision

@objc(VisionCameraFaceDetector)
public class VisionCameraFaceDetector: FrameProcessorPlugin {
    class func newInstance() -> VisionCameraFaceDetector {
      return VisionCameraFaceDetector()
    }

    var context = CIContext(options: nil)

    func processContours(from landmarks: VNFaceLandmarks2D) -> [String:[[String:CGFloat]]] {
      var faceContoursTypesMap: [String:[[String:CGFloat]]] = [:]

      if let faceContour = landmarks.faceContour {
          var pointsArray: [[String:CGFloat]] = []
          for point in faceContour.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["FACE"] = pointsArray
      }
      if let leftEyebrow = landmarks.leftEyebrow {
          var pointsArray: [[String:CGFloat]] = []
          for point in leftEyebrow.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["LEFT_EYEBROW_TOP"] = pointsArray
      }
      if let rightEyebrow = landmarks.rightEyebrow {
          var pointsArray: [[String:CGFloat]] = []
          for point in rightEyebrow.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["RIGHT_EYEBROW_TOP"] = pointsArray
      }
      if let leftEye = landmarks.leftEye {
          var pointsArray: [[String:CGFloat]] = []
          for point in leftEye.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["LEFT_EYE"] = pointsArray
      }
      if let rightEye = landmarks.rightEye {
          var pointsArray: [[String:CGFloat]] = []
          for point in rightEye.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["RIGHT_EYE"] = pointsArray
      }
      if let nose = landmarks.nose {
          var pointsArray: [[String:CGFloat]] = []
          for point in nose.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["NOSE_BRIDGE"] = pointsArray
      }
      if let noseCrest = landmarks.noseCrest {
          var pointsArray: [[String:CGFloat]] = []
          for point in noseCrest.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["NOSE_BOTTOM"] = pointsArray
      }
      if let medianLine = landmarks.medianLine {
          var pointsArray: [[String:CGFloat]] = []
          for point in medianLine.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["UPPER_LIP_TOP"] = pointsArray
      }
      if let outerLips = landmarks.outerLips {
          var pointsArray: [[String:CGFloat]] = []
          for point in outerLips.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["UPPER_LIP_BOTTOM"] = pointsArray
      }
      if let innerLips = landmarks.innerLips {
          var pointsArray: [[String:CGFloat]] = []
          for point in innerLips.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["LOWER_LIP_TOP"] = pointsArray
      }
      if let leftPupil = landmarks.leftPupil {
          var pointsArray: [[String:CGFloat]] = []
          for point in leftPupil.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["LEFT_PUPIL"] = pointsArray
      }
      if let rightPupil = landmarks.rightPupil {
          var pointsArray: [[String:CGFloat]] = []
          for point in rightPupil.normalizedPoints {
              pointsArray.append(["x": point.x, "y": point.y])
          }
          faceContoursTypesMap["RIGHT_PUPIL"] = pointsArray
      }
      return faceContoursTypesMap
    }
    
    func processLandMarks(from landmarks: VNFaceLandmarks2D) -> [String:[String: CGFloat?]] {
      var faceLandMarksTypesMap: [String: [String: CGFloat?]] = [:]

      if let leftEye = landmarks.leftEye?.normalizedPoints.first {
          faceLandMarksTypesMap["LEFT_EYE"] = ["x": CGFloat(leftEye.x), "y": CGFloat(leftEye.y)]
      } else {
          faceLandMarksTypesMap["LEFT_EYE"] = ["x": nil, "y": nil]
      }
      if let rightEye = landmarks.rightEye?.normalizedPoints.first {
          faceLandMarksTypesMap["RIGHT_EYE"] = ["x": CGFloat(rightEye.x), "y": CGFloat(rightEye.y)]
      } else {
          faceLandMarksTypesMap["RIGHT_EYE"] = ["x": nil, "y": nil]
      }
      if let nose = landmarks.nose?.normalizedPoints.first {
          faceLandMarksTypesMap["NOSE_BASE"] = ["x": CGFloat(nose.x), "y": CGFloat(nose.y)]
      } else {
          faceLandMarksTypesMap["NOSE_BASE"] = ["x": nil, "y": nil]
      }
      if let leftMouth = landmarks.outerLips?.normalizedPoints.first {
          faceLandMarksTypesMap["MOUTH_LEFT"] = ["x": CGFloat(leftMouth.x), "y": CGFloat(leftMouth.y)]
      } else {
          faceLandMarksTypesMap["MOUTH_LEFT"] = ["x": nil, "y": nil]
      }
      if let rightMouth = landmarks.outerLips?.normalizedPoints.last {
          faceLandMarksTypesMap["MOUTH_RIGHT"] = ["x": CGFloat(rightMouth.x), "y": CGFloat(rightMouth.y)]
      } else {
          faceLandMarksTypesMap["MOUTH_RIGHT"] = ["x": nil, "y": nil]
      }
      if let mouthBottom = landmarks.innerLips?.normalizedPoints.first {
          faceLandMarksTypesMap["MOUTH_BOTTOM"] = ["x": CGFloat(mouthBottom.x), "y": CGFloat(mouthBottom.y)]
      } else {
          faceLandMarksTypesMap["MOUTH_BOTTOM"] = ["x": nil, "y": nil]
      }
      // Cheeks and ears are not directly available in VNFaceLandmarks2D
      faceLandMarksTypesMap["LEFT_CHEEK"] = ["x": nil, "y": nil]
      faceLandMarksTypesMap["RIGHT_CHEEK"] = ["x": nil, "y": nil]
      faceLandMarksTypesMap["LEFT_EAR"] = ["x": nil, "y": nil]
      faceLandMarksTypesMap["RIGHT_EAR"] = ["x": nil, "y": nil]

      return faceLandMarksTypesMap
    }
    
    func processBoundingBox(from face: Face, photoWidth: CGFloat?) -> [String:Any] {
        let frameRect = face.frame
//      The implementation from this github repo seems to work better for the frameRect
//      Github link -> https://github.com/a7medev/react-native-ml-kit/blob/main/face-detection/ios/FaceDetection.m
        return [
          "x":frameRect.origin.x,
          "y": frameRect.origin.y,
          "width": frameRect.size.width,
          "height": frameRect.size.height,
          "boundingCenterX": frameRect.midX,
          "boundingCenterY": frameRect.midY,
          "aspectRatio": frameRect.size.width / photoWidth!
        ]
    }
    
    public override func callback(_ frame: Frame, withArguments arguments: [AnyHashable: Any]?) -> Any {
        // Convert frame to CIImage
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(frame.buffer) else {
            return ["faces": [], "frameData": ""]
        }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: .up, options: [:])
        
        // Prepare face detection request
        let faceRequest = VNDetectFaceLandmarksRequest()
        do {
            try handler.perform([faceRequest])
        } catch {
            return ["faces": [], "frameData": convertFrameToBase64(frame)]
        }
        
        // Collect results
        var faceAttributes: [Any] = []
        if let results = faceRequest.results as? [VNFaceObservation] {
            for observation in results {
                var map: [String: Any] = [:]
                
                // Bounding box
                let boundingBox = observation.boundingBox
                let imageWidth = CGFloat(CVPixelBufferGetWidth(pixelBuffer))
                map["bounds"] = [
                    "x": boundingBox.origin.x * imageWidth,
                    "y": boundingBox.origin.y * imageWidth, // adjust if needed
                    "width": boundingBox.size.width * imageWidth,
                    "height": boundingBox.size.height * imageWidth
                ]
                
                // Landmarks
                if let landmarks = observation.landmarks {
                    // Convert VNFaceLandmarks2D to your map format
                    map["landMarks"] = processLandMarks(from: landmarks)
                    map["contours"] = processContours(from: landmarks)
                } else {
                    map["landMarks"] = [:]
                    map["contours"] = [:]
                }
                
                // Compute eye open probabilities
                if let leftEyePoints = observation.landmarks?.leftEye?.normalizedPoints.map({ CGPoint(x: $0.x, y: $0.y) }),
                   let rightEyePoints = observation.landmarks?.rightEye?.normalizedPoints.map({ CGPoint(x: $0.x, y: $0.y) }) {
                    let leftEAR = eyeAspectRatio(leftEyePoints)
                    let rightEAR = eyeAspectRatio(rightEyePoints)
                    map["leftEyeOpenProbability"] = eyeOpenProbability(leftEAR)
                    map["rightEyeOpenProbability"] = eyeOpenProbability(rightEAR)
                } else {
                    map["leftEyeOpenProbability"] = 0
                    map["rightEyeOpenProbability"] = 0
                }

                // Compute smiling probability via mouth aspect ratio
                if let outer = observation.landmarks?.outerLips?.normalizedPoints.map({ CGPoint(x: $0.x, y: $0.y) }),
                   let inner = observation.landmarks?.innerLips?.normalizedPoints.map({ CGPoint(x: $0.x, y: $0.y) }) {
                    let mar = mouthAspectRatio(outer: outer, inner: inner)
                    map["smilingProbability"] = smilingProbabilityFromMAR(mar)
                } else {
                    map["smilingProbability"] = 0
                }

                // Keep roll, pitch, yaw as 0 for now
                map["rollAngle"] = 0
                map["pitchAngle"] = 0
                map["yawAngle"] = 0
                
                faceAttributes.append(map)
            }
        }
        // Prepare final result
        let frameData = convertFrameToBase64(frame)
        return ["faces": faceAttributes, "frameData": frameData]
    }

    func convertFrameToBase64(_ frame: Frame) -> Any! {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(frame.buffer) else {
          print("Failed to get CVPixelBuffer!")
          return nil
        }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)

        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
          print("Failed to create CGImage!")
          return nil
        }
        let image = UIImage(cgImage: cgImage)
        let imageData = image.jpegData(compressionQuality: 100)
        return imageData?.base64EncodedString() ?? ""
    }
    
    // Compute eye aspect ratio for a normalized point array
    func eyeAspectRatio(_ points: [CGPoint]) -> CGFloat {
        guard points.count >= 6 else { return 0 }
        let p1 = points[0], p2 = points[1], p3 = points[2], p4 = points[3], p5 = points[4], p6 = points[5]
        let vertical1 = hypot(p2.x - p6.x, p2.y - p6.y)
        let vertical2 = hypot(p3.x - p5.x, p3.y - p5.y)
        let horizontal = hypot(p1.x - p4.x, p1.y - p4.y)
        return (vertical1 + vertical2) / (2.0 * horizontal)
    }

    // Normalize EAR to probability [0,1]
    func eyeOpenProbability(_ ear: CGFloat) -> CGFloat {
        let minEAR: CGFloat = 0.15
        let maxEAR: CGFloat = 0.35
        let prob = (ear - minEAR) / (maxEAR - minEAR)
        return min(max(prob, 0), 1)
    }

    // Compute mouth aspect ratio from outer and inner lip landmarks
    func mouthAspectRatio(outer: [CGPoint], inner: [CGPoint]) -> CGFloat {
        guard outer.count >= 2, inner.count >= 2 else { return 0 }
        let left = outer.first!, right = outer.last!
        let top = inner.first!, bottom = inner.last!
        let horizontal = hypot(right.x - left.x, right.y - left.y)
        let vertical = hypot(top.x - bottom.x, top.y - bottom.y)
        guard horizontal > 0 else { return 0 }
        return vertical / horizontal
    }

    // Normalize MAR to probability [0,1]
    func smilingProbabilityFromMAR(_ mar: CGFloat) -> CGFloat {
        let minMAR: CGFloat = 0.2
        let maxMAR: CGFloat = 0.6
        let prob = (mar - minMAR) / (maxMAR - minMAR)
        return min(max(prob, 0), 1)
    }
    
    func getConfig(withArguments arguments: [AnyHashable: Any]!) -> [String:Any]! {
           if arguments.count > 0 {
            let config = arguments.map { dictionary in
                Dictionary(uniqueKeysWithValues: dictionary.map { (key, value) in
                    (key as? String ?? "", value)
                })
            }
              //  let config = arguments[0] as? [String:Any]
               return config
           }
           return nil
    }
}
