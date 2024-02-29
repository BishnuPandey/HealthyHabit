import { Controller } from "@hotwired/stimulus"
import {toggle} from "el-transition"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = [ "mobileMenu", "desktopMenu" ]
  connect() {
    console.log("menu controller connected")
  }

  toggleDesktopMenu(){
    //this.desktopMenuTarget.classList.toggle("hidden");
    toggle(this.desktopMenuTarget)
  }

  toggleMobileMenu(){
    //this.mobileMenuTarget.classList.toggle("hidden");
    toggle(this.mobileMenuTarget)
  }
}
