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
 * The result of the Service Fabric runtime versions
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model ManagedClusterCodeVersionResult
  is Azure.ResourceManager.ProxyResource<ManagedClusterVersionDetails> {
  ...ResourceNameParameter<
    Resource = ManagedClusterCodeVersionResult,
    KeyName = "clusterVersion",
    SegmentName = "managedClusterVersions",
    NamePattern = ""
  >;

  /**
   * The identification of the result
   */
  id?: string;

  /**
   * The result resource type
   */
  type?: string;
}

@armResourceOperations
interface ManagedClusterCodeVersionResults {
  /**
   * Gets information about an available Service Fabric managed cluster code version.
   */
  get is ArmResourceRead<ManagedClusterCodeVersionResult>;

  /**
   * Gets all available code versions for Service Fabric cluster resources by location.
   */
  list is ArmResourceListByParent<ManagedClusterCodeVersionResult>;
}

@@doc(ManagedClusterCodeVersionResult.name, "The cluster code version.");
