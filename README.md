# Terraform-Trazable-Modules

Terraform trazable modules, centralized repository to manage terraform modules.

## How to use

To invoke the desired modules to your infrastructure you should use the next example in your code:

```
module "desired_module_name" {
  source = "github.com/Trazable/Terraform-Trazable-Modules/modules/{provider}/{module}"
}
```

Terraform module documentation: https://www.terraform.io/docs/modules/index.html


## Built With

* [Terraform](https://www.terraform.io/) - Terraform infrastructure as code tool
