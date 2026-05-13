variable "pxe_bucket_name" {
  type      = string
  sensitive = true
}

variable "pxe_ip_cidr_ranges" {
  type      = list(string)
  sensitive = true
}

variable "pxe_bucket_ip_filter" {
  type = bool
}

resource "google_storage_bucket" "pxe" {
  location = "eu"
  name     = var.pxe_bucket_name

  autoclass {
    enabled = true

    terminal_storage_class = "ARCHIVE"
  }

  ip_filter {
    mode = var.pxe_bucket_ip_filter ? "Enabled" : "Disabled"

    public_network_source {
      allowed_ip_cidr_ranges = var.pxe_ip_cidr_ranges
    }
  }
}

data "google_iam_workload_identity_pool" "github" {
  provider = google-beta

  workload_identity_pool_id = "github"

  project = "drakon64"
}

resource "google_storage_bucket_iam_member" "pxe" {
  bucket = google_storage_bucket.pxe.name
  member = "principalSet://iam.googleapis.com/${data.google_iam_workload_identity_pool.github.name}/attribute.repository/drakon64/nixos-config"
  role   = "roles/storage.admin"
}

resource "google_storage_bucket_object" "pxe" {
  for_each = {
    bzImage      = "../result/bzImage"
    initrd       = "../result-2/initrd"
    "chain.ipxe" = "../result-3"
  }

  bucket = google_storage_bucket.pxe.name
  name   = each.key

  source = each.value
}

resource "google_project_iam_custom_role" "pxe" {
  permissions = ["storage.buckets.exemptFromIpFilter"]
  role_id     = "storage.buckets.exemptFromIpFilter"
  title       = "Cloud Storage Exempt From IP Filter"

  project = google_storage_bucket.pxe.project
}

resource "google_project_iam_member" "pxe" {
  member  = "principalSet://iam.googleapis.com/${data.google_iam_workload_identity_pool.github.name}/attribute.repository/drakon64/nixos-config"
  project = google_storage_bucket.pxe.project
  role    = "roles/iam.roleViewer"
}

resource "google_project_iam_member" "pxe2" {
  member  = "principalSet://iam.googleapis.com/${data.google_iam_workload_identity_pool.github.name}/attribute.repository/drakon64/nixos-config"
  project = google_storage_bucket.pxe.project
  role    = google_project_iam_custom_role.pxe.id

  depends_on = [google_project_iam_member.pxe]
}
