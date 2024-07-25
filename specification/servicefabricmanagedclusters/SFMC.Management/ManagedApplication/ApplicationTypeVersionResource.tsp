import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../ManagedCluster/ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * An application type version resource for the specified application type name resource.
 */
@parentResource(ApplicationTypeResource)
model ApplicationTypeVersionResource
  is Azure.ResourceManager.TrackedResource<ApplicationTypeVersionResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeVersionResource,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ApplicationTypeVersionResources {
  /**
   * Get a Service Fabric managed application type version resource created or in the process of being created in the Service Fabric managed application type name resource.
   */
  get is ArmResourceRead<ApplicationTypeVersionResource>;

  /**
   * Create or update a Service Fabric managed application type version resource with the specified name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApplicationTypeVersionResource>;

  /**
   * Updates the tags of an application type version resource of a given managed cluster.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    ApplicationTypeVersionResource,
    ApplicationTypeVersionUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type version resource with the specified name.
   */
  delete is ArmResourceDeleteAsync<ApplicationTypeVersionResource>;

  /**
   * Gets all application type version resources created or in the process of being created in the Service Fabric managed application type name resource.
   */
  listByApplicationTypes is ArmResourceListByParent<ApplicationTypeVersionResource>;
}

@@doc(ApplicationTypeVersionResource.name, "The application type version.");
@@doc(ApplicationTypeVersionResources.createOrUpdate::parameters.resource,
  "The application type version resource."
);
@@doc(ApplicationTypeVersionResources.update::parameters.properties,
  "The application type version resource updated tags."
);
