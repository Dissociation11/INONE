import { RegisterView } from '../view/RegisterView'

@Entry
@Component
struct Register{


  build(){
    Column(){

      //注册View
      RegisterView()

    }.size({ height: "100%", width: "100%" })
  }
}


