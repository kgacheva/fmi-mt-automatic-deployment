# template-builder

## Set up secrets for the template-builder

All secrets to be used in a build of a template need to be included in a dedicated .pkrvars.hcl files under the common _private_ directory or exported as environment variables before running the template-builder.

## Run the template-builder

To initialize the working directory from the root of the _template-builder_ project:
```
packer init <TEMPL_PROJECT>
```
e.g.:
```
$ packer init qemu-templater
```

To validate passing the variables files:
```
packer validate --var-file=<relative path to tfvars file> <TEMPL_PROJECT>
```
e.g.:
```
$ packer validate --var-file=configurations/general-centos79.pkrvars.hcl --var-file=private/private-centos79.pkrvars.hcl qemu-templater
```

To put start building the template:
```
packer build --var-file=<relative path to tfvars file> <TEMPL_PROJECT>
```
