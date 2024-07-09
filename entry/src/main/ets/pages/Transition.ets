import { router } from '@kit.ArkUI'

@Entry
@Component
struct Transition{

  aboutToAppear(): void {
    setTimeout(() => {
      this.jump()
    },3000)
  }

  jump(){
    router.pushUrl({
      url:"pages/MainPage"
    })
  }

  build() {
    Column(){
        Column(){
          Text('正在努力加载中...')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.LOGIN_COLOR'))

          LoadingProgress()
            .color($r('app.color.LOGIN_COLOR'))
            .width(50)
            .margin({ top: 10 })
        }
        .margin({ top: 300 })
        .width('100%')
      .height('100%')
    }.width('100%')
    .height('100%')
  }
}