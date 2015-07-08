//
//  ScanViewController.swift
//  Frameless
//
//  Created by Yiming on 15/6/25.
//  Copyright (c) 2015年 Jay Stakelon. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    var delegate: ViewController?
    var session: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var output: AVCaptureMetadataOutput?
    
    @IBOutlet weak var _closeButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarAppearance()
        setupScanQrCodeView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    /**
    设置导航栏颜色
    */
    func setupNavigationBarAppearance() {
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        _closeButton.tintColor = UIColor.whiteColor()
        var font = UIFont(name: "ClearSans-Bold", size: 18)
        var textAttributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    /**
    二维码扫描界面
    */
    func setupScanQrCodeView(){
        var screenBounds = UIScreen.mainScreen().bounds
        var screenWidth = CGRectGetWidth(screenBounds)
        var screenHeight = CGRectGetHeight(screenBounds)
        
        session = AVCaptureSession()
        var device: AVCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        
        var input = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as? AVCaptureDeviceInput
        
        if let myInput = input{
            session?.addInput(input!)
            
            previewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as? AVCaptureVideoPreviewLayer
            previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill;
            previewLayer!.bounds = self.view.bounds;
            previewLayer!.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));

            view.layer.addSublayer(previewLayer)
            session!.startRunning()
            
            var qrRectView = QRScanView()
            qrRectView.frame = screenBounds
            qrRectView.backgroundColor = UIColor.clearColor()
            qrRectView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
            self.view.addSubview(qrRectView)
            
            output = AVCaptureMetadataOutput()
            session!.addOutput(output)
            output?.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            output?.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            
            
            var clearRectWidth = screenWidth/6.0 * 4;
            var clearRect = CGRectMake(screenWidth/6.0, (screenHeight - clearRectWidth)/2.0, clearRectWidth, clearRectWidth);
            output?.rectOfInterest = CGRectMake(clearRect.origin.y / screenHeight,
                clearRect.origin.x / screenWidth,
                clearRect.size.height / screenHeight,
                clearRect.size.width / screenWidth)
        }else{
            println("\(error)")
        }
    }
    
    /**
    /**
    *  @author iYiming, 15-05-25 18:33:56
    *
    *  设置二维码扫描界面
    */
    - (void) settingScanQrCodeView
    {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    CGFloat screenHeight = CGRectGetHeight(screenBounds);
    
    _scanQrCodeBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view addSubview:_scanQrCodeBgView];
    
    _session = [[AVCaptureSession alloc] init];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if(input) {
    // Add the input to the session
    [_session addInput:input];
    
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.bounds = self.view.bounds;
    _previewLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [_scanQrCodeBgView.layer addSublayer:_previewLayer];
    
    [_session startRunning];
    
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    ZYQQRScanView *qrRectView = [[ZYQQRScanView alloc] initWithFrame:screenBounds];
    qrRectView.backgroundColor = [UIColor clearColor];
    qrRectView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:qrRectView];
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_session addOutput:_output];
    [_output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    CGFloat screenHeight = CGRectGetHeight(screenBounds);
    CGFloat clearRectWidth = screenWidth/6.0f * 4;
    CGRect clearRect = CGRectMake(screenWidth/6.0f, (screenHeight - clearRectWidth)/2.0f, clearRectWidth, clearRectWidth);
    
    [_output setRectOfInterest:CGRectMake(clearRect.origin.x / screenWidth,
    clearRect.origin.y / screenHeight,
    clearRect.size.width / screenWidth,
    clearRect.size.height / screenHeight)];
    
    [_output setRectOfInterest:CGRectMake(clearRect.origin.y / screenHeight,
    clearRect.origin.x / screenWidth,
    clearRect.size.height / screenHeight,
    clearRect.size.width / screenWidth)];
    
    } else {
    Log(@"error: %@", error);
    return;
    }
    
    }
    */
    
    /**
    关闭
    
    :param: sender 关闭Item
    */
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {
             self.delegate?.focusOnSearchBar()
        })
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        for metadata in metadataObjects{
            if metadata.type == AVMetadataObjectTypeQRCode{
                session?.stopRunning()
                var transformed = metadata as! AVMetadataMachineReadableCodeObject
                var scanStr = transformed.stringValue
                
                println("\(scanStr)")
                self.dismissViewControllerAnimated(true, completion: {
                    self.delegate?.scanSucceed(scanStr)
                })
            }
        }
        
    }
    
    
}
