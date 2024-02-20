//
//  ViewController.swift
//  skk
//
//  Created by Raffaele Marino  on 16/02/24.
//clalcalcalcaclacl

import AVKit
import Vision
import ARKit
import CoreML
import SceneKit
import SwiftUI


class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, ARSessionDelegate {

    let sceneView = ARSCNView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sceneView)
        sceneView.delegate = self
        sceneView.showsStatistics = false
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("HELLO I AM HERE")
    }


}

extension ViewController: ARSCNViewDelegate {
    
    
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        
//        guard let device = sceneView.device else {
//            return nil
//        }
//        
//        let faceGeometry = ARSCNFaceGeometry(device: device)
//        
//        let node = SCNNode(geometry: faceGeometry)
//        
//        node.geometry?.firstMaterial?.fillMode = .lines
//        
//        return node
//    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        var contentNode: SCNNode?
        
        guard let sceneView = renderer as? ARSCNView,
            anchor is ARFaceAnchor else { return nil }
        
        let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        let material = faceGeometry.firstMaterial!
        
        material.diffuse.contents = "wireframeTexture" // Example texture map image.
        material.lightingModel = .physicallyBased
        
        contentNode = SCNNode(geometry: faceGeometry)
        return contentNode
    }

    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
                return
        }
        
        faceGeometry.update(from: faceAnchor.geometry)
        
//        let text = SCNText(string: "", extrusionDepth: 2)
//        let font = UIFont(name: "Avenir-Heavy", size: 18)
//        text.font = font
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.black
//        text.materials = [material]
//        text.firstMaterial?.isDoubleSided = true
//        
//        let textNode = SCNNode(geometry: faceGeometry)
//        textNode.position = SCNVector3(-0.1, -0.01, -0.5)
//        print(textNode.position)
//        textNode.scale = SCNVector3(0.002, 0.002, 0.002)
//        
//        textNode.geometry = text
        
        let defaultConfig = MLModelConfiguration()
        
        guard let model = try? VNCoreMLModel(for: Face(configuration: defaultConfig).model) else {
            fatalError("Unable to load model")
        }
        
        let coreMlRequest = VNCoreMLRequest(model: model) {[weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("Unexpected results")
            }

            DispatchQueue.main.async {[weak self] in
                print(topResult.identifier)
                if topResult.identifier != "Unknown" {
//                    text.string = topResult.identifier
//                    self!.sceneView.scene.rootNode.addChildNode(textNode)
                    self!.sceneView.autoenablesDefaultLighting = true
                }
            }
        }
        
        guard let pixelBuffer = self.sceneView.session.currentFrame?.capturedImage else { return }
        
        
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        DispatchQueue.global().async {
            do {
                try handler.perform([coreMlRequest])
            } catch {
                print(error)
            }
        }
    }
}

