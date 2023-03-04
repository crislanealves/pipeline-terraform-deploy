module "bigquery-dataset-gasolina" {
  source  = "./modules/bigquery"
  
  dataset_id                  = "br_anp_precos_combustiveis"
  dataset_name                = "br_anp_precos_combustiveis"
  description                 = "A ANP acompanha os preços praticados por revendedores de combustíveis automotivos e de gás liquefeito de petróleo envasilhado em botijões de 13 quilos (GLP P13), por meio de uma pesquisa semanal de preços realizada por empresa contratada." # Descrição da BD
  project_id                  = var.project_id
  location                    = var.region
  delete_contents_on_destroy  = true
  deletion_protection         = false
  access = [
    {
      role          = "OWNER"
      special_group = "projectOwners"
    },
    {
      role          = "READER"
      special_group = "projectReaders"
    },
    {
      role          = "WRITER"
      special_group = "projectWriters"
    }
  ]
  tables=[
    {
        table_id           = "microdados",
        description        = "Série Histórica de Preços de Combustíveis - a saber, gasolina, gasolina aditivada, etanol, diesel s10, diesel, gnv e glp - com base na pesquisa de preços da Agência Nacional do Petróleo, Gás Natural e Biocombustíveis realizada a partir da primeira semana de 2004 até os dias de hoje."
        time_partitioning  = {
          type                     = "DAY",
          field                    = "data",
          require_partition_filter = false,
          expiration_ms            = null
        },
        range_partitioning = null,
        expiration_time    = null,
        clustering         = ["produto", "regiao_sigla", "estado_sigla"],
        labels             = {
          name    = "stack_data_pipeline"
          project  = "gasolina"
        },
        deletion_protection = true
        schema = file("./bigquery/schema/br_anp_precos_combustiveis/microdados.json")
    }
  ]
}

module "bucket-raw" {
  source  = "./modules/gcs"

  name       = "camada-raw"
  project_id = var.project_id
  location   = var.region
}

module "bucket-trusted" {
  source  = "./modules/gcs"

  name       = "camada-trusted"
  project_id = var.project_id
  location   = var.region
}

module "bucket-pyspark-tmp" {
  source  = "./modules/gcs"

  name       = "camada-pyspark-tmp"
  project_id = var.project_id
  location   = var.region
}

module "bucket-pyspark-code" {
  source  = "./modules/gcs"

  name       = "camada-pyspark-code"
  project_id = var.project_id
  location   = var.region
}