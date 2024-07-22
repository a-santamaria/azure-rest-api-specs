import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * Describes a VM Sizes.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model ManagedVMSize is Azure.ResourceManager.ProxyResource<VMSize> {
  ...ResourceNameParameter<
    Resource = ManagedVMSize,
    KeyName = "vmSize",
    SegmentName = "managedUnsupportedVMSizes",
    NamePattern = ""
  >;

  /**
   * VM Size id.
   */
  @visibility("read")
  id?: string;

  /**
   * VM Size type.
   */
  @visibility("read")
  type?: string;
}

@armResourceOperations
interface ManagedVMSizes {
  /**
   * Get unsupported vm size for Service Fabric Managed Clusters.
   */
  get is ArmResourceRead<ManagedVMSize>;

  /**
   * Get the lists of unsupported vm sizes for Service Fabric Managed Clusters.
   */
  list is ArmResourceListByParent<ManagedVMSize>;
}

@@doc(ManagedVMSize.name, "VM Size name.");
