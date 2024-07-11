import { LongFormModel, LongFormModelList } from '../model/LongFormModel'
import { router } from '@kit.ArkUI'

@Component

export struct DefaultSwiper {
  private swiperController: SwiperController = new SwiperController()
  private list : LongFormModel[] = LongFormModelList
  private mapData: SwiperData = new SwiperData(this.list)
  build() {
    Swiper() {
      LazyForEach(this.mapData, (item: LongFormModel) => {
        Stack() {
          Image($r(item.imageUrl))
          Text(item.title)
            .fontColor("#ffffff")
            .height(10)
            .margin({ right: 20, bottom: 20 })
        }
        .alignContent(Alignment.BottomEnd)
        .onClick(() => {
          
        })
      })
    }
    .loop(true)
    .autoPlay(true)
    .interval(5000)
    .displayArrow(true, false)
    .width("100%")
    .height(200)
    .indicator(
      Indicator.dot()
        .left(0)
        .color("#ff9b8c8c")
        .selectedColor(Color.White)
    )
  }
}
class SwiperData implements IDataSource{
  private list : LongFormModel [] = []

  constructor(list : LongFormModel[]) {
    this.list = list
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): LongFormModel {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {

  }

  unregisterDataChangeListener(listener: DataChangeListener): void {

  }

}