import { CommonConstants } from '../commons/constants/CommonConstants'
import { AvPlayerUtil } from '../commons/utils/AvPlayerUtil'
import { ShortFormModel } from '../model/ShortFormModel'

@Component
export struct ShortFormCard{
  @Prop shortFormModel : ShortFormModel
  @Prop index : number
  @Prop @Watch("currentIndexChange") currentIndex : number
  updateTime: number = 0

  
  private xComponentController: XComponentController = new XComponentController()
  private surfaceId: string = ''
  private avPlayerUtil: AvPlayerUtil = new AvPlayerUtil()
  // @State currentTime : string|undefined = undefined
  // @State totalTime : string|undefined = undefined
  // @State duration : string|undefined|number = undefined
  @StorageLink("currentTime") currentTime: string = CommonConstants.INITIAL_TIME
  @StorageLink('totalTime') totalTime: string = CommonConstants.INITIAL_TIME
  @StorageLink('progress') progress: number = 0
  
  // @Prop avPlayerUtil: AvPlayerUtil
  
  currentIndexChange(){
    if (this.currentIndex===this.index) {
      // this.avPlayerUtil.setStartTime(this.updateTime);
      this.avPlayerUtil.seekToStart()
      this.avPlayerUtil.playerStateControl();
      this.avPlayerUtil.onTimeUpdate();
      this.avPlayerUtil.play()
    }
    else {
      this.avPlayerUtil.seekToStart()
      this.avPlayerUtil.pause();
      this.avPlayerUtil.offTimeUpdate();
    }
    console.log("当前位置"+this.currentIndex+",当前Index:"+this.index)
  }
  
  aboutToAppear() {
    
    this.avPlayerUtil.setStartTime(this.updateTime);
    console.log("aboutToAppear"+this.shortFormModel.title)
  }
  onPageShow(): void {
    this.avPlayerUtil.setStartTime(this.updateTime);
    this.avPlayerUtil.playerStateControl();
    this.avPlayerUtil.onTimeUpdate();
    this.avPlayerUtil.play()
    
  }
  initVideoInfo(){
    
  }
  
  onPageHide(): void {
    this.avPlayerUtil.pause();
    this.avPlayerUtil.offTimeUpdate();
    console.log("PageHide")
  }
  
  aboutToDisappear(): void {
    this.avPlayerUtil.release()
  }
  
  build() {
    Stack({ alignContent: Alignment.Bottom}){
      this.videoWindow()
      this.formAction()
      this.sliderBar()  
    }
    .height(CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
    .backgroundColor(Color.Black)
  }

  @Builder
  videoWindow(){
    Row(){
      XComponent({
        id:CommonConstants.VIDEO_DETAIL,
        type: XComponentType.SURFACE,
        controller:this.xComponentController
      })
        .backgroundColor("#00000000")
        .onLoad(()=>{
          this.xComponentController.setXComponentSurfaceSize({
            surfaceWidth:1920,
            surfaceHeight:1080
          })
          this.surfaceId = this.xComponentController.getXComponentSurfaceId()
          this.avPlayerUtil.createAvPlayer(this.surfaceId,false,this.shortFormModel.videoUrl)
        })
        .aspectRatio(CommonConstants.VIDEO_ASPECT_RATIO)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
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
  sliderBar(){
    Row(){
      TimeText({time:$currentTime})
        .margin({
          left:$r("app.float.total_time_text_left"),
          right:$r("app.float.total_time_text_right")
        })
      Slider({ min: 0, max: CommonConstants.PROGRESS_HUNDRED, step: 1, value: this.progress })
        .onChange((value: number, mode: SliderChangeMode) => {
          // this.slideCurrent = value
          this.avPlayerUtil.sliderChange(value, mode);
        })
        .layoutWeight(1)
        .selectedColor("#ED6F21")

      TimeText({ time: $totalTime })
        .margin({
          left: $r('app.float.total_time_text_left'),
          right: $r('app.float.total_time_text_right')
        })
    }
  }
  
}

@Component
@Preview
struct preview{
  build() {
    Column(){
      ShortFormCard()
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
  }
}

@Component
struct TimeText {
  @Link time: string;
  build() {
    Text(this.time)
      .fontSize($r('app.float.time_font'))
      .fontColor(Color.White)
      .lineHeight($r('app.float.time_text_line'))
      .width($r('app.float.time_text_width'))
  }
}