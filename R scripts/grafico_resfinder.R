library(tidyverse)

# Leer el archivo y asegurarse de que todo es carácter para evitar errores
df <- read_tsv("resumen_resfinder.tsv", col_types = cols(.default = "c")) %>%
  mutate(Cepa = basename(`#FILE`) %>% str_remove("_resfinder.tab"))

# Definir las clases
clases <- list(
  "Betalactámicos"   = c("blaCTX", "blaKPC", "blaOXA", "blaSHV", "blaTEM"),
  "Aminoglucósidos"  = c("aac", "aadA", "ant", "aph", "rmtG"),
  "Quinolonas"       = c("qnr", "oqx", "aac(6')-Ib-cr"),
  "Fenicoles"        = c("cmlA", "floR"),
  "Sulfonamidas"     = c("sul"),
  "Tetraciclinas"    = c("tet"),
  "Macrólidos"       = c("mph"),
  "Fosfomicina"      = c("fosA"),
  "Trimetoprim"      = c("dfrA")
)

# Función para asignar clase
asignar_clase <- function(nombre_gen) {
  for (clase in names(clases)) {
    if (any(str_starts(nombre_gen, clases[[clase]]))) return(clase)
  }
  return("Otros")
}

# Pivotar, filtrar y asignar clases
df_long <- df %>%
  select(-`#FILE`, -NUM_FOUND) %>%
  pivot_longer(-Cepa, names_to = "Gen", values_to = "Presencia") %>%
  filter(Presencia != ".") %>%
  mutate(Clase = map_chr(Gen, asignar_clase))

# Contar genes por clase y cepa
df_clases <- df_long %>%
  group_by(Cepa, Clase) %>%
  summarise(N = n(), .groups = "drop")

# Gráfico
ggplot(df_clases, aes(x = Clase, y = N, fill = Cepa)) +
  geom_col(position = "dodge") +
  labs(title = "Genes de resistencia por clase antibiótica",
       y = "Número de genes", x = "Clase antibiótica") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
