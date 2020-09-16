library(highcharter)
library(dplyr)

# Crea funcion de Grafico para grupo de comunas de los colegios
Chartevolucion <- function(datoscomunas, ymaximo){
  
  hc <- hchart(datoscomunas, "areaspline", 
               hcaes(x = Fecha, y = Casos_Activos), 
               name = "Casos Activos",
               color = "#6fb9d7") %>%
    hc_yAxis(title = list(text = "Casos Activos"),
             max = ymaximo,
             crosshair = TRUE)%>%
    hc_xAxis(title = list(text ="Fechas según publicación Informe Epidemiológico"),
             crosshair = TRUE) %>%
    hc_title(text = "Evolución de Casos Activos") %>%
    hc_subtitle(text = paste0("al ", ultimafecha_Activos)) %>%
    hc_credits(enabled = TRUE, text = "http://www.redcrecemos.cl/") %>%
    hc_tooltip(sort = TRUE, table = TRUE) %>% 
    hc_caption(text = "Fuente: Elaboración propia en base a último Informe Epidemiológico")
  
  hc
}

# Crea Funcion de grafico para otras comunas
Graficoevolucionactivos <- function(datoscomunas){
  
  hc <- hchart(datoscomunas, "areaspline", 
               hcaes(x = Fecha, y = Casos_Activos), 
               name = "Casos Activos",
               color = "#6fb9d7") %>%
    hc_yAxis(title = list(text = "Casos Activos"),
             crosshair = TRUE)%>%
    hc_xAxis(title = list(text ="Fechas según publicación Informe Epidemiológico"),
             crosshair = TRUE) %>%
    hc_title(text = "Evolución de Casos Activos") %>%
    hc_subtitle(text = paste0("al ", ultimafecha_Activos)) %>%
    hc_credits(enabled = TRUE, text = "http://www.redcrecemos.cl/") %>%
    hc_tooltip(sort = TRUE, table = TRUE) %>% 
    hc_caption(text = "Fuente: Elaboración propia en base a último Informe Epidemiológico")
  
  hc
}


