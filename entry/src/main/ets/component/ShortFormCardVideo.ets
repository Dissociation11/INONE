import { CommonConstants } from '../commons/constants/CommonConstants'
import { AvPlayerUtil } from '../commons/utils/AvPlayerUtil'
import { ShortFormModel } from '../model/ShortFormModel'

@Component
export struct ShortFormCardVideo{
  @Prop shortFormModel : ShortFormModel
  @Prop index : number
  @Prop @Watch("currentIndexChange") currentIndex : number
  videoController : VideoController = new VideoController()
  @State isPlay : boolean = true
  @State speed : number = 1
  @State duration : number = 0
  @State currentTime : number|undefined = 0
  @State ifSliderShow: boolean = false
  currentIndexChange(){
    if (this.currentIndex===this.index) {
      // this.avPlayerUtil.setStartTime(this.updateTime);
      this.videoController.setCurrentTime(0)
      this.currentTime = 0
      this.videoController.start()
    }
    else {
      this.videoController.pause()
    }
    console.log("当前位置"+this.currentIndex+",当前Index:"+this.index)
  }
  
  
  build() {
    Stack({ alignContent: Alignment.Bottom}){
      Text(this.speed !== 1 ? "加速中":"")
        .fontSize(50)
        .fontColor(Color.White)
      Video({
        controller:this.videoController,
        src:$rawfile(this.shortFormModel.videoUrl),
        currentProgressRate : this.speed
      })
        .width(CommonConstants.FULL_PERCENT)
        .autoPlay(true) //开启自动播放
        .controls(false)  //隐藏控制器
        .objectFit(ImageFit.Contain)
        .onUpdate((e?: TimeObject)=>{
          this.currentTime = e?.time
        })
        .onPrepared((e?: DurationObject)=>{
          if (e?.duration!==undefined) {
            this.duration = e.duration
            console.log("duration+"+this.duration)
            this.ifSliderShow = true
          }
          
        })
      this.formAction()
      this.videoInformation()
      if (this.ifSliderShow){
        this.sliderBar()
      }
      
    }
    .gesture(
      GestureGroup(GestureMode.Exclusive,
        TapGesture({count:2}).onAction(()=>{
          if (this.isPlay) {
            this.videoController.pause()
          }
          else {
            this.videoController.start()
          }
          this.isPlay = !this.isPlay
        }),
        LongPressGesture().onAction(()=>{
          this.speed = 3
        })
          .onActionEnd(()=>{
            this.speed = 1
          })
          .onActionCancel(()=>{
            this.speed = 1
          })
      )
    )
    .height(CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
    .backgroundColor(Color.Black)
  }
  @Builder
  formAction(){
    //操作
    Column(){
      Image($r('app.media.like'))
        .width(30)
        .height(30)
      Text("999")
        .fontColor(Color.White)
        .margin({ bottom:10 })
      Image($r('app.media.comment'))
        .width(30)
        .height(30)
      Text('10000')
        .fontColor(Color.White)
        .margin({ bottom:10 })
      Image($r('app.media.share'))
        .width(30)
        .height(30)
      Text("99")
    }.width('100%')
    .height('100%')
    .margin({ right: 20 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.End)
  }
  @Builder
  videoInformation(){
    Column(){
      Text(this.shortFormModel.author)
        .fontColor(Color.White)
        .fontSize(20)
      Text(this.shortFormModel.description)
        .fontColor(Color.White)
        .fontSize(16)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
    }.width('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .margin({left:15,bottom:35})
  }
  @Builder
  sliderBar(){
    Row(){
      TimeText({time:(this.currentTime)})
        .margin({
          left:$r("app.float.total_time_text_left"),
          right:$r("app.float.total_time_text_right")
        })
      Slider({ min: 0, max: this.duration, step: 0.1, value: this.currentTime })
        .onChange((value: number, mode: SliderChangeMode) => {
          if (this.duration!==undefined)
          {
            this.videoController.setCurrentTime(value)
            this.videoController.start()
          }
        })
        .blockSize({width:5,height:5})
        .layoutWeight(1)
        .selectedColor("#ED6F21")

      TimeText({ time: this.duration})
        .margin({
          left: $r('app.float.total_time_text_left'),
          right: $r('app.float.total_time_text_right')
        })
    }
    
  }
  
  
  
}
interface DurationObject {
  duration: number;
}

interface TimeObject {
  time: number;
}
@Component
struct TimeText {
  @Prop time: number;
  build() {
    Text(this.formatTime(Number.parseInt(this.time.toString())))
      .fontSize($r('app.float.time_font'))
      .fontColor(Color.White)
      .lineHeight($r('app.float.time_text_line'))
      .width($r('app.float.time_text_width'))
  }
  formatTime(duration: number): string {
    // let totalSecond: number = Math.round(duration / CommonConstants.PROGRESS_HUNDRED);
    
    let hourNum: number = Math.floor(duration / CommonConstants.SECOND_IN_HOUR);
    let minNum: number = Math.floor((duration % CommonConstants.SECOND_IN_HOUR) / CommonConstants.SECOND_IN_MINUTE);
    let secNum: number = (duration % CommonConstants.SECOND_IN_HOUR) % CommonConstants.SECOND_IN_MINUTE;
    let timeFormat : string = this.formatUnitTime(hourNum) + CommonConstants.COLON + this.formatUnitTime(minNum) + CommonConstants.COLON +
    this.formatUnitTime(secNum)
    console.log("format:"+duration+"---"+timeFormat)
    return timeFormat;
    
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