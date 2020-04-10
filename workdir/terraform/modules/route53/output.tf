output "zone_ids" {
  description = "Route53 zone IDs"
  value = [
    for id in data.aws_route53_zone.main_zone :
    id.zone_id
  ]
}

output "secondary_zone_ids" {
  description = "Route53 Secondary zone IDs"
  value = [
    for id in aws_route53_zone.secondary_zone :
    id.zone_id
  ]
}
