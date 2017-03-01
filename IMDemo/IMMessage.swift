//
//  IMMessage.swift
//  IMDemo
//
//  Created by 小白 on 2017/2/20.
//  Copyright © 2017年 LinJian. All rights reserved.
//

import UIKit

struct IMImageObject {
    
    /**
     *  文件展示名
     */
    var displayName: String?
    
    /**
     *  图片本地路径
     *  @discussion 目前 SDK 没有提供下载大图的方法,但推荐使用这个地址作为图片下载地址,APP 可以使用自己的下载类或者 SDWebImage 做图片的下载和管理
     */
    var path: String?
    
    /**
     *  缩略图本地路径
     */
    var thumbPath: String?
    
    /**
     *  图片远程路径
     */
    var url: String?
    
    /**
     *  缩略图远程路径
     *  @discussion 仅适用于使用云信上传服务进行上传的资源，否则无效。
     */
    var thumbUrl: String?
    
    /**
     *  图片尺寸
     */
    var size: CGSize?
    
    /**
     *  文件大小
     */
    var fileLength: CLongLong?
}

struct IMAudioObject {
    /**
     *  语音的本地路径
     */
    var path: String?
    
    /**
     *  语音的远程路径
     */
    var url: String?
    
    /**
     *  语音时长，毫秒为单位
     *  @discussion SDK会根据传入文件信息自动解析出duration,但上层也可以自己设置这个值
     */
    var duration: NSInteger?
}

struct IMCustomObject {
    var attachment: Any?
}

/**
 *  消息体协议
 */
protocol IMMessageObject: NSObjectProtocol {

/**
 *  消息体所在的消息对象
 */
    var message: IMMessage { get }

/**
 *  消息内容类型
 *
 *  @return 消息内容类型
 */
    func type() -> (IMMessage.MessageType)
}

class IMMessage: NSObject {
    
    /**
     *  消息送达状态枚举
     */
    enum MessageDeliveryState: NSInteger {
        /**
         *  消息发送失败
         */
        case MessageDeliveryStateFailed
        /**
         *  消息发送中
         */
        case MessageDeliveryStateDelivering
        /**
         *  消息发送成功
         */
        case MessageDeliveryStateDeliveried
        
    }
    
    /**
     *  消息附件下载状态
     */
    enum MessageAttachmentDownloadState: NSInteger {
        /**
         *  附件需要进行下载 (有附件但并没有下载过)
         */
        case MessageAttachmentDownloadStateNeedDownload
        /**
         *  附件收取失败 (尝试下载过一次并失败)
         */
        case MessageAttachmentDownloadStateFailed
        /**
         *  附件下载中
         */
        case MessageAttachmentDownloadStateDownloading
        /**
         *  附件下载成功/无附件
         */
        case MessageAttachmentDownloadStateDownloaded
    }
    
    /**
     *  消息内容类型枚举
     */
    enum MessageType: NSInteger {
        /**
         *  文本类型消息
         */
        case MessageTypeText = 0
        /**
         *  图片类型消息
         */
        case MessageTypeImage = 1
        /**
         *  声音类型消息
         */
        case MessageTypeAudio = 2
        /**
         *  视频类型消息
         */
        case MessageTypeVideo = 3
        /**
         *  位置类型消息
         */
        case MessageTypeLocation = 4
        /**
         *  通知类型消息
         */
        case MessageTypeNotification = 5
        /**
         *  文件类型消息
         */
        case MessageTypeFile = 6
        /**
         *  提醒类型消息
         */
        case MessageTypeTip = 10
        /**
         *  自定义类型消息
         */
        case MessageTypeCustom = 100
    }

    /**
     *  消息类型(默认为文本消息)
     */
    var messageType: MessageType = IMMessage.MessageType(rawValue: 0)!
    
    /**
     *  消息来源
     */
    var from: String?
    
    /**
     *  消息所属会话
     */
    var session: String?
    
    /**
     *  消息ID,唯一标识
     */
    var messageID: String?
    
    /**
     *  消息文本
     *  @discussion 聊天室消息中除 NIMMessageTypeText 和 NIMMessageTypeTip 外，其他消息 text 字段都为 nil
     */
    var text: String?
    
    /**
     *  消息附件内容
     */
    var messageObject: Any?
    
    /**
     *  图片消息附件内容
     */
    var imageObject: IMImageObject = IMImageObject()
    
    /**
     *  语音消息附件内容
     */
    var audioObject: IMAudioObject = IMAudioObject()
    
    /**
     *  自定义消息附件内容
     */
    var customObject: IMCustomObject = IMCustomObject()
    
    /**
     *  消息附件种类
     */
    var messageObjectType: String?
    
    /**
     *  消息发送时间
     *  @discussion 本地存储消息可以通过修改时间戳来调整其在会话列表中的位置，发完服务器的消息时间戳将被服务器自动修正
     */
    var timestamp: TimeInterval?
    
    /**
     *  消息投递状态 仅针对发送的消息
     */
    var deliveryState: MessageDeliveryState = MessageDeliveryState.MessageDeliveryStateFailed
    
    /**
     *  消息附件下载状态 仅针对收到的消息
     */
    var attachmentDownloadState:MessageAttachmentDownloadState?
    
    /**
     *  消息是否标记为已删除
     *  @discussion 已删除的消息在获取本地消息列表时会被过滤掉，只有根据messageId获取消息的接口可能会返回已删除消息。
     */
    var isDeleted: Bool?
    
}
// ------------------------- 其它暂时未用到的接口 -----------------------------

//    /**
//     *  消息设置
//     *  @discussion 可以通过这个字段制定当前消息的各种设置,如是否需要计入未读，是否需要多端同步等
//     */
//    @property (nullable,nonatomic,strong)                NIMMessageSetting *setting;
//    
//    /**
//     *  消息反垃圾配置
//     *  @discussion 目前仅支持易盾，只有接入了易盾才可以设置这个配置
//     */
//    @property (nullable,nonatomic,strong)                NIMAntiSpamOption *antiSpamOption;
//    
//    
//    /**
//     *  消息推送文案,长度限制200字节
//     */
//    @property (nullable,nonatomic,copy)                  NSString *apnsContent;
//    
//    /**
//     *  消息推送Payload
//     *  @discussion 可以通过这个字段定义消息推送Payload,支持字段参考苹果技术文档,长度限制 2K
//     */
//    @property (nullable,nonatomic,copy)                NSDictionary *apnsPayload;
//    
//    /**
//     *  指定成员推送选项
//     *  @discussion 通过这个选项进行一些更复杂的推送设定，目前只能在群会话中使用
//     */
//    @property (nullable,nonatomic,strong)                NIMMessageApnsMemberOption *apnsMemberOption;
//    
//    
//    /**
//     *  服务器扩展
//     *  @discussion 客户端可以设置这个字段,这个字段将在本地存储且发送至对端,上层需要保证 NSDictionary 可以转换为 JSON，长度限制 4K
//     */
//    @property (nullable,nonatomic,copy)                NSDictionary    *remoteExt;
//    
//    /**
//     *  客户端本地扩展
//     *  @discussion 客户端可以设置这个字段，这个字段只在本地存储,不会发送至对端,上层需要保证 NSDictionary 可以转换为 JSON
//     */
//    @property (nullable,nonatomic,copy)                NSDictionary    *localExt;
//    
//    /**
//     *  消息拓展字段
//     *  @discussion 服务器下发的消息拓展字段，并不在本地做持久化，目前只有聊天室中的消息才有该字段(NIMMessageChatroomExtension)
//     */
//    @property (nullable,nonatomic,strong)                id messageExt;
//    
//    /**
//     *  是否是收到的消息
//     *  @discussion 由于有漫游消息的概念,所以自己发出的消息漫游下来后仍旧是"收到的消息",这个字段用于消息出错是时判断需要重发还是重收
//     */
//    @property (nonatomic,assign,readonly)       BOOL isReceivedMsg;
//    
//    /**
//     *  是否是往外发的消息
//     *  @discussion 由于能对自己发消息，所以并不是所有来源是自己的消息都是往外发的消息，这个字段用于判断头像排版位置（是左还是右）。
//     */
//    @property (nonatomic,assign,readonly)       BOOL isOutgoingMsg;
//    
//    /**
//     *  消息是否被播放过
//     *  @discussion 修改这个属性,后台会自动更新db中对应的数据
//     */
//    @property (nonatomic,assign)                BOOL isPlayed;
//
//    /**
//     *  对端是否已读
//     *  @discussion 只有当当前消息为 P2P 消息且 isOutgoingMsg 为 YES 时这个字段才有效，需要对端调用过发送已读回执的接口
//     */
//    @property (nonatomic,assign,readonly)       BOOL isRemoteRead;
//    
//    /**
//     *  消息发送者名字
//     *  @discussion 当发送者是自己时,这个值可能为空,这个值表示的是发送者当前的昵称,而不是发送消息时的昵称。聊天室消息里，此字段无效。
//     */
//    @property (nullable,nonatomic,copy,readonly)         NSString *senderName;
//    
//    
//    /**
//     *  发送者客户端类型
//     */
//    @property (nonatomic,assign,readonly)   NIMLoginClientType senderClientType;
//    @end
