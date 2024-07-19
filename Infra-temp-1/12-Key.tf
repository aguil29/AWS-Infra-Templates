resource "aws_key_pair" "Obrigado" {
  key_name  = "Obrigado"
  public_key = file("${path.module}/Obrigado.pem.pub")

tags={
  Name = "Obrigado"
  Owner = "FunkyFingerProductions"
  Planet = "Planet Rock"
  Author = "JRemo"
}
}