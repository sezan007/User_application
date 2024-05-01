import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox-select-all"
export default class extends Controller {
  static targets = ["parent", "child","child01"]

  connect() {

    this.parentTarget.checked = false
    this.childTargets.map(x => x.checked = false)
    this.child01Targets.map(y => y.checked = false)
    // this.child01Targets.map(y => y.hidden = true)
  }
  toggleChildren()
  {
    if (this.parentTarget.checked)
    {
      this.childTargets.map(s =>s.checked=true)
      this.child01Targets.map(s =>s.checked=true)
    }
    else
    {
      this.childTargets.map(s =>s.checked=false)
      this.child01Targets.map(s =>s.checked=false)
    }
    
  }

  toggleParent()
   {
    const isAnyChildUnchecked = this.childTargets.some(child => !child.checked);
    // if (this.childTargets.map(x => x.checked).includes(false)) {
    //   this.parentTarget.checked = false
    // } 
    // else {
    //   this.parentTarget.checked = true
    // }
    this.parentTarget.checked = !isAnyChildUnchecked;
    // this.child01Targets.forEach((child, index) => {
    //   child.checked = this.childTargets[index].checked;
    // });
  }
}
