import { media } from '@kit.MediaKit'
import { common } from '@kit.AbilityKit'
import { resourceManager } from '@kit.LocalizationKit'
import { BusinessError } from '@kit.BasicServicesKit'
import Logger from './Logger'
import { image } from '@kit.ImageKit'
import {CommonConstants} from '../constants/CommonConstants'
import { HashMap } from '@kit.ArkTS'

/**
 * AvPlayer的工具类
 * 实现视频播放相关的功能
 */
export class AvPlayerUtil {
  private playerId ?: number
  // 创建mediaKIT中的AVPlayer实体,用于音视频的播放
  private avPlayer ?: media.AVPlayer 
  // 创建一个AVImageGenerator实体,用于获取缩略图
  private avImageGenerator ?: media.AVImageGenerator
  
  
  // 获取当前页面的UIAbility的上下文信息
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
  
  // 视频播放的路径
  private url: resourceManager.RawFileDescriptor | null = null
  private pixel_map : image.PixelMap | undefined = undefined;
  
  private playState: boolean = true
  private surfaceId: string = ''
  private sliderBegin: number = 0
  private startTime: number = 0
  private isFullScreen: boolean = false
  private updateTime: number = 0
  private statusMap : Map<string,string> = new Map()
  
  
  
  
  private onError: (err: BusinessError) => void = (err: BusinessError) => {
    // Logger.error(`Invoke avPlayer failed, code is ${err.code}, message is ${err.message}`)
    if (this.avPlayer === undefined) {
      // Logger.error(`AvPlayer is undefined`)
      return
    }
    this.avPlayer.reset()
  }
  private onTimeUpdateFunction: (updateTime: number) => void = (updateTime: number) => {
    if (this.avPlayer === undefined) {
      // Logger.error(`AvPlayer is undefined`)
      return
    }
    this.updateTime = updateTime
    // this.statusMap.set(CommonConstants.AV_PLAYER_CURRENT_TIME,this.formatTime(updateTime))
    // this.statusMap.set(CommonConstants.AV_PLAYER_UPDATE_TIME,updateTime.toString())
    // this.statusMap.set(CommonConstants.AV_PLAYER_PROGRESS,( updateTime / this.avPlayer.duration * CommonConstants.PROGRESS_HUNDRED).toString())
    // this.statusMap.set("duration",this.avPlayer.duration.toString())
    AppStorage.setOrCreate<string>(CommonConstants.AV_PLAYER_CURRENT_TIME, this.formatTime(updateTime)) // 当前播放时间
    AppStorage.setOrCreate<number>(CommonConstants.AV_PLAYER_UPDATE_TIME, updateTime) // 更新的时间
    AppStorage.setOrCreate<number>(CommonConstants.AV_PLAYER_PROGRESS, 
      updateTime / this.avPlayer.duration * CommonConstants.PROGRESS_HUNDRED) // 当前进度
    AppStorage.setOrCreate<number>("duration",this.avPlayer.duration)
    
  }
  
  getVideoStatus(){
    return this.statusMap
  }
  
  
  // avPlayer 状态切换
  private onStateChange: (state: media.AVPlayerState) => void = async (state: media.AVPlayerState) => {
    if (this.avPlayer === undefined) {
      // Logger.error(`AvPlayer is undefined`);
      return;
    }
    switch (state) {
      case CommonConstants.AV_PLAYER_IDLE_STATE:
        // this.url = await this.context.createModuleContext(CommonConstants.VIDEO_DETAIL_HSP_NAME).resourceManager
        //   .getRawFd(CommonConstants.PRODUCT_VIDEO_NAME);
        // this.avPlayer.fdSrc = this.url;
        // Logger.info('AVPlayer state idle called.');
        break;
      case CommonConstants.AV_PLAYER_INITIALIZED_STATE:
        // Logger.info('AVPlayer initialized called.');
        this.avPlayer.surfaceId = this.surfaceId;
        this.avPlayer.prepare().then(() => {
          // Logger.info('AVPlayer prepare succeeded.');
        }, (err: BusinessError) => {
          // Logger.error(`Invoke prepare failed, code is ${err.code}, message is ${err.message}`);
          if (this.avPlayer === undefined) {
            // Logger.error(`AvPlayer is undefined`);
            return;
          }
          this.avPlayer.reset();
        });
        break;
      case CommonConstants.AV_PLAYER_PREPARED_STATE:
        this.avPlayer.videoScaleType = media.VideoScaleType.VIDEO_SCALE_TYPE_FIT;
        // Logger.info('AVPlayer state prepared called.');
        this.seekToStart();
        this.avPlayer.play();
        AppStorage.setOrCreate<string>(CommonConstants.AV_PLAYER_TOTAL_TIME, this.formatTime(this.avPlayer.duration));
        // this.statusMap.set(CommonConstants.AV_PLAYER_TOTAL_TIME,this.formatTime(this.avPlayer.duration))
        break;
      case CommonConstants.AV_PLAYER_PLAYING_STATE:
        // Logger.info('AVPlayer state playing called.');
        this.playState = true;
        if (this.isFullScreen) {
          AppStorage.setOrCreate<boolean>('fullScreenPlayState', this.playState);
        }
        this.seekToStart();
        break;
      case CommonConstants.AV_PLAYER_PAUSED_STATE:
        // Logger.info('AVPlayer state paused called.');
        this.playState = false;
        if (this.isFullScreen) {
          AppStorage.setOrCreate<boolean>('fullScreenPlayState', this.playState);
        }
        this.seekToStart();
        break;
      case CommonConstants.AV_PLAYER_COMPLETED_STATE:
        // Logger.info('AVPlayer state completed called.');
        this.playState = false;
        if (this.isFullScreen) {
          AppStorage.setOrCreate<boolean>('fullScreenPlayState', this.playState);
        }
        this.avPlayer.stop();
        break;
      case CommonConstants.AV_PLAYER_STOPPED_STATE:
        // Logger.info('AVPlayer state stopped called.');
        break;
      case CommonConstants.AV_PLAYER_RELEASE_STATE:
        // Logger.info('AVPlayer state released called.');
        break;
      case CommonConstants.AV_PLAYER_ERROR_STATE:
        // Logger.error('AVPlayer state error called.');
        break;
      default:
        // Logger.info('AVPlayer state unknown called.');
        break;
    }
  }
  
  async getPixelImage(time: number){
    
    let queryOption = media.AVImageQueryOptions.AV_IMAGE_QUERY_NEXT_SYNC
    let param: media.PixelMapParams = {
      width : 300,
      height : 300
    }
    this.pixel_map = await this.avImageGenerator?.fetchFrameByTime(time,queryOption,param)
    return this.pixel_map
  }
  
  async createAvPlayer(surfaceId: string, isFullScreen: boolean,url :string) {
    this.isFullScreen = isFullScreen
    if (this.avPlayer === undefined || this.avPlayer.state === CommonConstants.AV_PLAYER_RELEASE_STATE) {
      this.avPlayer = await media.createAVPlayer()
      // this.avImageGenerator = await media.createAVImageGenerator()
      this.surfaceId = surfaceId
      // Logger.info('Created AvPlayer successfully.');
      this.url = await this.context.createModuleContext(CommonConstants.VIDEO_DETAIL_HSP_NAME).resourceManager
        .getRawFd(url);
      this.avPlayer.fdSrc = this.url
      // this.avPlayer.url = url
      this.setAVPlayerCallback();
    } else {
      // Logger.info(`AvPlayer has been created`);
    }
  }
  
  setAVPlayerCallback(): void {
    if (this.avPlayer === undefined) {
      // Logger.error(`AvPlayer is undefined`);
      return;
    }
    this.avPlayer.on('error', this.onError);
    this.onTimeUpdate();
    this.setStateChange();
  }

  onTimeUpdate(): void {
    if (this.avPlayer === undefined) {
      // Logger.error(`AvPlayer is undefined`);
      return;
    }
    this.avPlayer.on('timeUpdate', this.onTimeUpdateFunction);
  }

  offTimeUpdate(): void {
    if (this.avPlayer === undefined) {
      // Logger.error(`AvPlayer is undefined`);
      return;
    }
    try {
      this.avPlayer.off('timeUpdate');
    } catch (exception) {
      // Logger.error('Failed to unregister callback. Code: ' + JSON.stringify(exception));
    }
  }
  setStateChange(): void {
    if (this.avPlayer === undefined) {
      // Logger.error(`AvPlayer is undefined`);
      return;
    }
    this.avPlayer.on('stateChange', this.onStateChange)
  }

  setStartTime(startTime: number): void {
    this.startTime = startTime;
  }

  seekToStart(): void {
    if (this.startTime != 0 && this.avPlayer !== undefined) {
      this.avPlayer.seek(this.startTime, media.SeekMode.SEEK_PREV_SYNC);
      this.startTime = 0;
    } else{
      
      Logger.info(`Video is played from the beginning`);
    }
  }

  release(): void {
    if (this.avPlayer !== undefined && this.avPlayer.state !== CommonConstants.AV_PLAYER_RELEASE_STATE) {
      try {
        this.avPlayer.off('error');
        this.avPlayer.off('stateChange');
      } catch (exception) {
        // Logger.error('Failed to unregister callback. Code: ' + JSON.stringify(exception));
      }
      this.avImageGenerator?.release()
      this.avPlayer.release();
    } else {
      // Logger.info(`AvPlayer release failed`);
    }
  }

  sliderChange(value: number, mode: SliderChangeMode): void {
    let seekType: media.SeekMode = value > this.sliderBegin ? media.SeekMode.SEEK_PREV_SYNC :
    media.SeekMode.SEEK_NEXT_SYNC;
    Logger.info(`value:${value},mode:${mode}}`)
    if (this.avPlayer === undefined) {
      Logger.error(`AvPlayer is undefined`);
      return;
    }
    switch (mode) {
      case SliderChangeMode.Begin:
        Logger.info(`AvPlayer SliderChangeMode Begin`);
        this.sliderBegin = value;
        this.avPlayer.play();
        break;
      case SliderChangeMode.Moving:
        Logger.info(`AvPlayer SliderChangeMode Moving`);
        this.avPlayer.seek(value / CommonConstants.PROGRESS_HUNDRED * this.avPlayer.duration, seekType);
        break;
      case SliderChangeMode.End:
        Logger.info(`AvPlayer SliderChangeMode End`);
        this.avPlayer.play();
        break;
      case SliderChangeMode.Click:
        Logger.info(`AvPlayer SliderChangeMode Click`);
        this.avPlayer.seek(this.sliderBegin / CommonConstants.PROGRESS_HUNDRED * this.avPlayer.duration, seekType);
        break;
      default:
        break;
    }
  }
  
  playerStateControl(): void {
    if (this.avPlayer === undefined) {
      // Logger.error(`AvPlayer is undefined`);
      return;
    }
    if (this.avPlayer.state === CommonConstants.AV_PLAYER_STOPPED_STATE) {
      this.avPlayer.prepare();
      return;
    }
    if (!this.playState) {
      this.avPlayer.play();
    } else {
      this.avPlayer.pause();
    }
  }

  play(): void {
    if (this.avPlayer !== undefined && !this.playState) {
      this.avPlayer.play();
    } else {
      Logger.info(`AvPlayer play failed`);
    }
  }

  pause(): void {
    if (this.avPlayer !== undefined && this.playState) {
      this.avPlayer.pause();
    } else {
      Logger.info(`AvPlayer pause failed`);
    }
  }

  setUrl(url: resourceManager.RawFileDescriptor | null) {
    this.url = url
  }

  formatTime(duration: number): string {
    let totalSecond: number = Math.round(duration / CommonConstants.PROGRESS_THOUSAND);
    let hourNum: number = Math.floor(totalSecond / CommonConstants.SECOND_IN_HOUR);
    let minNum: number = Math.floor((totalSecond % CommonConstants.SECOND_IN_HOUR) / CommonConstants.SECOND_IN_MINUTE);
    let secNum: number = (totalSecond % CommonConstants.SECOND_IN_HOUR) % CommonConstants.SECOND_IN_MINUTE;
    return this.formatUnitTime(hourNum) + CommonConstants.COLON + this.formatUnitTime(minNum) + CommonConstants.COLON +
    this.formatUnitTime(secNum);
  }

  formatUnitTime(time: number): string {
    if (time >= CommonConstants.ONE && time < CommonConstants.TEN) {
      let zero: string = CommonConstants.TIME_PREFIX;
      return zero.concat(time.toString());
    } else if (time >= CommonConstants.ZERO && time < CommonConstants.ONE) {
      return CommonConstants.EMPTY_TIME;
    }
    return time.toString();
  }
}
