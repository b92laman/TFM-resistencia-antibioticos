library(tidyverse)

# Cargar los datos combinados de AMRFinder
amr <- read_tsv("amrfinder_resumen.tsv")

# Filtrar solo genes de resistencia a antibióticos
amr_filtrado <- amr %>%
  filter(Type == "AMR", !is.na(Class))

# Agrupar por clase antibiótica y cepa
genes_por_clase_cepa <- amr_filtrado %>%
  group_by(Class, Isolate) %>%
  summarise(N_genes = n(), .groups = "drop")

# Crear gráfico
ggplot(genes_por_clase_cepa, aes(x = Class, y = N_genes, fill = Isolate)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal(base_size = 13) +
  labs(title = "Genes de resistencia por clase antibiótica (AMRFinder)",
       x = "Clase antibiótica",
       y = "Número de genes detectados",
       fill = "Cepa") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
