locals {
  lambdas = {
    lambda = {
      function_name     = "hello-world-lambda"
      bucket_id         = module.s3["lambda_bucket"].bucket_id
      bucket_object_key = module.s3["lambda_bucket"].bucket_objects["lambda.zip"].key
      handler           = "hello.handler"
      runtime           = "nodejs12.x"
      file_path         = "${path.root}/../lambda/zip/lambda.zip"
      vpc_config        = false
      env_vars          = {}
      # atachear a vpc cuando no se este probando debido al tiempo que tarda en borrar las enis en el destroy (aprox 45 mins segun wiki) 
      # subnet_ids          = values(module.vpc["vpc"].private_subnets)
      subnet_ids         = [for k, v in module.vpc["vpc"].private_subnets : tostring(v.id)]
      security_group_ids = [module.security_group["lambda_sg"].id]
      vpc_config         = true
    }
  }
}

module "lambda" {
  source   = "./lambda"
  for_each = local.lambdas

  function_name      = try(each.value.function_name, "")
  bucket_id          = try(each.value.bucket_id, "")
  bucket_object_key  = try(each.value.bucket_object_key, "")
  handler            = try(each.value.handler, "")
  runtime            = try(each.value.runtime, "")
  security_group_ids = try(each.value.security_group_ids, [])
  subnet_ids         = try(each.value.subnet_ids, [])
  env_vars           = try(each.value.env_vars, {})
  file_path          = try(each.value.file_path, "")
  vpc_config         = try(each.value.vpc_config, false)
}