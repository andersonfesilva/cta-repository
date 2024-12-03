# cta-repository
Cloud Technical Assessment repository 


# Directories

> ./jenkins-infra

- Repository with jenkins infraestructure code.

> ./terraform-code

- Code about infrastructure to website.

## Requirements

- Terraform version >= 1.5

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_backend_bucket.static_site_backend](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_backend_bucket) | resource |
| [google_compute_global_address.static_site_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_global_forwarding_rule.static_site_forwarding_rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_forwarding_rule) | resource |
| [google_compute_target_http_proxy.static_site_proxy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_http_proxy) | resource |
| [google_compute_url_map.static_site_url_map](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_url_map) | resource |     
| [google_storage_bucket.static_website_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |     
| [google_storage_bucket_iam_binding.public_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_object.file_404_html](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.index_html](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |  

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_GOOGLE_APPLICATION_CREDENTIALS"></a> [GOOGLE\_APPLICATION\_CREDENTIALS](#input\_GOOGLE\_APPLICATION\_CREDENTIALS) | Path to GCP credentials JSON | `string` | `"/mnt/c/Users/ander/Downloads/cta-repository/key-cta-user.json"` | no |
| <a name="input_gcp_credentials_file"></a> [gcp\_credentials\_file](#input\_gcp\_credentials\_file) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
