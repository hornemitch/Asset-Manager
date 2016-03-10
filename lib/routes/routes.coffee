###
  * * * * * * * * * * * * * *
    Routes for Iron Router
  * * * * * * * * * * * * * *
###

Router.configure {
  layoutTemplate: 'default_layout'
}

# * * Main Template Routes *  *
Router.route '/', {
  name: 'default'
  template:'home'
  fastRender:true
}
Router.route '/users', {
  name: 'checkUsers'
  template: 'users'
  fastRender:true
}
Router.route '/location', {
  name: 'locations'
  template: 'location'
  fastRender:true
}
Router.route '/location/create', {
  name: 'location.create'
  template: 'create_location'
  fastRender:true
}
Router.route '/login', {
  name: 'login'
  template: 'login'
  fastRender:true
}
Router.route '/register', {
  name: 'register'
  template: 'register'
  fastRender:true
}
Router.route '/register/company', {
  name: 'register.company'
  template: 'register_company'
  fastRender:true
}
Router.route '/reports', {
  name: 'reports'
  template: 'reports'
  fastRender:true
}
Router.route '/tutorial', {
  name: 'tutorial'
  template: 'tutorial'
  yieldRegions:
    'tutorial-body': to: 'tutorial'
  fastRender:true
}

# *  * Building Template Routes * *
Router.route '/buildings', {
  name:'buildings'
  template: 'building'
  fastRender:true
}
Router.route '/buildings/create', {
  name: 'building.add'
  template: 'create_building'
}
Router.route '/buildings/useful-life', {
  name: 'building.usefulLife'
  template: 'building_useful_life_update'
  waitOn : -> Meteor.subscribe 'usefulLife'
  data : -> UsefulLife.findOne(name:"Buildings")
  fastRender:true
}
Router.route '/buildings/details/:_id', {
  name: 'building.detail'
  template: 'read_building_details'
  waitOn : -> Meteor.subscribe 'building', @params._id
  data : -> Buildings.findOne(@params._id)
  fastRender:true
}
Router.route '/buildings/edit/:_id', {
  name: 'building.edit'
  template: 'update_building'
  waitOn : -> Meteor.subscribe 'building', @params._id
  data : -> Buildings.findOne(@params._id)
  fastRender:true
}
Router.route '/buildings/Revalue/:_id', {
  name: 'building.revalue'
  template: 'building_revalue'
  waitOn : -> Meteor.subscribe 'building', @params._id
  data : -> Buildings.findOne(@params._id)
  fastRender:true
}
Router.route '/buildings/Revalue/:_id/create', {
  name: 'building.revalue.add'
  template: 'building_revalue_create'
  waitOn : -> Meteor.subscribe 'building', @params._id
  data : -> Buildings.findOne(@params._id)
  fastRender:true
}
Router.route '/buildings/improve/:_id', {
  name: 'building.improve'
  template: 'building_improve'
  waitOn : -> Meteor.subscribe 'building', @params._id
  data : -> Buildings.findOne(@params._id)
  fastRender:true
}
Router.route '/buildings/improve/:_id/create', {
  name: 'building.improve.add'
  template: 'building_improve_create'
  waitOn : -> Meteor.subscribe 'building', @params._id
  data : -> Buildings.findOne(@params._id)
  fastRender:true
}
Router.route '/buildings/impair/:_id', {
  name: 'building.impair'
  template: 'building_impair'
  waitOn : -> Meteor.subscribe 'building', @params._id
  data : -> Buildings.findOne(@params._id)
  fastRender:true
}
Router.route '/buildings/impair/:_id/create', {
  name: 'building.impair.add'
  template: 'building_impair_create'
  waitOn : -> Meteor.subscribe 'building', @params._id
  data : -> Buildings.findOne(@params._id)
  fastRender:true
}

# * * Cellphone Template Routes  * *
Router.route '/cellphones', {
  name:'cellphones'
  template: 'cellphone'
  fastRender:true
}
Router.route '/cellphones/useful-life', {
  name: 'cellphone.usefulLife'
  template: 'cellphone_useful_life_update'
  waitOn: -> Meteor.subscribe 'usefulLife'
  data: -> UsefulLife.findOne(name: "Cellphones")
  fastRender:true
}
Router.route '/cellphones/create', {
  name: 'cellphone.create'
  template: 'create_cellphone'
  fastRender:true
}
Router.route '/cellphones/details/:_id', {
  name: 'cellphone.detail'
  template: 'read_cellphone_detail'
  waitOn : -> Meteor.subscribe 'cellphone', @params._id
  data : -> Cellphones.findOne(@params._id)
  fastRender:true
}
Router.route '/cellphones/edit/:_id', {
  name: 'cellphone.edit'
  template: 'update_cellphone'
  waitOn : -> Meteor.subscribe 'cellphone', @params._id
  data : -> Cellphones.findOne(@params._id)
  fastRender:true
}
Router.route '/cellphones/monthlies/:_id', {
  name: 'cellphone.monthly'
  template: 'cellphone_month'
  waitOn : -> Meteor.subscribe 'cellphone', @params._id
  data : -> Cellphones.findOne(@params._id)
  fastRender:true
}
Router.route '/cellphones/monthlies/:_id/subCreate', {
  name: 'cellphone.monthly.sub.add'
  template: 'cellphone_sub_month_create'
  waitOn : -> Meteor.subscribe 'cellphone', @params._id
  data : -> Cellphones.findOne(@params._id)
  fastRender:true
}
Router.route '/cellphones/monthlies/:_id/noSubCreate', {
  name: 'cellphone.monthly.noSub.add'
  template: 'cellphone_no_sub_month_create'
  waitOn : -> Meteor.subscribe 'cellphone', @params._id
  data : -> Cellphones.findOne(@params._id)
  fastRender:true
}
Router.route '/cellphones/monthlies/:_id/subDetails', {
  name: 'cellphone.monthly.sub.details'
  template: 'cellphone_sub_month_detail'
  waitOn : -> Meteor.subscribe 'cellphone_monthly', @params._id
  data : -> Cellphone_Monthly.findOne(@params._id)
  fastRender:true
}
Router.route '/cellphones/monthlies/:_id/noSubDetails', {
  name: 'cellphone.monthly.noSub.details'
  template: 'cellphone_no_sub_month_detail'
  waitOn : -> Meteor.subscribe 'cellphone_monthly', @params._id
  data : -> Cellphone_Monthly.findOne(@params._id)
  fastRender:true
}

#***Computers***
Router.route '/computers', {
  name:'computers'
  template: 'computer'
  fastRender:true
}
Router.route '/computers/useful-life', {
  name: 'computer.usefulLife'
  template: 'computer_useful_life_update'
  waitOn: -> Meteor.subscribe 'usefulLife'
  data: -> UsefulLife.findOne(name: "Computers")
  fastRender:true
}
Router.route '/computers/create', {
  name: 'computer.create'
  template: 'create_computer'
  fastRender:true
}
Router.route '/computers/details/:_id', {
  name: 'computer.detail'
  template: 'read_computer_detail'
  waitOn : -> Meteor.subscribe 'computer', @params._id
  data : -> Computers.findOne(@params._id)
  fastRender:true
}
Router.route '/computers/edit/:_id', {
  name: 'computer.edit'
  template: 'update_computer'
  waitOn : -> Meteor.subscribe 'computer', @params._id
  data : -> Computers.findOne(@params._id)
  fastRender:true
}
Router.route '/computers/software/:_id', {
  name: 'computer.software'
  template: 'computer_software'
  waitOn : -> Meteor.subscribe 'computer', @params._id
  data : -> Computers.findOne(@params._id)
  fastRender:true
}
Router.route '/computers/software/:_id/detail', {
  name: 'computer.software.detail'
  template: 'computer_software_detail'
  waitOn : -> Meteor.subscribe 'computer_software', @params._id
  data : -> Computer_Software.findOne(@params._id)
  fastRender:true
}
Router.route '/computers/software/:_id/create', {
  name: 'computer.software.add'
  template: 'computer_software_create'
  waitOn : -> Meteor.subscribe 'computer', @params._id
  data : -> Computers.findOne(@params._id)
  fastRender:true
}
Router.route '/computers/software/:_id/update', {
  name: 'computer.software.update'
  template: 'computer_software_update'
  waitOn : -> Meteor.subscribe 'computer_software', @params._id
  data : -> Computer_Software.findOne(@params._id)
  fastRender:true
}
Router.route '/computers/software/:_id/useful-life', {
  name: 'computer.software.life'
  template: 'computer_software_useful_life'
  waitOn : -> Meteor.subscribe 'usefulLife'
  data : -> UsefulLife.findOne(name: "Software")
  fastRender:true
}

#***Furniture***
Router.route '/furniture', {
  name:'furniture'
  template: 'furniture'
  fastRender:true
}
Router.route '/furniture/useful-life', {
  name: 'furniture.usefulLife'
  template: 'furniture_useful_life_update'
  waitOn: -> Meteor.subscribe 'usefulLife'
  data: -> UsefulLife.findOne(name: "Furniture")
  fastRender:true
}
Router.route '/furniture/create', {
  name: 'furniture.create'
  template: 'create_furniture'
  fastRender:true
}
Router.route '/furniture/details/:_id', {
  name: 'furniture.detail'
  template: 'read_furniture_detail'
  waitOn : -> Meteor.subscribe 'furn', @params._id
  data : -> Furniture.findOne(@params._id)
  fastRender:true
}
Router.route '/furniture/edit/:_id', {
  name: 'furniture.edit'
  template: 'update_furniture'
  waitOn : -> Meteor.subscribe 'furn', @params._id
  data : -> Furniture.findOne(@params._id)
  fastRender:true
}

#***Machinery***
Router.route '/machinery', {
  name:'machinery'
  template: 'machinery'
  fastRender:true
}

Router.route '/machine/create', {
  name: 'machine.create'
  template: 'create_machinery'
  fastRender:true
}
Router.route '/machine/details/:_id', {
  name: 'machine.detail'
  template: 'read_machinery_detail'
  waitOn : -> Meteor.subscribe 'machine', @params._id
  data : -> Machinery.findOne(@params._id)
  fastRender:true
}
Router.route '/machine/edit/:_id', {
  name: 'machine.edit'
  template: 'update_machinery'
  waitOn : -> Meteor.subscribe 'machine', @params._id
  data : -> Machinery.findOne(@params._id)
  fastRender:true
}
Router.route '/machine/month/:_id', {
  name: 'machine.month'
  template: 'machine_month'
  waitOn : -> Meteor.subscribe 'machine', @params._id
  data : -> Machinery.findOne(@params._id)
  fastRender:true
}
Router.route '/machine/month/:_id/create', {
  name: 'machine.month.add'
  template: 'machine_month_create'
  waitOn : -> Meteor.subscribe 'machine', @params._id
  data : -> Machinery.findOne(@params._id)
  fastRender:true
}
Router.route '/machine/category/create', {
  name: 'machine.category.create'
  template: 'machine_category_create'
  fastRender:true
}
Router.route '/machine/category', {
  name: 'machine.category'
  template: 'machine_category'
  fastRender:true
}
Router.route '/machine/category/edit/:_id', {
  name: 'machine.category.edit'
  template: 'update_machine_category'
  waitOn : -> Meteor.subscribe 'machine_category', @params._id
  data : -> Machine_Category.findOne(@params._id)
  fastRender:true
}

#***Small Tools***
Router.route '/tools', {
  name:'tools'
  template: 'tool'
  fastRender:true
}

Router.route '/tool/create', {
  name: 'tool.create'
  template: 'create_tool'
  fastRender:true
}
Router.route '/tool/details/:_id', {
  name: 'tool.detail'
  template: 'read_tool_detail'
  waitOn : -> Meteor.subscribe 'tool', @params._id
  data : -> Tools.findOne(@params._id)
  fastRender:true
}
Router.route '/tool/edit/:_id', {
  name: 'tool.edit'
  template: 'update_tool'
  waitOn : -> Meteor.subscribe 'tool', @params._id
  data : -> Tools.findOne(@params._id)
  fastRender:true
}
Router.route '/tool/bookout/:_id', {
  name: 'tool.bookout'
  template: 'tool_bookout'
  waitOn : -> Meteor.subscribe 'tool', @params._id
  data : -> Tools.findOne(@params._id)
  fastRender:true
}
Router.route '/tool/category', {
  name: 'tool.category'
  template: 'tool_category'
  fastRender:true
}
Router.route '/tool/category/create', {
  name: 'tool.category.create'
  template: 'tool_category_create'
  fastRender:true
}
Router.route '/tool/category/edit/:_id', {
  name: 'tool.category.edit'
  template: 'update_tool_category'
  waitOn : -> Meteor.subscribe 'tool_category', @params._id
  data : -> Tool_Category.findOne(@params._id)
  fastRender:true
}

#***Vehicles***
Router.route '/vehicles', {
  name:'vehicles'
  template: 'vehicle'
  fastRender:true
}
Router.route '/vehicle/category', {
  name: 'vehicle.category'
  template: 'vehicle_category'
  fastRender:true
}
Router.route '/vehicle/category/create', {
  name: 'vehicle.category.create'
  template: 'vehicle_category_create'
  fastRender:true
}
Router.route '/vehicle/category/edit/:_id', {
  name: 'vehicle.category.edit'
  template: 'update_vehicle_category'
  waitOn : -> Meteor.subscribe 'vehicle_category', @params._id
  data : -> Vehicle_Category.findOne(@params._id)
  fastRender:true
}
Router.route '/vehicle/create', {
  name: 'vehicle.create'
  template: 'create_vehicle'
  fastRender:true
}
Router.route '/vehicle/details/:_id', {
  name: 'vehicle.detail'
  template: 'read_vehicle_detail'
  waitOn : -> Meteor.subscribe 'vehicle', @params._id
  data : -> Vehicles.findOne(@params._id)
  fastRender:true
}
Router.route '/vehicle/edit/:_id', {
  name: 'vehicle.edit'
  template: 'update_vehicle'
  waitOn : -> Meteor.subscribe 'vehicle', @params._id
  data : -> Vehicles.findOne(@params._id)
  fastRender:true
}
Router.route '/vehicle/daily/:_id', {
  name: 'vehicle.daily'
  template: 'vehicle_daily'
  waitOn : -> Meteor.subscribe 'vehicle', @params._id
  data : -> Vehicles.findOne(@params._id)
  fastRender:true
}
Router.route '/vehicle/daily/:_id/create', {
  name: 'vehicle.daily.add'
  template: 'vehicle_daily_create'
  waitOn : -> Meteor.subscribe 'vehicle', @params._id
  data : -> Vehicles.findOne(@params._id)
  fastRender:true
}

# *  * Report Template Routes * *
Router.route '/overviewCostReport', {
  name:'overviewCostReport'
  template: 'overview_cost'
  fastRender:true
}
Router.route '/overviewCostReport/print', {
  name:'overviewCostReportPrint'
  template: 'overview_cost_print'
  fastRender:true
}
Router.route '/buildingReport', {
  name:'buildingReport'
  template: 'building_report'
  fastRender:true
}
Router.route '/buildingReport/print', {
  name:'buildingReportPrint'
  template: 'building_report_print'
  fastRender:true
}
Router.route '/cellphoneReport', {
  name:'cellphoneReport'
  template: 'cellphone_report'
  fastRender:true
}
Router.route '/cellphoneReport/print', {
  name:'cellphoneReportPrint'
  template: 'cellphone_report_print'
  fastRender:true
}
Router.route '/computerReport', {
  name:'computerReport'
  template: 'computer_report'
  fastRender:true
}
Router.route '/computerReport/print', {
  name:'computerReportPrint'
  template: 'computer_report_print'
  fastRender:true
}
Router.route '/furnitureReport', {
  name:'furnitureReport'
  template: 'furniture_report'
  fastRender:true
}
Router.route '/furnitureReport/print', {
  name:'furnitureReportPrint'
  template: 'furniture_report_print'
  fastRender:true
}
Router.route '/machineryReport', {
  name:'machineryReport'
  template: 'machinery_report'
  fastRender:true
}
Router.route '/machineryReport/print', {
  name:'machineryReportPrint'
  template: 'machinery_report_print'
  fastRender:true
}
Router.route '/toolReport', {
  name:'toolReport'
  template: 'tool_report'
  fastRender:true
}
Router.route '/toolReport/print', {
  name:'toolReportPrint'
  template: 'tool_report_print'
  fastRender:true
}
Router.route '/vehicleReport', {
  name:'vehicleReport'
  template: 'vehicle_report'
  fastRender:true
}
Router.route '/vehicleReport/print', {
  name:'vehicleReportPrint'
  template: 'vehicle_report_print'
  fastRender:true
}