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
 * The application resource.
 */
@parentResource(ManagedCluster)
model ApplicationResource
  is Azure.ResourceManager.TrackedResource<ApplicationResourceProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationResource,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;

  /**
   * Describes the managed identities for an Azure resource.
   */
  identity?: ManagedIdentity;
}

@armResourceOperations
interface ApplicationResources {
  /**
   * Get a Service Fabric managed application resource created or in the process of being created in the Service Fabric cluster resource.
   */
  get is ArmResourceRead<ApplicationResource>;

  /**
   * Create or update a Service Fabric managed application resource with the specified name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApplicationResource>;

  /**
   * Updates the tags of an application resource of a given managed cluster.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    ApplicationResource,
    ApplicationUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed application resource with the specified name.
   */
  delete is ArmResourceDeleteAsync<ApplicationResource>;

  /**
   * Gets all managed application resources created or in the process of being created in the Service Fabric cluster resource.
   */
  list is ArmResourceListByParent<ApplicationResource>;

  /**
   * Get the status of the latest application upgrade. It will query the cluster to find the status of the latest application upgrade.
   */
  readUpgrade is ArmResourceActionNoResponseContentAsync<
    ApplicationResource,
    void
  >;

  /**
   * Send a request to start a rollback of the current application upgrade. This will start rolling back the application to the previous version.
   */
  startRollback is ArmResourceActionNoResponseContentAsync<
    ApplicationResource,
    void
  >;

  /**
   * Send a request to resume the current application upgrade. This will resume the application upgrade from where it was paused.
   */
  resumeUpgrade is ArmResourceActionNoResponseContentAsync<
    ApplicationResource,
    RuntimeResumeApplicationUpgradeParameters
  >;
}

@@doc(ApplicationResource.name, "The name of the application resource.");
@@doc(ApplicationResources.createOrUpdate::parameters.resource,
  "The application resource."
);
@@doc(ApplicationResources.update::parameters.properties,
  "The application resource updated tags."
);
@@doc(ApplicationResources.resumeUpgrade::parameters.body,
  "The parameters for resuming an application upgrade."
);
