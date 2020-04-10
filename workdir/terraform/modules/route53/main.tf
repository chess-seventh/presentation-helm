data "aws_route53_zone" "main_zone" {
  for_each     = var.domain_names
  name         = each.value
  private_zone = false
}

resource "aws_route53_zone" "secondary_zone" {
  for_each = var.domain_names
  name     = join(".", [each.key, each.value])
}

resource "aws_route53_record" "secondary_zone_to_main" {
  for_each = var.domain_names
  name     = aws_route53_zone.secondary_zone[each.key].name
  ttl      = 30
  type     = "NS"
  zone_id  = data.aws_route53_zone.main_zone[each.key].zone_id

  records = [
    aws_route53_zone.secondary_zone[each.key].name_servers.0,
    aws_route53_zone.secondary_zone[each.key].name_servers.1,
    aws_route53_zone.secondary_zone[each.key].name_servers.2,
    aws_route53_zone.secondary_zone[each.key].name_servers.3,
  ]
}
