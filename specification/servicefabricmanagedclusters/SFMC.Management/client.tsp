import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceFabric;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VmssExtension.properties);
