{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "route53:GetChange",
            "Resource": [
                "arn:aws:route53:::change/",
                "arn:aws:route53:::change/*"
                ]
        },
        {
            "Effect": "Allow",
            "Action": "route53:ChangeResourceRecordSets",
            "Resource": [
                ${zone_ids}
            ]
        },
        {
            "Effect": "Allow",
            "Action": "route53:ListHostedZonesByName",
            "Resource": "*"
        },
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Resource": "${role}",
            "Sid": ""
        }
    ]
}
