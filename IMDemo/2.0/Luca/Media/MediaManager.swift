//
//  MediaManager.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/27.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit
import AVFoundation

class MediaManager: NSObject {
    
    static let sharedInstance = MediaManager()
    
    //录音器
    var recorder:AVAudioRecorder?
    //播放器
    var player:AVAudioPlayer?
    //录音器设置参数数组
    var recorderSettingsDic:[String : AnyObject]?
    //录音存储路径
    var aacPath:String?
    //暂停时间
    var pauseTime : Double = 0.0
    //时间计时器
    var timer : Timer?
    
    /*录音开始事件*/
    func startRecordToURL(url: String?) {
        //准备录音，定义路径
        audio()
        //初始化录音器
        recorder = try! AVAudioRecorder(url: URL(string: url!)!,
                                        settings: recorderSettingsDic!)
        if recorder != nil {
            //开启仪表计数功能
            recorder!.isMeteringEnabled = true
            //准备录音
            recorder!.prepareToRecord()
            //开始录音
            recorder!.record()
        }
        print(recorder.debugDescription)
    }
    
    /*准备录音，定义路径*/
    func audio(){
        //初始化录音器
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        //设置录音类型
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        //设置支持后台
        try! session.setActive(true)
        //初始化字典并添加设置参数
        recorderSettingsDic =
            [
                AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
                //录音的声道数，立体声为双声道
                AVNumberOfChannelsKey: NSNumber(value: 2),
                AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue as AnyObject,
                AVEncoderBitRateKey : 320000 as AnyObject,
                //录音器每秒采集的录音样本数
                AVSampleRateKey : 44100.0 as AnyObject
        ]
    }
    
    /*录音停止事件*/
    func stop() {
        //停止录音
        recorder?.stop()
        //录音器释放
        recorder = nil
    }
    
    func playWithURL(url: String) {
        //扬声器
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        //播放
        player = try! AVAudioPlayer(contentsOf: URL(string: url)!)
        if player == nil {
        }else{
            player?.play()
        }
    }
    
    
    /**
     *  Remain to be Done
     */
    
    /*
    /*暂停*/
    func pause(sender: UIButton) {
        //隐藏暂停按钮
        pause.hidden = true
        //显示继续按钮
        btnContinue.hidden = false
        //停用时间控制器
        timer.invalidate()
        if ((player?.playing) != nil){
            player?.pause()}
        //获取暂停时间
        pauseTime = (player?.currentTime)!
    }
    
    /*继续播放*/
    func `continue`(sender: UIButton) {
        //显示暂停按钮
        pause.hidden = false
        //隐藏继续按钮
        btnContinue.hidden = true
        if player == nil {
        }else{
            player?.play()
        }
        
    }
    */
}
