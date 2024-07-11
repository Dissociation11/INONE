import { DefaultCard } from '../component/DefaultCard'
import { DefaultSwiper } from '../component/HomeSwiper'
import { LongFormModel, LongFormModelList } from '../model/LongFormModel'
import { router } from '@kit.ArkUI'

@Component
export struct HomeView{
  private list : LongFormModel[] = LongFormModelList
  swiperController: SwiperController = new SwiperController()
  // 卡片信息
  @State clickCardId : number = -1
  @State cardWidth : Length = 0
  @State cardHeight : Length = 0
  @State cardPosition_x : Length|undefined = 0
  @State cardPosition_y : Length|undefined = 0
  @State cardGlobalPosition_x : Length|undefined = 0
  @State cardGlobalPosition_y : Length|undefined = 0
  build() {
    Column(){
      this.CardList()
    }
  }
  @Builder CardList(){
    Column() {
      List({ space: 10 }) {
        ListItem(){
          DefaultSwiper()
        }
        ListItem(){
          List(){
            ForEach(this.list, (video: LongFormModel, index: number) => {
              ListItem() {
                DefaultCard({ title: video.title, ImageUrl: video.imageUrl, description: video.description,cardId:index})

                  .animation({duration:200})
                  .onClick((event:ClickEvent) => {
                    console.log("x position："+event.windowX)
                    console.log("y position："+event.windowY)
                  })
              }
            })
          }
          .alignListItem(ListItemAlign.Center)
          .width("100%")
          .lanes(2)
        }

      }
      .alignListItem(ListItemAlign.Center)
      .layoutWeight(1)
      .width("100%")
    }
    .justifyContent(FlexAlign.Start)
    .zIndex(this.clickCardId===-1?2:0)
  }
  
}
