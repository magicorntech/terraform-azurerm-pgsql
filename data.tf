resource "random_string" "dbuser" {
  length  = 12
  numeric = false
  special = false
}

resource "random_password" "dbpass" {
  length           = 16
  special          = true
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 2
  min_special      = 2
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
