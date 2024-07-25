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
 * The provisioning state of the managed resource.
 */
union ManagedResourceProvisioningState {
  string,
  None: "None",
  Creating: "Creating",
  Created: "Created",
  Updating: "Updating",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
  Deleting: "Deleting",
  Deleted: "Deleted",
  Other: "Other",
}

/**
 * The structure of the error.
 */
@error
model ErrorModel {
  /**
   * The error details.
   */
  error?: ErrorModelError;
}

/**
 * The error details.
 */
model ErrorModelError {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Azure resource identifier.
 */
model SubResource {
  /**
   * Azure resource identifier.
   */
  id?: string;
}