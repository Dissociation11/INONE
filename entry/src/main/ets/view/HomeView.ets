import { DefaultCard } from '../component/DefaultCard'
import { DefaultSwiper } from '../component/HomeSwiper'
import { LongFormModel, LongFormModelList } from '../model/LongFormModel'

import { router } from '@kit.ArkUI'
import  LongForm  from '../model/LongFormModel'
import { LongFormData, LongFormResponse } from '../model/LongFormResponse'

@Component
export struct HomeView{
  @State list : LongFormModel[] = []
  swiperController: SwiperController = new SwiperController()
  // 卡片信息
  @State clickCardId : number = -1
  @State cardWidth : Length = 0
  @State cardHeight : Length = 0
  @State cardPosition_x : Length|undefined = 0
  @State cardPosition_y : Length|undefined = 0
  @State cardGlobalPosition_x : Length|undefined = 0
  @State cardGlobalPosition_y : Length|undefined = 0
  @State requestDataList : LongFormData[] = []

  async aboutToAppear(): Promise<void> {
    console.log(`test:apear`)
    this.list = await LongForm.getLongFormList()
    console.log(`info:: ${JSON.stringify(this.list)}`)
  }
  
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
                    let paramInfo : LongFormModel = video
                    router.pushUrl({
                      url:"pages/LongVideoPage",
                      params:paramInfo
                    },router.RouterMode.Standard,(err)=>{
                      if (err) {
                        console.log(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`)
                        return;
                      }
                      console.info('Invoke pushUrl succeeded.');
                    })
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
