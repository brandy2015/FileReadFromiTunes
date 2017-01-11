//
//  ViewController.swift
//  FileReadFromiTunes
//
//  Created by 张子豪 on 2017/1/9.
//  Copyright © 2017年 张子豪. All rights reserved.
//

import UIKit
import AVFoundation
//import AVFoundation
import MediaPlayer


class ViewController: UIViewController {
//    let a = UILabel()

    var 如果有文件的路径string = ""
//    var audioPlayer = AVAudioPlayer()
//    var isPlaying = false
//    var timer:NSTimer!
    
    var recorder:AVAudioRecorder? //录音器
    var player1 = AVAudioPlayer() //播放器
    var recorderSeetingsDic:[String : AnyObject]? //录音器设置参数数组
    var volumeTimer:Timer! //定时器线程，循环监测录音的音量大小
    var aacPath:String? //录音存储路径

    
    @IBOutlet weak var 等待判断Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        判断()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            
        }
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        setLockView()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func 判断Button(_ sender: Any) {
        
        判断()
    }
    
    @IBAction func 播放声音Button(_ sender: Any) {
        
        if 如果有文件的路径string != ""{
            let 路径URL = URL(fileURLWithPath: 如果有文件的路径string)
            播放声音(路径: 路径URL)
        }else{
        
            print("播放不了")
        }
        
    }
    
    func 判断()  {
        let manager = FileManager.default
        let path = NSHomeDirectory() + "/Documents/2.mp3"
        
//        let path2 = NSHomeDirectory()
        
        if manager.fileExists(atPath: path){
            
            
            等待判断Label.text = "有文件"
            如果有文件的路径string = path
            
        }else{
            
            等待判断Label.text = "没文件"
        }
        print("NsHOmeDirectory的路径是" + "\(NSHomeDirectory())")
        
        
    }
    
//    func 读取音乐()  {
//        
//            let 路径2 = NSHomeDirectory() + "/Documents/tfDic.plist"
//        
//        
//        
//            var dict = NSDictionary(contentsOfFile: 路径2) as? [String:String]
//            
//            if dict == nil{
//                
//                dict = [:]
//            }
//            
//            
////            return dict!
//        
//            
////        }
//    }
//    
    
    
    
    
    
    func 播放声音(声音:Data = Data(),路径:URL)  {
        
        //扬声器播放
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        
       player1 = try! AVAudioPlayer(contentsOf: 路径)
        
//        player1 = try! AVAudioPlayer(data: 声音 )
        
        //获得音频会话对象,该对象属于单例模式,也就是说不用开发者而自行实例化.这个类在各种音频环境中,起着重要作用
        
        let session = AVAudioSession.sharedInstance()
        
        
        
        //在音频播放前,首先创建一个异常捕捉语句
        
        do {
            //启动音频会话管理,此时会阻断后台音乐的播放.
            
            try session.setActive(true)
            
            //设置音频操作类别,表示该应用仅支持音频的播放.
            
            try session.setCategory(AVAudioSessionCategoryPlayback)
            
            //设置应用程序支持接受远程控制事件
            
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            
            
            if player1 == nil {
                print("播放失败")
            }else{
                player1.play()
            }
        }catch {
            
            print(error)
            
        }
        
        
        
    }
    

    
    
    override func remoteControlReceived(with event: UIEvent?) {
        
        switch event!.subtype {
        case .remoteControlPlay:  // play按钮
            player1.play()
        case .remoteControlPause:  // pause按钮
            player1.pause()
        case .remoteControlNextTrack:  // next
            // ▶▶
            break
        case .remoteControlPreviousTrack:  // previous
            // ◀◀
            break
        default:
            break
        }
    }
    
    func setLockView(){
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            // 歌曲名称
            MPMediaItemPropertyTitle:"录音声音控制",
            // 演唱者
            MPMediaItemPropertyArtist:"你猜",
            // 锁屏图片
//            MPMediaItemPropertyArtwork:MPMediaItemArtwork(image: UIImage(named:"test")) ?? UIImage(named: "test")!),
            //
            MPNowPlayingInfoPropertyPlaybackRate:1.0,
            // 总时长            MPMediaItemPropertyPlaybackDuration:audioPlayer.duration,
            // 当前时间        MPNowPlayingInfoPropertyElapsedPlaybackTime:audioPlayer.currentTime
        ]
    }
    

    

}

