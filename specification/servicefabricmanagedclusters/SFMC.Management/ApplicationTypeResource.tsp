import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The application type name resource
 */
@parentResource(ManagedCluster)
model ApplicationTypeResource
  is Azure.ResourceManager.TrackedResource<ApplicationTypeResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationTypeResource,
    KeyName = "applicationTypeName",
    SegmentName = "applicationTypes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ApplicationTypeResources {
  /**
   * Get a Service Fabric application type name resource created or in the process of being created in the Service Fabric managed cluster resource.
   */
  get is ArmResourceRead<ApplicationTypeResource>;

  /**
   * Create or update a Service Fabric managed application type name resource with the specified name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationTypeResource>;

  /**
   * Updates the tags of an application type resource of a given managed cluster.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    ApplicationTypeResource,
    ApplicationTypeUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application type name resource with the specified name.
   */
  delete is ArmResourceDeleteAsync<ApplicationTypeResource>;

  /**
   * Gets all application type name resources created or in the process of being created in the Service Fabric managed cluster resource.
   */
  list is ArmResourceListByParent<ApplicationTypeResource>;
}

@@doc(ApplicationTypeResource.name,
  "The name of the application type name resource."
);
@@doc(ApplicationTypeResources.createOrUpdate::parameters.resource,
  "The application type name resource."
);
@@doc(ApplicationTypeResources.update::parameters.properties,
  "The application type resource updated tags."
);
