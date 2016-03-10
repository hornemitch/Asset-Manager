###
  * * * * * * * * * * * * * * * * *
    Main Collection Declarations
  * * * * * * * * * * * * * * * * *
###

@Buildings         = new Mongo.Collection 'buildings'
@Cellphones        = new Mongo.Collection 'cellphones'
@Computers         = new Mongo.Collection 'computers'
@Furniture         = new Mongo.Collection 'furniture'
@Locations         = new Mongo.Collection 'locations'
@Machinery         = new Mongo.Collection 'machinery'
@Tools             = new Mongo.Collection 'tools'
@UsefulLife        = new Mongo.Collection 'usefulLife'
@Vehicles          = new Mongo.Collection 'vehicles'

###
  * * * * * * * * * * * * * * * *
    Sub Collection Declarations
  * * * * * * * * * * * * * * * *
###

@Building_Impairment  = new Mongo.Collection 'building_impairment'
@Building_Improvement = new Mongo.Collection 'building_improvement'
@Building_Revaluation = new Mongo.Collection 'building_revaluation'
@Companies            = new Mongo.Collection 'companies'
@Cellphone_Monthly    = new Mongo.Collection 'cellphone_monthly'
@Computer_Software    = new Mongo.Collection 'computer_software'
@Machine_Category     = new Mongo.Collection 'machine_category'
@Machine_Monthly      = new Mongo.Collection 'machine_monthly'
@Tool_Category        = new Mongo.Collection 'tool_category'
@Vehicle_Category     = new Mongo.Collection 'vehicle_category'
@Vehicle_Daily        = new Mongo.Collection 'vehicle_daily'