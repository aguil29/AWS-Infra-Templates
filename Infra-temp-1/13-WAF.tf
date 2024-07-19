#resource - WAF

#web acl name will be 'WAF_sa-east-1_komissarkeisha'

resource "aws_wafv2_web_acl" "WAF_sa-east-1_komissarkeisha" {
  name  = "WAF_sa-east-1_komissarkeisha"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

#rule for AWS web ACL Core Rule Set , aka "AWSManagedRulesCommonRuleSet"
#Cost for Core Rule Set web ACL = FREE
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 2

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesLinuxRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesAnonymousIpList"
    priority = 3

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAnonymousIpListMetric"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 4

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesAmazonIpReputationListMetric"
      sampled_requests_enabled   = true
    }
  }

#rule for AWS web ACL Known Bad Inputs Rule Set, aka "AWSManagedRulesKnownBadInputsRuleSet"
#Cost for Known Bad Inputs Set web ACL = FREE
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 5

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }

  
  tags = {
    Name = "WAF_sa-east-1_komissarkeisha"
    Owner = "FunkyFingerProductions"
    Planet = "Planet Rock"
    Author = "Masayoshi Haruta"
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAF_sa-east-1_komissarkeisha_metric"
    sampled_requests_enabled   = true
  }
}

#associating the ELB to the WAF
resource "aws_wafv2_web_acl_association" "web_acl_association_app1_alb" {
  resource_arn = aws_lb.app1_alb.arn
  web_acl_arn  = aws_wafv2_web_acl.WAF_sa-east-1_komissarkeisha.arn
}


#outputs for ELB and Web ACL
output "resource_arn" {
  value = aws_lb.app1_alb.arn
}

output "web_acl_arn" {
  value = aws_wafv2_web_acl.WAF_sa-east-1_komissarkeisha.arn
}