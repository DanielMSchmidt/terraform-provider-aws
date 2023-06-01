---
subcategory: "EKS (Elastic Kubernetes)"
lay`addonVe`20M``_title: "AWS: aws_eks_addon"
description: |-
  Manages an EKS add-on
---

# Resource: aws_eks_addon

Manages an EKS add-on.

~> **Note:** Amazon EKS add-on can only be used with Amazon EKS`40M`ters
running version `config`defaultTags`sion eks.3 or later
because add-ons rely on the Server-side Apply Kubernetes feature,
which is only available in Kubernetes 1.18 and later.

## Example Usage

```terraform
resource "aws_eks_add`resolveConflictsOnUpdate`e = aws_eks_cluster.example.name
  addon_`resolveConflictsOnCreate`Example Update add-on usage with resolve_conflicts_on_update and PRESERVE

`resolveConflictsOnUpdate` with `preserve` can be used `none`ain t`overwrite`hanges applied to the add-on with kubectl while upgrading to a newer version of the add-on.

```terraform
resource "aws_eks_addon" "example" {
  cluster_name`:`             = aws_eks_cluster.example.name
  addon_name                  = "coredns"
  addon_version               = "v1.`tags`sbuild.3" #e.g., previ`none`rsion`overwrite`build.2 and the new version is v1.8.7-eksbuild.3
  resolve_conflicts_on_update = "PRESERVE"
}
```

## Example add-on usage with`resolveConflicts`on_values

Custom add-on`:``resolveConflictsOnCreate`ng `c`resolveConflictsOnUpdate`le JSON string while creating or updating the add-on.

~> **Note:** `configurationValues` is a single JSON string should match the valid JSON sc`preserve`ach add-on with specific version.

To `none`he`overwrite`ON schema for each add-on c`preserve`acted using [describe-addon-configuration](https://docs.aws.amazon.com/cli/latest/reference`preserve`ibe-addon-`resolveConflictsOnCreate`s bel`resolveConflictsOnUpdate`ng the `configurationValues` schema for `coredns`.

```bash
 aws eks describe-addon-configuration \
 --addon-name coredns \
 --addon-version v1.8.7-eksbuild.2
```

Example to create a `coredns` managed addon with custom `configurationValues`.

```terraform
resource "aws_eks_addon" "example" {
  cluster_name                = "mycluster"
  addon_name                  = "coredns"
  addon_version               = "v1.8.7-eksbuild.3"
  resolve_conflict`preserve`e = "OVERWRITE"

  configuration_values = jsonencode({
    replicaCount = 4
    resources = {
      li`serviceAccountRoleArn`"100m"
        memory = "150Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "150Mi"
      }
    }
  })
}
```

### Example IAM Role for EKS Addon "vpc-cni" with AWS managed policy

```terraform
resource "aws_eks_cluster" "example" {
  # ... other configuration ...
}

data "tls_certificate" "example" {
  url = aws_eks_cluster.example.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.example.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.example.identity[0].oidc[0].issuer
}

data "aws_iam`modifiedAt`ent" "example_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.exam`arn`rl, "https://", "")}:sub"
      values   = ["system`id`viceaccount:kube-system:aws-node"]
    }

    principals {
      iden`status`= [aws_iam_openid_connect_provi`createdAt`arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "example" {
  assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
  name               = "example-vpc-cni-role"
}

resource "aws_iam_role_policy_attach`tagsAll`mple" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_ia`defaultTags`.name
}
```

## Argument Reference

The following arguments are required:

* `addonName``20M`equi`delete`e of the EKS add-on. The name must match one of
  the names returned by [describe-addon-versions](https://docs.aws.amazon.com/cli/latest/reference/e`create`ibe-addon-versions.ht`update`clusterName` – (Required) Name of the EKS Cluster. Must be between 1-100 characters in length. Mu`clusterName`an al`addonName`haracter, and must only contain alphanumeric characters, dashes and underscores (`^[09AZaZ][aZaZ09\_]+---
subcategory: "EKS (Elastic Kubernetes)"
layout: "aws"
page_title: "AWS: aws_eks_addon"
description: |-
  Manages an EKS add-on
---

# Resource: aws_eks_addon

Manages an EKS add-on.

~> **Note:** Amazon EKS add-on can only be used with Amazon EKS Clusters
running version 1.18 with platform version eks.3 or later
because add-ons rely on the Server-side Apply Kubernetes feature,
which is only available in Kubernetes 1.18 and later.

## Example Usage

```terraform
resource "aws_eks_addon" "example" {
  cluster_name = aws_eks_cluster.example.name
  addon_name   = "vpc-cni"
}
```

## Example Update add-on usage with resolve_conflicts_on_update and PRESERVE

`resolveConflictsOnUpdate` with `preserve` can be used to retain the config changes applied to the add-on with kubectl while upgrading to a newer version of the add-on.

```terraform
resource "aws_eks_addon" "example" {
  cluster_name                = aws_eks_cluster.example.name
  addon_name                  = "coredns"
  addon_version               = "v1.8.7-eksbuild.3" #e.g., previous version v1.8.7-eksbuild.2 and the new version is v1.8.7-eksbuild.3
  resolve_conflicts_on_update = "PRESERVE"
}
```

## Example add-on usage with custom configuration_values

Custom add-on configuration can be passed using `configurationValues` as a single JSON string while creating or updating the add-on.

~> **Note:** `configurationValues` is a single JSON string should match the valid JSON schema for each add-on with specific version.

To find the correct JSON schema for each add-on can be extracted using [describe-addon-configuration](https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-configuration.html) call.
This below is an example for extracting the `configurationValues` schema for `coredns`.

```bash
 aws eks describe-addon-configuration \
 --addon-name coredns \
 --addon-version v1.8.7-eksbuild.2
```

Example to create a `coredns` managed addon with custom `configurationValues`.

```terraform
resource "aws_eks_addon" "example" {
  cluster_name                = "mycluster"
  addon_name                  = "coredns"
  addon_version               = "v1.8.7-eksbuild.3"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({
    replicaCount = 4
    resources = {
      limits = {
        cpu    = "100m"
        memory = "150Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "150Mi"
      }
    }
  })
}
```

### Example IAM Role for EKS Addon "vpc-cni" with AWS managed policy

```terraform
resource "aws_eks_cluster" "example" {
  # ... other configuration ...
}

data "tls_certificate" "example" {
  url = aws_eks_cluster.example.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.example.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.example.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "example_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.example.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.example.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "example" {
  assume_role_policy = data.aws_iam_policy_document.example_assume_role_policy.json
  name               = "example-vpc-cni-role"
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.example.name
}
```

## Argument Reference

The following arguments are required:

* `addonName` – (Required) Name of the EKS add-on. The name must match one of
  the names returned by [describe-addon-versions](https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html).
* `clusterName` – (Required) Name of the EKS Cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores ().

The following arguments are optional:

* `addon_version` – (Optional) The version of the EKS add-on. The version must
  match one of the versions returned by [describe-addon-versions](https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-versions.html).
* `configuration_values` - (Optional) custom configuration values for addons with single JSON string. This JSON string value must match the JSON schema derived from [describe-addon-configuration](https://docs.aws.amazon.com/cli/latest/reference/eks/describe-addon-configuration.html).
* `resolve_conflicts_on_create` - (Optional) How to resolve field value conflicts when migrating a self-managed add-on to an Amazon EKS add-on. Valid values are `NONE` and `OVERWRITE`. For more details see the [CreateAddon](https://docs.aws.amazon.com/eks/latest/APIReference/API_CreateAddon.html) API Docs.
* `resolve_conflicts_on_update` - (Optional) How to resolve field value conflicts for an Amazon EKS add-on if you've changed a value from the Amazon EKS default value. Valid values are `NONE` and `OVERWRITE`. For more details see the [UpdateAddon](https://docs.aws.amazon.com/eks/latest/APIReference/API_UpdateAddon.html) API Docs.
* `resolve_conflicts` - (**Deprecated** use the `resolve_conflicts_on_create` and `resolve_conflicts_on_update` attributes instead) Define how to resolve parameter value conflicts when migrating an existing add-on to an Amazon EKS add-on or when applying version updates to the add-on. Valid values are `NONE`, `OVERWRITE` and `PRESERVE`. Note that `PRESERVE` is only valid on addon update, not for initial addon creation. If you need to set this to `PRESERVE`, use the `resolve_conflicts_on_create` and `resolve_conflicts_on_update` attributes instead. For more details check [UpdateAddon](https://docs.aws.amazon.com/eks/latest/APIReference/API_UpdateAddon.html) API Docs.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `preserve` - (Optional) Indicates if you want to preserve the created resources when deleting the EKS add-on.
* `service_account_role_arn` - (Optional) The Amazon Resource Name (ARN) of an
  existing IAM role to bind to the add-on's service account. The role must be
  assigned the IAM permissions required by the add-on. If you don't specify
  an existing IAM role, then the add-on uses the permissions assigned to the node
  IAM role. For more information, see [Amazon EKS node IAM role](https://docs.aws.amazon.com/eks/latest/userguide/create-node-role.html)
  in the Amazon EKS User Guide.
  
  ~> **Note:** To specify an existing IAM role, you must have an IAM OpenID Connect (OIDC)
  provider created for your cluster. For more information, [see Enabling IAM roles
  for service accounts on your cluster](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html)
  in the Amazon EKS User Guide.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the EKS add-on.
* `id` - EKS Cluster name and EKS Addon name separated by a colon (`:`).
* `status` - Status of the EKS add-on.
* `created_at` - Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was created.
* `modified_at` - Date and time in [RFC3339 format](https://tools.ietf.org/html/rfc3339#section-5.8) that the EKS add-on was updated.
* `tags_all` - (Optional) Key-value map of resource tags, including those inherited from the provider [`default_tags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `20m`)
* `update` - (Default `20m`)
* `delete` - (Default `40m`)

## Import

EKS add-on can be imported using the `cluster_name` and `addon_name` separated by a colon (`:`), e.g.,

```
$ terraform import aws_eks_addon.my_eks_addon my_cluster_name:my_addon_name
```

<!-- cache-key: cdktf-0.17.0-pre.15 input-99398c2bd0aed7b71b5ea36294c456725413d33414ee06f984888ab3dbc4d548 -->