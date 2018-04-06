//
//  ViewController.swift
//  MascaraCamera
//
//  Created by Diogo Trajano on 05/04/18.
//  Copyright © 2018 Diogo Trajano. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    @IBOutlet weak var previewView: UIStackView!
    @IBOutlet weak var captureImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
                print ("granted")
            } else {
                print ("denied")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)

        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            // ...
            // The remainder of the session setup will go here...
        }
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
        
        if session!.canAddOutput(stillImageOutput!) {
            session!.addOutput(stillImageOutput!)
            // ...
            // Configure the Live Preview here...
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
        videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspect
        videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        previewView.layer.addSublayer(videoPreviewLayer!)
        session!.startRunning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       videoPreviewLayer!.frame = previewView.bounds
    }
    @IBAction func btnTakePicture_touchUpInside(_ sender: Any) {
        
        
        if let videoConnection = stillImageOutput!.connection(with: AVMediaType.video) {
            // ...
            // Code for photo capture goes here...
            stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
                // ...
                // Process the image data (sampleBuffer) here to get an image file we can put in our captureImageView
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    let dataProvider = CGDataProvider(data: imageData as! CFData)
                    let cgImageRef = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    //let image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    //let image = UIImage(cgImage: cgImageRef!, scale: 1, orientat)
                    let image = UIImage(cgImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.right)
                    // ...
                    // Add the image to captureImageView here...
                    self.captureImageView.image = image
                }
            })
        }
    }
}

