import { AvPlayerUtil } from '../commons/utils/AvPlayerUtil'
import { ShortFormCard } from '../component/ShortFormCard'
import { ShortFormCardVideo } from '../component/ShortFormCardVideo'
import { ShortFormModel, ShortFormModelList } from '../model/ShortFormModel'

@Component
export struct ShortFormView{
  
  @State currentSelect:number = 0
  build() {
    Swiper(){
      ForEach(ShortFormModelList,(item:ShortFormModel,index)=>{
        // ShortFormCard({shortFormModel:item,index:index,currentIndex:this.currentSelect})
        ShortFormCardVideo({shortFormModel:item,index:index,currentIndex:this.currentSelect})
      })
    }
    .onChange((index:number)=>{
      this.currentSelect = index
    })
    .autoPlay(false)
    .indicator(false)
    .vertical(true)
  }
}