import { CommonConstants } from '../commons/constants/CommonConstants'
import { LongFormModel, LongFormModelList } from '../model/LongFormModel'
import { router } from '@kit.ArkUI'

@Component
export struct LongFormCard{
  videoController : VideoController = new VideoController()
  @Prop longFormModel : LongFormModel
  @State speed : number = 1
  @State isPlay : boolean = true
  @State duration : number|undefined = 0
  @State currentTime : number|undefined = 0
  @State ifSliderShow: boolean = false
  @State ifToolShow: boolean = false
  build() {
    Column(){
      Stack({alignContent:Alignment.TopStart}){
        
        Video({
          controller:this.videoController,
          src:this.longFormModel.videoUrl.includes("http")?this.longFormModel.videoUrl:$rawfile(this.longFormModel.videoUrl),
          currentProgressRate: this.speed
        })
          .onFinish(()=>{
            this.videoController.reset()
          })
          .autoPlay(true)
          .controls(false)  //隐藏控制器
          .width("100%")
          .height(250)
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
          .gesture(GestureGroup(GestureMode.Exclusive,
            
            TapGesture({count:2})
              .onAction(()=>{
                if (this.isPlay) {
                  this.videoController.pause()
                }
                else {
                  this.videoController.start()
                }
                this.isPlay = !this.isPlay
              }),
            LongPressGesture()
              .onAction(()=>{
              this.speed = 3
                console.log("LongPress")
              })
              .onActionEnd(()=>{
                this.speed = 1
              })
              .onActionCancel(()=>{
                this.speed = 1
              })
          ))
        if (this.ifToolShow) {
          this.TopTool()
          this.sliderBar()
        }
      }
      .gesture(GestureGroup(GestureMode.Exclusive,
        TapGesture({count:1})
          .onAction(()=>{
            this.ifToolShow = !this.ifToolShow
          })
      ))
      Scroll(){
        Tabs(){
          TabContent(){
            Text("this is description")
          }
            .tabBar("简介")
          TabContent(){
            Text("this is comment")
          }
            .tabBar("评论")
        }
      }
    }
  }
  
  @Builder
  TopTool(){
    Row(){
      Image($r("app.media.back_white"))
        .width(20)
        .height(20)
        .margin({left:5,top:5})
        .onClick(()=>{
          router.back()
        })
    }
    .height(30)
    .width(CommonConstants.FULL_PERCENT)
    .linearGradient({angle:180,colors:[["#ae000000",0],["#25000000",1]]})
  }

  @Builder
  sliderBar(){
    Row(){
      
      TimeText({time:this.currentTime})
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
        .selectedColor($r("app.color.SYSTEM_BASE_COLOR"))
        .layoutWeight(1)
        .blockSize({width:5,height:5})

      TimeText({ time: this.duration})
        .margin({
          left: $r('app.float.total_time_text_left'),
          right: $r('app.float.total_time_text_right')
        })
    }
    .linearGradient({angle:180,colors:[["#25000000",0],["#ae000000",1]]})
    .margin({top:210})
  }
  
}

@Preview
@Component
struct pre{
  list : LongFormModel[] = LongFormModelList
  build() {
    Column(){
      LongFormCard({longFormModel:this.list.pop()})
    }
    .width("100%")
    .height("100%")
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