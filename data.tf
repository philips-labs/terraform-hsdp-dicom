data "hsdp_iam_user" "user" {
  depends_on = [var.user_logins]
  count      = length(var.user_logins)
  username   = var.user_logins[count.index]
}

data "hsdp_iam_user" "admin" {
  depends_on = [var.admin_logins]
  count      = length(var.admin_logins)
  username   = var.user_logins[count.index]
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
