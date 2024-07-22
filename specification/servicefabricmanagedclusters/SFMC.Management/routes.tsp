// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ServiceFabric;

interface ManagedClusterVersionOperations {
  /**
   * Gets information about an available Service Fabric cluster code version by environment.
   */
  @summary("Gets information about a Service Fabric cluster code version available for the specified environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions/{clusterVersion}")
  @get
  getByEnvironment(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * The operating system of the cluster. The default means all.
     */
    @path
    environment: ManagedClusterVersionEnvironment,

    ...SubscriptionIdParameter,

    /**
     * The cluster code version.
     */
    @path
    clusterVersion: string,
  ): ArmResponse<ManagedClusterCodeVersionResult> | ErrorResponse;

  /**
   * Gets all available code versions for Service Fabric cluster resources by environment.
   */
  @summary("Gets the list of Service Fabric cluster code versions available for the specified environment.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/managedClusterVersions")
  @get
  listByEnvironment(
    ...ApiVersionParameter,
    ...LocationResourceParameter,

    /**
     * The operating system of the cluster. The default means all.
     */
    @path
    environment: ManagedClusterVersionEnvironment,

    ...SubscriptionIdParameter,
  ): ArmResponse<void> | ErrorResponse;
}

interface OperationStatusOperations {
  /**
   * Get long running operation status.
   */
  @summary("Get long running operation status.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * operation identifier.
     */
    @path
    operationId: string,
  ): ArmResponse<LongRunningOperationResult> | ErrorResponse;
}

interface OperationResultsOperations {
  /**
   * Get long running operation result.
   */
  @summary("Get long running operation result.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/managedClusterOperationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * operation identifier.
     */
    @path
    operationId: string,
  ): ArmResponse<void> | ErrorResponse;
}
