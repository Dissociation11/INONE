
import { curves, router } from '@kit.ArkUI'
import { LongFormModel } from '../model/LongFormModel'

@Component
export struct DefaultCard {
  @Prop video: LongFormModel
  @Prop ImageUrl: string // 图片url
  @Prop title: string // 标题
  @Prop description: string // 描述
  @Prop cardId:number
  @Prop ImageRadiusValue: number
  @State private cardHeight: number = 120
  @State private cardWidth: number = 150
  @State private fontSize: number = 16

  @State start_x :number = 0
  @State start_y :number = 0
  @State cardZIndex : number = 2
  build() {

      Column() {
        Row() {
          Image( this.ImageUrl.includes("http")?this.ImageUrl:$r(this.ImageUrl))
            .width("100%")
            .borderRadius(10)
        }
        .backgroundColor("#ff0000")
        .width(this.cardWidth)
        .height(80)
        .borderRadius(10)

        Column() {
          Text(this.title)
            .fontSize(this.fontSize)
            .fontColor("#000000")
          Text(Number.isNaN(this.cardId)?"":this.description)
            .fontSize(this.fontSize - 2)
            .fontColor("#a79e9e")
        }
        .width("100%")
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
      .width(this.cardWidth)
      .height(this.cardHeight)
      .margin(5)
      .clip(true)
      .onTouch((event?:TouchEvent) => {
        animateTo({ curve: curves.springMotion() }, () => {
          if (event?.type===TouchType.Down) {
            console.log("down touch:")
            this.cardHeight = this.cardHeight * 0.95
            this.cardWidth = this.cardWidth * 0.95
            this.fontSize = this.fontSize * 0.95
          }
          if (event?.type===TouchType.Up) {
            console.log("up touch")
            this.cardHeight = this.cardHeight / 0.95
            this.cardWidth = this.cardWidth / 0.95
            this.fontSize = this.fontSize / 0.95
          }
          console.log(event?.type.toString())
        })
      })

  }
}