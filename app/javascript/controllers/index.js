import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import Select2Controller from "./select2_controller"
application.register("select2", Select2Controller)
