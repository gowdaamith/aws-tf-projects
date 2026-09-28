output "launch_template_ids" {
  description = "map of the launch template ids" 
  value ={
    for key,launch_template in aws_launch_template.this:
    key => launch_template.id
  }
}

output "launch_template_name" {
  description ="map of the launch template name" 
  value = {
    for key,launch_template in aws_launch_template.this: 
    key => launch_template.name
  }
}


