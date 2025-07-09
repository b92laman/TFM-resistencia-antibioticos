library(tidyverse)

# Cargar los datos
amr <- read_tsv("amrfinder_resumen.tsv")

# Filtrar las filas con NA
amr_filtrado <- amr %>%
  filter(!is.na(Type))   

# Agrupar por tipo de resistencia y cepa
genes_por_clase_cepa <- amr_filtrado %>%
  group_by(Type, Isolate) %>%
  summarise(N_genes = n(), .groups = "drop")

# Gráfico: eje x = tipo de resistencia, color = cepa
ggplot(genes_por_clase_cepa, aes(x = Type, y = N_genes, fill = Isolate)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal(base_size = 13) +
  labs(title = "Genes de resistencia por cepa",
       x = "Tipo de resistencia",
       y = "Número de genes detectados",
       fill = "Cepa") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
