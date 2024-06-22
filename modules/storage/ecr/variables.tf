variable "repository_name" {
  description = "リポジトリ名"
  type        = string
}

variable "scan_on_push" {
  description = "イメージのプッシュ時にスキャンを実行するかどうか"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "暗号化のタイプ（AES256またはKMS）"
  type        = string
  default     = "AES256"
}

variable "kms_key" {
  description = "KMSキーのARN（encryption_typeがKMSの場合のみ必要）"
  type        = string
  default     = null
}

variable "image_tag_mutability" {
  description = "イメージタグの変更可能性（MUTABLEまたはIMMUTABLE）"
  type        = string
  default     = "MUTABLE"
}

variable "create_repository_policy" {
  description = "リポジトリポリシーを作成するかどうか"
  type        = bool
  default     = false
}

variable "repository_policy" {
  description = "リポジトリポリシーのJSONドキュメント"
  type        = string
  default     = null
}

variable "create_lifecycle_policy" {
  description = "ライフサイクルポリシーを作成するかどうか"
  type        = bool
  default     = false
}

variable "lifecycle_policy" {
  description = "ライフサイクルポリシーのJSONドキュメント"
  type        = string
  default     = null
}