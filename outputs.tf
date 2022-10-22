# Output for folder id 
output "ids" {
  description = "Folder id"
  value       = split("/",data.google_active_folder.parent-name.id)[1]

}