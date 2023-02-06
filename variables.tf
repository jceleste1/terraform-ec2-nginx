variable "iam_id" {
  type        = string
  description = "Descrição da imagem a ser utilizada no ec2 !!"
}

variable "instance_type" {
  type        = string
  description = "tipo de instancia"
}


variable "vpc_id" {
  type        = string
  description = "Id da VPC"
}