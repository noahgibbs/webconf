# Keeps the Angelbob blog's mongrel processes running

ENV['BLOG_PASSWORD'] = "Opus23HE"
root = "/home/www/checkouts/blog"
mongrel_group("blog", %w{5000}, root)
