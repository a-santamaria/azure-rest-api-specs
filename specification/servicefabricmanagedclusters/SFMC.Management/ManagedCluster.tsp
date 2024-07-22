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
 * The managed cluster resource
 *
 */
model ManagedCluster
  is Azure.ResourceManager.TrackedResource<ManagedClusterProperties> {
  ...ResourceNameParameter<
    Resource = ManagedCluster,
    KeyName = "clusterName",
    SegmentName = "managedClusters",
    NamePattern = ""
  >;

  /**
   * The sku of the managed cluster
   */
  sku: Sku;
}

@armResourceOperations
interface ManagedClusters {
  /**
   * Get a Service Fabric managed cluster resource created or in the process of being created in the specified resource group.
   */
  get is ArmResourceRead<ManagedCluster>;

  /**
   * Create or update a Service Fabric managed cluster resource with the specified name.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedCluster>;

  /**
   * Update the tags of of a Service Fabric managed cluster resource with the specified name.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<ManagedCluster, ManagedClusterUpdateParameters>;

  /**
   * Delete a Service Fabric managed cluster resource with the specified name.
   */
  delete is ArmResourceDeleteAsync<ManagedCluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ManagedCluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the subscription.
   */
  listBySubscription is ArmListBySubscription<ManagedCluster>;

  /**
   * Action to get Az Resiliency Status of all the Base resources constituting Service Fabric Managed Clusters.
   */
  get is ArmResourceActionSync<ManagedCluster, void, ManagedAzResiliencyStatus>;

  /**
   * Action to get Maintenance Window Status of the Service Fabric Managed Clusters.
   */
  get is ArmResourceActionSync<
    ManagedCluster,
    void,
    ManagedMaintenanceWindowStatus
  >;

  /**
   * Action to Apply Maintenance window on the Service Fabric Managed Clusters, right now. Any pending update will be applied.
   */
  post is ArmResourceActionSync<ManagedCluster, void, void>;
}

@@doc(ManagedCluster.name, "The name of the cluster resource.");
@@doc(ManagedClusters.createOrUpdate::parameters.resource,
  "The cluster resource."
);
@@doc(ManagedClusters.update::parameters.properties,
  "The managed cluster resource updated tags."
);
