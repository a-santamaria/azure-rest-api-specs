## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: hdinsight
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-06
  - tag: package-2018-06-preview
  - tag: package-2015-03-preview
```

### Tag: package-2021-06 and go

These settings apply only when `--tag=package-2021-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-06-01/$(namespace)
```

### Tag: package-2018-06-preview and go

These settings apply only when `--tag=package-2018-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-06-01/$(namespace)
```

### Tag: package-2015-03-preview and go

These settings apply only when `--tag=package-2015-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2015-03-01-preview/$(namespace)
```
