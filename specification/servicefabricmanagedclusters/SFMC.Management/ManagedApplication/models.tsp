import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceFabric;

/**
 * The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations.
 * Rollback specifies that the upgrade will start rolling back automatically.
 * Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode.
 *
 */
union FailureAction {
  string,

  /**
   * The upgrade will start rolling back automatically. The value is 0
   */
  Rollback: "Rollback",

  /**
   * The upgrade will switch to UnmonitoredManual upgrade mode. The value is 1
   */
  Manual: "Manual",
}

/**
 * The mode used to monitor health during a rolling upgrade. The values are Monitored, and UnmonitoredAuto.
 */
union RollingUpgradeMode {
  string,

  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 0.
   */
  Monitored: "Monitored",

  /**
   * The upgrade will proceed automatically without performing any health monitoring. The value is 1.
   */
  UnmonitoredAuto: "UnmonitoredAuto",
}

/**
 * The kind of service (Stateless or Stateful).
 */
union ServiceKind {
  string,

  /**
   * Does not use Service Fabric to make its state highly available or reliable. The value is 0.
   */
  Stateless: "Stateless",

  /**
   * Uses Service Fabric to make its state or part of its state highly available and reliable. The value is 1.
   */
  Stateful: "Stateful",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union PartitionScheme {
  string,

  /**
   * Indicates that the partition is based on string names, and is a SingletonPartitionScheme object, The value is 0.
   */
  Singleton: "Singleton",

  /**
   * Indicates that the partition is based on Int64 key ranges, and is a UniformInt64RangePartitionScheme object. The value is 1.
   */
  UniformInt64Range: "UniformInt64Range",

  /**
   * Indicates that the partition is based on string names, and is a NamedPartitionScheme object. The value is 2.
   */
  Named: "Named",
}

/**
 * The activation Mode of the service package
 */
union ServicePackageActivationMode {
  string,

  /**
   * Indicates the application package activation mode will use shared process.
   */
  SharedProcess: "SharedProcess",

  /**
   * Indicates the application package activation mode will use exclusive process.
   */
  ExclusiveProcess: "ExclusiveProcess",
}

/**
 * The service correlation scheme.
 */
union ServiceCorrelationScheme {
  string,

  /**
   * Aligned affinity ensures that the primaries of the partitions of the affinitized services are collocated on the same nodes. This is the default and is the same as selecting the Affinity scheme. The value is 0.
   */
  AlignedAffinity: "AlignedAffinity",

  /**
   * Non-Aligned affinity guarantees that all replicas of each service will be placed on the same nodes. Unlike Aligned Affinity, this does not guarantee that replicas of particular role will be collocated. The value is 1.
   */
  NonAlignedAffinity: "NonAlignedAffinity",
}

/**
 * Determines the metric weight relative to the other metrics that are configured for this service. During runtime, if two metrics end up in conflict, the Cluster Resource Manager prefers the metric with the higher weight.
 */
union ServiceLoadMetricWeight {
  string,

  /**
   * Disables resource balancing for this metric. This value is zero.
   */
  Zero: "Zero",

  /**
   * Specifies the metric weight of the service load as Low. The value is 1.
   */
  Low: "Low",

  /**
   * Specifies the metric weight of the service load as Medium. The value is 2.
   */
  Medium: "Medium",

  /**
   * Specifies the metric weight of the service load as High. The value is 3.
   */
  High: "High",
}

/**
 * The type of placement policy for a service fabric service. Following are the possible values.
 */
union ServicePlacementPolicyType {
  string,

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementInvalidDomainPolicyDescription, which indicates that a particular fault or upgrade domain cannot be used for placement of this service. The value is 0.
   */
  InvalidDomain: "InvalidDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription indicating that the replicas of the service must be placed in a specific domain. The value is 1.
   */
  RequiredDomain: "RequiredDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementPreferPrimaryDomainPolicyDescription, which indicates that if possible the Primary replica for the partitions of the service should be located in a particular domain as an optimization. The value is 2.
   */
  PreferredPrimaryDomain: "PreferredPrimaryDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription, indicating that the system will disallow placement of any two replicas from the same partition in the same domain at any time. The value is 3.
   */
  RequiredDomainDistribution: "RequiredDomainDistribution",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementNonPartiallyPlaceServicePolicyDescription, which indicates that if possible all replicas of a particular partition of the service should be placed atomically. The value is 4.
   */
  NonPartiallyPlaceService: "NonPartiallyPlaceService",
}

/**
 * Specifies the move cost for the service.
 */
union MoveCost {
  string,

  /**
   * Zero move cost. This value is zero.
   */
  Zero: "Zero",

  /**
   * Specifies the move cost of the service as Low. The value is 1.
   */
  Low: "Low",

  /**
   * Specifies the move cost of the service as Medium. The value is 2.
   */
  Medium: "Medium",

  /**
   * Specifies the move cost of the service as High. The value is 3.
   */
  High: "High",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union ServiceScalingMechanismKind {
  string,

  /**
   * Represents a scaling mechanism for adding or removing instances of stateless service partition. The value is 0.
   */
  ScalePartitionInstanceCount: "ScalePartitionInstanceCount",

  /**
   * Represents a scaling mechanism for adding or removing named partitions of a stateless service. The value is 1.
   */
  AddRemoveIncrementalNamedPartition: "AddRemoveIncrementalNamedPartition",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union ServiceScalingTriggerKind {
  string,

  /**
   * Represents a scaling trigger related to an average load of a metric/resource of a partition. The value is 0.
   */
  AveragePartitionLoadTrigger: "AveragePartitionLoadTrigger",

  /**
   * Represents a scaling policy related to an average load of a metric/resource of a service. The value is 1.
   */
  AverageServiceLoadTrigger: "AverageServiceLoadTrigger",
}

/**
 * The mode used to monitor health during a rolling upgrade. The values are UnmonitoredAuto, UnmonitoredManual, Monitored, and UnmonitoredDeferred.
 */
union UpgradeMode {
  string,

  /**
   * The upgrade will proceed automatically without performing any health monitoring. The value is 0
   */
  UnmonitoredAuto: "UnmonitoredAuto",

  /**
   * The upgrade will stop after completing each upgrade domain, giving the opportunity to manually monitor health before proceeding. The value is 1
   */
  UnmonitoredManual: "UnmonitoredManual",

  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 2
   */
  Monitored: "Monitored",
}

/**
 * The type of managed identity for the resource.
 */
enum ManagedIdentityType {
  /**
   * Indicates that no identity is associated with the resource.
   */
  None,

  /**
   * Indicates that system assigned identity is associated with the resource.
   */
  SystemAssigned,

  /**
   * Indicates that user assigned identity is associated with the resource.
   */
  UserAssigned,

  /**
   * Indicates that both system assigned and user assigned identity are associated with the resource.
   */
  `SystemAssigned, UserAssigned`,
}

/**
 * The application type name properties
 */
model ApplicationTypeResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * The resource model definition for proxy-only resource.
 */
model ProxyResource {
  /**
   * Azure resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location depends on the parent resource.
   */
  @visibility("read", "create")
  location?: string;

  /**
   * Azure resource tags.
   */
  @visibility("read", "create")
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Application type update request
 */
model ApplicationTypeUpdateParameters {
  /**
   * Application type update parameters
   */
  tags?: Record<string>;
}

/**
 * The properties of the application type version resource.
 */
model ApplicationTypeVersionResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The URL to the application package
   */
  appPackageUrl: string;
}

/**
 * Application type version update request
 */
model ApplicationTypeVersionUpdateParameters {
  /**
   * Application type version update parameters
   */
  tags?: Record<string>;
}

/**
 * Parameters for Resume Upgrade action. The upgrade domain name must be specified.
 */
model RuntimeResumeApplicationUpgradeParameters {
  /**
   * The upgrade domain name. Expected to be the next upgrade domain if the application is upgrading.
   */
  upgradeDomainName?: string;
}

/**
 * Describes the managed identities for an Azure resource.
 */
model ManagedIdentity {
  /**
   * The principal id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of managed identity for the resource.
   */
  type?: ManagedIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   *
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

model UserAssignedIdentity {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The application resource properties.
 */
model ApplicationResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The version of the application type as defined in the application manifest.
   * This name must be the full Arm Resource ID for the referenced application type version.
   *
   */
  version?: string;

  /**
   * List of application parameters with overridden values from their default values specified in the application manifest.
   */
  parameters?: Record<string>;

  /**
   * Describes the policy for a monitored application upgrade.
   */
  upgradePolicy?: ApplicationUpgradePolicy;

  /**
   * List of user assigned identities for the application, each mapped to a friendly name.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  managedIdentities?: ApplicationUserAssignedIdentity[];
}

/**
 * Describes the policy for a monitored application upgrade.
 */
model ApplicationUpgradePolicy {
  /**
   * Defines a health policy used to evaluate the health of an application or one of its children entities.
   *
   */
  applicationHealthPolicy?: ApplicationHealthPolicy;

  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean;

  /**
   * The policy used for monitoring the application upgrade
   */
  rollingUpgradeMonitoringPolicy?: RollingUpgradeMonitoringPolicy;

  /**
   * Duration in seconds, to wait before a stateless instance is closed, to allow the active requests to drain gracefully. This would be effective when the instance is closing during the application/cluster upgrade, only for those instances which have a non-zero delay duration configured in the service description.
   */
  instanceCloseDelayDuration?: int64;

  /**
   * The mode used to monitor health during a rolling upgrade. The values are Monitored, and UnmonitoredAuto.
   */
  upgradeMode?: RollingUpgradeMode;

  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer).
   */
  upgradeReplicaSetCheckTimeout?: int64;

  /**
   * Determines whether the application should be recreated on update. If value=true, the rest of the upgrade policy parameters are not allowed.
   */
  recreateApplication?: boolean;
}

/**
 * Defines a health policy used to evaluate the health of an application or one of its children entities.
 *
 */
model ApplicationHealthPolicy {
  /**
   * Indicates whether warnings are treated with the same severity as errors.
   */
  considerWarningAsError: boolean;

  /**
   * The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
   * The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
   * This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
   * The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
   *
   */
  maxPercentUnhealthyDeployedApplications: int32;

  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: ServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  serviceTypeHealthPolicyMap?: Record<ServiceTypeHealthPolicy>;
}

/**
 * Represents the health policy used to evaluate the health of services belonging to a service type.
 *
 */
model ServiceTypeHealthPolicy {
  /**
   * The maximum allowed percentage of unhealthy services.
   *
   * The percentage represents the maximum tolerated percentage of services that can be unhealthy before the application is considered in error.
   * If the percentage is respected but there is at least one unhealthy service, the health is evaluated as Warning.
   * This is calculated by dividing the number of unhealthy services of the specific service type over the total number of services of the specific service type.
   * The computation rounds up to tolerate one failure on small numbers of services.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyServices: int32;

  /**
   * The maximum allowed percentage of unhealthy partitions per service.
   *
   * The percentage represents the maximum tolerated percentage of partitions that can be unhealthy before the service is considered in error.
   * If the percentage is respected but there is at least one unhealthy partition, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy partitions over the total number of partitions in the service.
   * The computation rounds up to tolerate one failure on small numbers of partitions.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService: int32;

  /**
   * The maximum allowed percentage of unhealthy replicas per partition.
   *
   * The percentage represents the maximum tolerated percentage of replicas that can be unhealthy before the partition is considered in error.
   * If the percentage is respected but there is at least one unhealthy replica, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy replicas over the total number of replicas in the partition.
   * The computation rounds up to tolerate one failure on small numbers of replicas.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyReplicasPerPartition: int32;
}

/**
 * The policy used for monitoring the application upgrade
 */
model RollingUpgradeMonitoringPolicy {
  /**
   * The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations. Invalid indicates the failure action is invalid. Rollback specifies that the upgrade will start rolling back automatically. Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode.
   */
  failureAction: FailureAction;

  /**
   * The amount of time to wait after completing an upgrade domain before applying health policies. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  healthCheckWaitDuration: string;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  healthCheckStableDuration: string;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  healthCheckRetryTimeout: string;

  /**
   * The amount of time the overall upgrade has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  upgradeTimeout: string;

  /**
   * The amount of time each upgrade domain has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  upgradeDomainTimeout: string;
}

model ApplicationUserAssignedIdentity {
  /**
   * The friendly name of user assigned identity.
   */
  name: string;

  /**
   * The principal id of user assigned identity.
   */
  principalId: string;
}

/**
 * Application update request
 */
model ApplicationUpdateParameters {
  /**
   * Application update parameters
   */
  tags?: Record<string>;
}

/**
 * The service resource properties.
 */
@discriminator("serviceKind")
model ServiceResourceProperties extends ServiceResourcePropertiesBase {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The name of the service type
   */
  serviceTypeName: string;

  /**
   * Describes how the service is partitioned.
   */
  partitionDescription: Partition;

  /**
   * The activation Mode of the service package
   */
  servicePackageActivationMode?: ServicePackageActivationMode;

  /**
   * Dns name used for the service. If this is specified, then the DNS name can be used to return the IP addresses of service endpoints for application layer protocols (e.g., HTTP).
   * When updating serviceDnsName, old name may be temporarily resolvable. However, rely on new name.
   * When removing serviceDnsName, removed name may temporarily be resolvable. Do not rely on the name being unresolvable.
   *
   */
  serviceDnsName?: string;
}

/**
 * Describes how the service is partitioned.
 */
@discriminator("partitionScheme")
model Partition {}

/**
 * The common service resource properties.
 */
model ServiceResourcePropertiesBase {
  /**
   * The placement constraints as a string. Placement constraints are boolean expressions on node properties and allow for restricting a service to particular nodes based on the service requirements. For example, to place a service on nodes where NodeType is blue specify the following: "NodeColor == blue)".
   */
  placementConstraints?: string;

  /**
   * A list that describes the correlation of the service with other services.
   */
  correlationScheme?: ServiceCorrelation[];

  /**
   * The service load metrics is given as an array of ServiceLoadMetric objects.
   */
  serviceLoadMetrics?: ServiceLoadMetric[];

  /**
   * A list that describes the correlation of the service with other services.
   */
  servicePlacementPolicies?: ServicePlacementPolicy[];

  /**
   * Specifies the move cost for the service.
   */
  defaultMoveCost?: MoveCost;

  /**
   * Scaling policies for this service.
   */
  scalingPolicies?: ScalingPolicy[];
}

/**
 * Creates a particular correlation between services.
 */
model ServiceCorrelation {
  /**
   * The ServiceCorrelationScheme which describes the relationship between this service and the service specified via ServiceName.
   */
  scheme: ServiceCorrelationScheme;

  /**
   * The Arm Resource ID of the service that the correlation relationship is established with.
   */
  serviceName: string;
}

/**
 * Specifies a metric to load balance a service during runtime.
 */
model ServiceLoadMetric {
  /**
   * The name of the metric. If the service chooses to report load during runtime, the load metric name should match the name that is specified in Name exactly. Note that metric names are case sensitive.
   */
  name: string;

  /**
   * The service load metric relative weight, compared to other metrics configured for this service, as a number.
   */
  weight?: ServiceLoadMetricWeight;

  /**
   * Used only for Stateful services. The default amount of load, as a number, that this service creates for this metric when it is a Primary replica.
   */
  primaryDefaultLoad?: int32;

  /**
   * Used only for Stateful services. The default amount of load, as a number, that this service creates for this metric when it is a Secondary replica.
   */
  secondaryDefaultLoad?: int32;

  /**
   * Used only for Stateless services. The default amount of load, as a number, that this service creates for this metric.
   */
  defaultLoad?: int32;
}

/**
 * Describes the policy to be used for placement of a Service Fabric service.
 */
@discriminator("type")
model ServicePlacementPolicy {}

/**
 * Specifies a metric to load balance a service during runtime.
 */
model ScalingPolicy {
  /**
   * Specifies the mechanism associated with this scaling policy
   */
  scalingMechanism: ScalingMechanism;

  /**
   * Specifies the trigger associated with this scaling policy.
   */
  scalingTrigger: ScalingTrigger;
}

/**
 * Describes the mechanism for performing a scaling operation.
 */
@discriminator("kind")
model ScalingMechanism {}

/**
 * Describes the trigger for performing a scaling operation.
 */
@discriminator("kind")
model ScalingTrigger {}

/**
 * Service update request
 */
model ServiceUpdateParameters {
  /**
   * Service update parameters
   */
  tags?: Record<string>;
}

/**
 * The properties of a stateful service resource.
 */
model StatefulServiceProperties extends ServiceResourceProperties {
  /**
   * A flag indicating whether this is a persistent service which stores states on the local disk. If it is then the value of this property is true, if not it is false.
   */
  hasPersistedState?: boolean;

  /**
   * The target replica set size as a number.
   */
  @minValue(1)
  targetReplicaSetSize?: int32;

  /**
   * The minimum replica set size as a number.
   */
  @minValue(1)
  minReplicaSetSize?: int32;

  /**
   * The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format "hh:mm:ss".
   */
  replicaRestartWaitDuration?: duration;

  /**
   * The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format "hh:mm:ss".
   */
  quorumLossWaitDuration?: duration;

  /**
   * The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format "hh:mm:ss".
   */
  standByReplicaKeepDuration?: duration;

  /**
   * The duration for which replicas can stay InBuild before reporting that build is stuck, represented in ISO 8601 format "hh:mm:ss".
   */
  servicePlacementTimeLimit?: duration;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateful";
}

/**
 * The properties of a stateless service resource.
 */
model StatelessServiceProperties extends ServiceResourceProperties {
  /**
   * The instance count.
   */
  @minValue(-1)
  instanceCount: int32;

  /**
   * MinInstanceCount is the minimum number of instances that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstanceCount computation -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstanceCount?: int32;

  /**
   * MinInstancePercentage is the minimum percentage of InstanceCount that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstancePercentage computation, -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstancePercentage?: int32;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateless";
}

/**
 * Describes a partitioning scheme where an integer range is allocated evenly across a number of partitions.
 */
model UniformInt64RangePartitionScheme extends Partition {
  /**
   * The number of partitions.
   */
  count: int32;

  /**
   * The lower bound of the partition key range that
   * should be split between the partition ‘Count’
   *
   */
  lowKey: int64;

  /**
   * The upper bound of the partition key range that
   * should be split between the partition ‘Count’
   *
   */
  highKey: int64;

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "UniformInt64Range";
}
