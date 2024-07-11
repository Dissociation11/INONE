import { LongFormCard } from '../component/LongFormCard';
import { LongFormModel, LongFormModelList } from '../model/LongFormModel';
import { router } from '@kit.ArkUI';
import { LongFormData } from '../model/LongFormResponse';

@Entry
@Component
struct LongVideoPage {
  list : LongFormModel[] = LongFormModelList
  private params = router.getParams() as LongFormModel
  build() {
    Column(){
      LongFormCard({longFormModel:this.params})
    }
    .height('100%')
    .width('100%')
  }
}