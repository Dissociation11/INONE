import { ShortFormModel, ShortFormModelList } from '../model/ShortFormModel'

export class ShortFormViewModel{
  private formList : ShortFormModel[] = ShortFormModelList
  
  getShortFormList() : ShortFormModel[] {
    return this.formList
  }
  
}

export default new ShortFormViewModel()