# Keeps Shanna's Daddy Software mongrel processes running

root = "/home/www/checkouts/shannasdaddy"
mongrel_group("sds", %w{8300}, root)
