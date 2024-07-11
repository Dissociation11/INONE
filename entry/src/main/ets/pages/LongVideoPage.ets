import { LongFormCard } from '../component/LongFormCard';
import { LongFormModel, LongFormModelList } from '../model/LongFormModel';

@Entry
@Component
struct LongVideoPage {
  list : LongFormModel[] = LongFormModelList
  build() {
    Column(){
      LongFormCard({longFormModel:this.list.pop()})
    }
    .height('100%')
    .width('100%')
  }
}