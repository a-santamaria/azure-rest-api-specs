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
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
@parentResource(ManagedCluster)
model NodeType is Azure.ResourceManager.ProxyResource<NodeTypeProperties> {
  ...ResourceNameParameter<
    Resource = NodeType,
    KeyName = "nodeTypeName",
    SegmentName = "nodeTypes",
    NamePattern = ""
  >;

  /**
   * The node type sku.
   */
  sku?: NodeTypeSku;
}

@armResourceOperations
interface NodeTypes {
  /**
   * Get a Service Fabric node type of a given managed cluster.
   */
  get is ArmResourceRead<NodeType>;

  /**
   * Create or update a Service Fabric node type of a given managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NodeType>;

  /**
   * Update the configuration of a node type of a given managed cluster, only updating tags.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<NodeType, NodeTypeUpdateParameters>;

  /**
   * Delete a Service Fabric node type of a given managed cluster.
   */
  delete is ArmResourceDeleteAsync<NodeType>;

  /**
   * Gets all Node types of the specified managed cluster.
   */
  listByManagedClusters is ArmResourceListByParent<NodeType>;

  /**
   * Restarts one or more nodes on the node type. It will disable the fabric nodes, trigger a restart on the VMs and activate the nodes back again.
   */
  restart is ArmResourceActionAsync<NodeType, NodeTypeActionParameters, void>;

  /**
   * Reimages one or more nodes on the node type. It will disable the fabric nodes, trigger a reimage on the VMs and activate the nodes back again.
   */
  reimage is ArmResourceActionAsync<NodeType, NodeTypeActionParameters, void>;

  /**
   * Deletes one or more nodes on the node type. It will disable the fabric nodes, trigger a delete on the VMs and removes the state from the cluster.
   */
  deleteNode is ArmResourceActionAsync<
    NodeType,
    NodeTypeActionParameters,
    void
  >;

  /**
   * Get a Service Fabric node type supported SKUs.
   */
  // FIXME: NodeTypeSkus_List could not be converted to a resource operation
  @summary("Gets a Service Fabric node type SKUs.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceFabric/managedClusters/{clusterName}/nodeTypes/{nodeTypeName}/skus")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the cluster resource.
     */
    @path
    clusterName: string,

    /**
     * The name of the node type.
     */
    @path
    nodeTypeName: string,
  ): ArmResponse<NodeTypeListSkuResult> | ErrorResponse;
}

@@doc(NodeType.name, "The name of the node type.");
@@doc(NodeTypes.createOrUpdate::parameters.resource, "The node type resource.");
@@doc(NodeTypes.update::parameters.properties,
  "The parameters to update the node type configuration."
);
@@doc(NodeTypes.restart::parameters.body, "parameters for restart action.");
@@doc(NodeTypes.reimage::parameters.body, "parameters for reimage action.");
@@doc(NodeTypes.deleteNode::parameters.body, "parameters for delete action.");
