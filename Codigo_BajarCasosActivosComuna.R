# Descargar casos activos por comuna


library(readr)
library(RCurl)
library(tidyr)
library(dplyr)
library(openxlsx)
library(formattable)

# ----> Proceso descargar datos casos activos y fallecidos por comuna ----

casos_activos <- getURL("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto19/CasosActivosPorComuna.csv")
data_CasosActivosComunas <- read.csv(text = casos_activos)

fallecidos <- getURL("https://raw.githubusercontent.com/MinCiencia/Datos-COVID19/master/output/producto38/CasosFallecidosPorComuna.csv")
data_FallecidosComunas <- read.csv(text = fallecidos)

# ----> Proceso organizar y filtrar datos casos activos y fallecidos por comuna ----

data_CasosActivosComunas2 <- gather(data_CasosActivosComunas, Fecha, Casos_Activos,-1,-2,-3,-4,-5)
data_CasosActivosComunas2$Fecha <- substring(data_CasosActivosComunas2$Fecha,2)
data_CasosActivosComunas2$Fecha <- gsub("[.]", "/", data_CasosActivosComunas2$Fecha)
data_CasosActivosComunas2$Fecha <- as.Date(data_CasosActivosComunas2$Fecha)

data_FallecidosComunas2 <- gather(data_FallecidosComunas, Fecha, Fallecidos, -1,-2,-3,-4,-5)
data_FallecidosComunas2$Fecha <- substring(data_FallecidosComunas2$Fecha,2)
data_FallecidosComunas2$Fecha <- gsub("[.]","/",data_FallecidosComunas2$Fecha)
data_FallecidosComunas2$Fecha <- as.Date(data_FallecidosComunas2$Fecha)

# ----> Proceso crear Variables Casos cada 100 mil habitantes ----
data_CasosActivosComunas2$ActcienmilHab <- (data_CasosActivosComunas2$Casos_Activos * 100000)/ data_CasosActivosComunas2$Poblacion 

data_CasosActivosComunas2$ActcienmilHab <- round(data_CasosActivosComunas2$ActcienmilHab, digits = 0)

data_FallecidosComunas2$FallcienmilHab <- (data_FallecidosComunas2$Fallecidos * 100000) / data_FallecidosComunas2$Poblacion

data_FallecidosComunas2$FallcienmilHab <- round(data_FallecidosComunas2$FallcienmilHab, digits = 0)

# ----> Crear conjunto de comunas para analisis de situación de colegios ----
comunas_colegios <- c("La Granja", "El Bosque", "Lo Prado", "La Florida", "Pudahuel","Quilicura", "San Bernardo", "Providencia", "Santiago", "Los Angeles")

# ---> Filtrar para obtener los datos de las comunas de interes. 
data_CasosActivosComunasColegios <- filter(data_CasosActivosComunas2, Comuna %in% comunas_colegios)

data_FallecidosComunasColegios <- filter(data_FallecidosComunas2, Comuna %in% comunas_colegios)

# ----> Proceso guardar información en planilla excel ----
setwd("/Users/hector/Drive INQUBO/1- INQUBO ASESORÍA/03-Ejecución/04-Asesoria Framework_SistemaControlGestion/IMGE - Desarrollo Entregables/Reportes Gestión 2020 RedCrecemos/Datos_CasosActivosComuna")

nombrearchivoActivos <- paste("CasosActivosPorComunaColegio_",Sys.Date(),".xlsx", sep = "")

nombrearchivoFallecidos <- paste("FallecidosPorComunaColegio_",Sys.Date(),".xlsx", sep = "")

write.xlsx(data_CasosActivosComunasColegios, nombrearchivoActivos)

write.xlsx(data_FallecidosComunasColegios, nombrearchivoFallecidos)

write.xlsx(data_CasosActivosComunas2, "data_CasosActivosComunas2.xlsx")

write.xlsx(data_FallecidosComunas2, "data_FallecidosComunas2.xlsx")

