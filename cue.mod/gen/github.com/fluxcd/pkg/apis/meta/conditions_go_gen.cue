// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/fluxcd/pkg/apis/meta

package meta

// ReadyCondition indicates the resource is ready and fully reconciled.
// If the Condition is False, the resource SHOULD be considered to be in the process of reconciling and not a
// representation of actual state.
#ReadyCondition: "Ready"

// StalledCondition indicates the reconciliation of the resource has stalled, e.g. because the controller has
// encountered an error during the reconcile process or it has made insufficient progress (timeout).
// The Condition adheres to an "abnormal-true" polarity pattern, and MUST only be present on the resource if the
// Condition is True.
// For more information about polarity patterns, see:
// https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties
#StalledCondition: "Stalled"

// ReconcilingCondition indicates the controller is currently working on reconciling the latest changes. This MAY be
// True for multiple reconciliation attempts, e.g. when an transient error occurred.
// The Condition adheres to an "abnormal-true" polarity pattern, and MUST only be present on the resource if the
// Condition is True.
// For more information about polarity patterns, see:
// https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#typical-status-properties
#ReconcilingCondition: "Reconciling"

// HealthyCondition represents the last recorded
// health assessment result.
#HealthyCondition: "Healthy"

// SucceededReason indicates a condition or event observed a success, for example when declared desired state
// matches actual state, or a performed action succeeded.
//
// More information about the reason of success MAY be available as additional metadata in an attached message.
#SucceededReason: "Succeeded"

// FailedReason indicates a condition or event observed a failure, for example when declared state does not match
// actual state, or a performed action failed.
//
// More information about the reason of failure MAY be available as additional metadata in an attached message.
#FailedReason: "Failed"

// ProgressingReason indicates a condition or event observed progression, for example when the reconciliation of a
// resource or an action has started.
//
// When this reason is given, other conditions and types MAY no longer be considered as an up-to-date observation.
// Producers of the specific condition type or event SHOULD provide more information about the expectations and
// precise meaning in their API specification.
//
// More information about the reason or the current state of the progression MAY be available as additional metadata
// in an attached message.
#ProgressingReason: "Progressing"

// SuspendedReason indicates a condition or event has observed a suspension, for
// example because a resource has been suspended, or a dependency is.
#SuspendedReason: "Suspended"

// ProgressingWithRetryReason represents the fact that
// the reconciliation encountered an error that will be retried.
#ProgressingWithRetryReason: "ProgressingWithRetry"

// DependencyNotReadyReason represents the fact that
// one of the dependencies is not ready.
#DependencyNotReadyReason: "DependencyNotReady"

// InvalidPathReason signals a failure caused by an invalid path.
#InvalidPathReason: "InvalidPath"

// InvalidURLReason signals a failure caused by an invalid URL.
#InvalidURLReason: "InvalidURL"

// InsecureConnectionsDisallowedReason signals a failure caused by
// the use of insecure HTTP connections.
#InsecureConnectionsDisallowedReason: "InsecureConnectionsDisallowed"

// UnsupportedConnectionTypeReason signals a failure caused by
// the use of unsupported network protocols.
#UnsupportedConnectionTypeReason: "UnsupportedConnectionType"

// PruneFailedReason represents the fact that the
// pruning of the resources failed.
#PruneFailedReason: "PruneFailed"

// ArtifactFailedReason represents the fact that the
// source artifact download failed.
#ArtifactFailedReason: "ArtifactFailed"

// BuildFailedReason represents the fact that the
// build failed.
#BuildFailedReason: "BuildFailed"

// HealthCheckFailedReason represents the fact that
// one of the health checks failed.
#HealthCheckFailedReason: "HealthCheckFailed"

// ReconciliationSucceededReason represents the fact that
// the reconciliation succeeded.
#ReconciliationSucceededReason: "ReconciliationSucceeded"

// ReconciliationFailedReason represents the fact that
// the reconciliation failed.
#ReconciliationFailedReason: "ReconciliationFailed"

// ObjectWithConditions describes a Kubernetes resource object with status conditions.
// +k8s:deepcopy-gen=false
#ObjectWithConditions: _

// ObjectWithConditionsSetter describes a Kubernetes resource object with a status conditions setter.
// +k8s:deepcopy-gen=false
#ObjectWithConditionsSetter: _
