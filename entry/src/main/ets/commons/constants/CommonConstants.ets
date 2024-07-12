

//通用常量类
export class CommonConstants{

  //百分百布局参数常量
  static readonly FULL_PERCENT : string = "100%"
  /**
   * Video aspect ratio.
   * 视频横纵比
   */
  static readonly VIDEO_ASPECT_RATIO: number = 1.78;
  /**
   * Video detail.
   * 视频细节
   */
  static readonly VIDEO_DETAIL: string = 'videoDetail';

  /**
   * Idle state of avPlayer.
   * avPlayer 的空闲状态
   */
  static readonly AV_PLAYER_IDLE_STATE: string = 'idle';
  /**
   * Initialized state of avPlayer.
   * avPlayer 的初始化状态
   */
  static readonly AV_PLAYER_INITIALIZED_STATE: string = 'initialized';
  /**
   * Prepared state of avPlayer.
   * avPlayer 的准备状态
   */
  static readonly AV_PLAYER_PREPARED_STATE: string = 'prepared';
  /**
   * Playing state of avPlayer.
   * avPlayer 的播放状态
   */
  static readonly AV_PLAYER_PLAYING_STATE: string = 'playing';
  /**
   * Pause state of avPlayer.
   */
  static readonly AV_PLAYER_PAUSED_STATE: string = 'paused';
  /**
   * Completed state of avPlayer.
   * avPlayer 的完成状态
   */
  static readonly AV_PLAYER_COMPLETED_STATE: string = 'completed';
  /**
   * Stopped state of avPlayer.
   * avPlayer 的停止状态
   */
  static readonly AV_PLAYER_STOPPED_STATE: string = 'stopped';
  /**
   * Release state of avPlayer.
   * avPlayer 的发布状态
   */
  static readonly AV_PLAYER_RELEASE_STATE: string = 'released';
  /**
   * Error state of avPlayer.
   * avPlayer 的错误状态
   */
  static readonly AV_PLAYER_ERROR_STATE: string = 'error';
  /**
   * 视频组件的hsp包名.
   */
  static readonly VIDEO_DETAIL_HSP_NAME: string = 'entry';
  /**
   * Current time of avPlayer.
   * avPlayer的当前时间
   */
  static readonly AV_PLAYER_CURRENT_TIME: string = 'currentTime';
  /**
   * Progress of av player.
   * avPlayer的进度
   */
  static readonly AV_PLAYER_PROGRESS: string = 'progress';
  /**
   * Total time of av player.
   * avPlayer的总时间
   */
  static readonly AV_PLAYER_TOTAL_TIME: string = 'totalTime';
  /**
   * Update time of av player.
   * avPlayer的更新的时间
   */
  static readonly AV_PLAYER_UPDATE_TIME: string = 'updateTime';
  /**
   * Initial time.
   * 初始化时间
   */
  static readonly INITIAL_TIME: string = '00:00:00';
  /**
   * One hundred for progress.
   * 进度条:100
   */
  static readonly PROGRESS_HUNDRED: number = 100;
  /**
   * One thousand for progress.
   * 进度条:1000
   */
  static readonly PROGRESS_THOUSAND: number = 1000;
  /**
   * Second in hour.
   * 一小时的秒数
   */
  static readonly SECOND_IN_HOUR: number = 3600;
  /**
   * Second in minute.
   * 一分钟的秒数
   */
  static readonly SECOND_IN_MINUTE: number = 60;
  /**
   * colon.
   * 冒号
   */
  static readonly COLON: string = ':';
  /**
   * Time prefix.
   * 时间前缀
   */
  static readonly TIME_PREFIX: string = '0';
  /**
   * Empty time.
   * 空时间
   */
  static readonly EMPTY_TIME: string = '00';
  /**
   * Zero.
   * 数字:0
   */
  static readonly ZERO: number = 0;
  /**
   * One.
   * 数字:1
   */
  static readonly ONE: number = 1;
  /**
   * Ten.
   * 数字:10
   */
  static readonly TEN: number = 10;

  //空行常用百分比
  static readonly SPACE_PERCENT : string = "4%"
  // 请求头路径
  static readonly REQUEST_URL : string = 'http://10.33.34.177:8800/admin/sysUser'

}