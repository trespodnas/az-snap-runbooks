output "package_uris" {
  value = [for pkg in var.packages : pkg.content_uri]
}