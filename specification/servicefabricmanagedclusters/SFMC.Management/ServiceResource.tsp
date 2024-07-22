import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The service resource.
 */
@parentResource(ApplicationResource)
model ServiceResource
  is Azure.ResourceManager.TrackedResource<ServiceResourceProperties> {
  ...ResourceNameParameter<
    Resource = ServiceResource,
    KeyName = "serviceName",
    SegmentName = "services",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServiceResources {
  /**
   * Get a Service Fabric service resource created or in the process of being created in the Service Fabric managed application resource.
   */
  get is ArmResourceRead<ServiceResource>;

  /**
   * Create or update a Service Fabric managed service resource with the specified name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceResource>;

  /**
   * Updates the tags of a service resource of a given managed cluster.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<ServiceResource, ServiceUpdateParameters>;

  /**
   * Delete a Service Fabric managed service resource with the specified name.
   */
  delete is ArmResourceDeleteAsync<ServiceResource>;

  /**
   * Gets all service resources created or in the process of being created in the Service Fabric managed application resource.
   */
  listByApplications is ArmResourceListByParent<ServiceResource>;
}

@@doc(ServiceResource.name,
  "The name of the service resource in the format of {applicationName}~{serviceName}."
);
@@doc(ServiceResources.createOrUpdate::parameters.resource,
  "The service resource."
);
@@doc(ServiceResources.update::parameters.properties,
  "The service resource updated tags."
);
