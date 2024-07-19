resource "aws_launch_template" "app1_LT" {
  name_prefix   = "app1_LT"
  image_id      = "ami-05dc908211c15c11d"  
  instance_type = "t3.micro" #t3.micro instance-type works for all AZs in the sa-east-1 region

  key_name = "Obrigado"

  vpc_security_group_ids = [aws_security_group.app1-80-sg01-servers.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd

    # Get the IMDSv2 token
    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    # Background the curl requests
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
    wait

    macid=$(cat /tmp/macid)
    local_ipv4=$(cat /tmp/local_ipv4)
    az=$(cat /tmp/az)
    vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$macid/vpc-id)

    # Create HTML file
    cat <<-HTML > /var/www/html/index.html
    <!doctype html>
    <html lang="en" class="h-100">
    <head>
    <title>Details for EC2 instance</title>
    </head>
    <body style="background-color:#E61919;">
    <div>
    <h1>Funky Finger Produções Apresenta</h1>
    <h1>Shadaloo WAF</h1>
    <br>
    <img src = "https://1.bp.blogspot.com/-KYeO7c8CES0/VvfFYMepZRI/AAAAAAAABzM/3CQM0-lIM_MOyuiK_8yhibnDjVK9J-HWQ/s1600/M.%2BBison.gif" alt="1.bp.blogspot.com">
    <br> 
    
    
    <h1>São Paulo Is All Ours, Sho Nuff!</h1>
    <br>
    <img src = "https://www.sfrpg.com.br/img/2009/12/Psycho-Drive-em-Acao.gif" alt="sfrpg.com.br">
    <br>
    <br>
    <iframe width="560" height="315" src="https://www.youtube.com/embed/JH1vUJxn8gU?si=mc-FcjPieRtOMQKm" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
    <br>
    <p><b>Instance Name:</b> $(hostname -f) </p>
    <p><b>Instance Private Ip Address: </b> $local_ipv4</p>
    <p><b>Availability Zone: </b> $az</p>
    <p><b>Virtual Private Cloud (VPC):</b> $vpc</p>
    <br>
    <img src = "https://filmschoolrejects.com/wp-content/uploads/2019/09/Lava.gif" alt="filmschoolrejects.com">
    <br>

    </div>
    </body>
    </html>
    HTML

    # Clean up the temp files
    rm -f /tmp/local_ipv4 /tmp/az /tmp/macid
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "app1_LT"
      Service = "application1"
      Owner   = "FunkyFingerProductions"
      Planet  = "Planet Rock"
      Author  = "JRemo"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}