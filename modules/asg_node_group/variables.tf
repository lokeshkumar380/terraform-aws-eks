variable "cluster_config" {
  type = object({
    name                  = string
    k8s_version           = string
    vpc_id                = string
    private_subnet_ids    = map(string)
    node_security_group   = string
    node_instance_profile = string
  })
}

variable "root_volume_size" {
  type        = number
  default     = 20
  description = "Volume size for the root partition. Value in GiB."
}

variable "docker_volume_size" {
  type        = number
  default     = 20
  description = "Volume size for the docker volume. Value in GiB."
}

variable "group_size" {
  type        = number
  default     = 6
  description = "The maximum number of instances that will be launched by this group"
}

variable "asg_min_size" {
  type        = number
  default     = 0
  description = "The minimum number of instances in each ASG, should only be needed if not using cluster autoscaler or bootstapping"
}

variable "instance_size" {
  type        = string
  default     = "large"
  description = "The size of instances in this node group"
}

variable "instance_family" {
  type        = string
  default     = "general_purpose"
  description = "The family of instances that this group will launch, should be one of: memory_optimized, general_purpose or compute_optimized. Defaults to general_purpose"
}

variable "instance_lifecycle" {
  type        = string
  default     = "spot"
  description = "The lifecycle of instances managed by this group, should be 'spot' or 'on_demand'."
}

variable "spot_allocation_strategy" {
  type        = string
  default     = "lowest-price"
  description = "How to allocate capacity across the Spot pools. Valid values: 'lowest-price' or 'capacity-optimized'."
}

variable "cloud_config_extra" {
  type        = list(string)
  default     = []
  description = "Provide additional cloud-config(s), will be merged with the default config"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels that will be added to the kubernetes node. A qualified name must consist of alphanumeric characters, '-', '_' or '.', and must start and end with an alphanumeric character (e.g. 'MyName',  or 'my.name',  or '123-abc', regex used for validation is '([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9]') with an optional DNS subdomain prefix and '/' (e.g. 'example.com/MyName')"
  # TODO: add custom validation rule once the feature is stable https://www.terraform.io/docs/configuration/variables.html#custom-validation-rules
}

variable "taints" {
  type        = map(string)
  default     = {}
  description = "taints that will be added to the kubernetes node"
}

variable "custom_instance_types" {
  type        = list(string)
  description = <<EOF
Can be set to a custom list of instance types if one of the presets is not suitable (if set instance_size is ignored, instance family should be used to provide a description of the instances managed by this group)
e.g. [\"i3.xlarge\", \"i3en.xlarge\"]
The CPU and Memory resources on each type should be the same, or the cluster autoscaler may not work properly.
EOF
  default     = []
}
