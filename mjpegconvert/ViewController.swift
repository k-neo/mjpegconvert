//
//  ViewController.swift
//  mjpegconvert
//
//  Created by 秋本大介 on 2020/08/22.
//  Copyright © 2020 秋本大介. All rights reserved.
//

import UIKit
import mobileffmpeg

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        execConvert()
    }

    func execConvert() {
        guard let sourcePath: String = Bundle.main.path(forResource: "IMG_0392", ofType: "mp4") else {
            return
        }

        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        guard let destinationPath = documentsURL.appendingPathComponent("output.avi")?.path else {
            return
        }
        try? FileManager.default.removeItem(atPath: destinationPath)

        let command = "-i \(sourcePath) -vf \"scale=240:136,pad=240:240:0:52:black\" -vcodec mjpeg \(destinationPath)"

        print(command)
        let returnCode = MobileFFmpeg.execute(command)
        print(returnCode)
    }

}

