# Creation of parent folder under organization
module "parent_folder" {
  source  = "terraform-google-modules/folders/google//examples/simple_example"
  version = "3.1.0"
  parent_id = "469597723868"
  parent_type = "organizations"
  names = ["Parent"]
}

# Getting the parent folder ID 
data "google_active_folder" "parent-name" {
  display_name = "Parent"
  parent       = "organizations/469597723868"

  depends_on = [
    module.parent_folder.names
  ]
}

# Creation of child folder under parent folder
module "child-folder" {
  source  = "terraform-google-modules/folders/google//examples/simple_example"
  version = "3.1.0"
  parent_id = split("/",data.google_active_folder.parent-name.id)[1] 
  parent_type = "folders"
  names = ["Child"]

    depends_on = [
    module.parent_folder.names
  ]
}

# Getting the child folder ID
data "google_active_folder" "child-name" {
  display_name = "Child"
  parent = "folders/${split("/",data.google_active_folder.parent-name.id)[1]}"

  depends_on = [
    module.child-folder.names
  ]
}

# Creating project under child folder 
resource "google_project" "my_project-in-a-folder" {
  name       = "test-project"
  project_id = "kgkafalian-testproject-tf"
  folder_id  = split("/",data.google_active_folder.child-name.id)[1]

    depends_on = [
    module.child-folder.names
  ]
}