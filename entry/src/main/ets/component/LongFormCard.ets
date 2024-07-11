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
          src:this.longFormModel.videoUrl,
          currentProgressRate: this.speed
        })
          .width("100%")
          .height(250)
          .gesture(GestureGroup(GestureMode.Exclusive,
            TapGesture({count:1})
              .onAction(()=>{
                this.ifToolShow = !this.ifToolShow
              })
          ))
        if (this.ifToolShow) {
          this.TopTool()
          this.sliderBar()
        }
      }
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
    .shadow({radius:2,fill:true})
  }

  @Builder
  sliderBar(){
    Row(){
      TimeText({time:this.currentTime})
        .margin({
          left:$r("app.float.total_time_text_left"),
          right:$r("app.float.total_time_text_right")
        })
      Slider({ min: 0, max: CommonConstants.PROGRESS_HUNDRED, step: 1, value: this.currentTime })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.currentTime = value

        })
        .layoutWeight(1)
        .selectedColor("#ED6F21")

      TimeText({ time: this.duration})
        .margin({
          left: $r('app.float.total_time_text_left'),
          right: $r('app.float.total_time_text_right')
        })
    }
    .margin({top:210})
    .shadow({radius:2,fill:true})
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
    Text(this.formatTime(this.time))
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