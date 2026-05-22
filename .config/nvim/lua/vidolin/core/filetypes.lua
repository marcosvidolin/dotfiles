vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
    tmpl = "gotmpl",
    tfvars = "terraform-vars",
  },
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
})

