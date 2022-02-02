#Configurar ruta del archivo
#setwd("Dropbox/documentosA/Estaciones_UNIR/raw_data_senamhi/estaciones_txt_climatol")
setwd("C:/Users/Angélica Andrade/Dropbox/documentosA/TFM_UNIR_2022/datos/estaciones_climatol")
getwd()

#Instalar Climatol -  solo instalar una vez
#install.packages("climatol")
#Cargar climatol
library(climatol)

#Ver Funciones climatol (Opcional - para abrir el archivo de funciones)
#View(daily2climatol)

#Convertir datos  a formato climatol
#mindat = 1905 = 365 x 3 (3 a?os)

anio_min<-1981 #a?o m?nimo para el an?lisis
anio_max<-2020 #a?o m?ximo para el an?lisis

#1.Convertir los datos a formato climatol 
daily2climatol(stfile = "stations.txt", stcol = 1:6, datcol = c(1:3,4), varcli="pre",anyi = anio_min,anyf = anio_max, mindat = 1095, sep = ",", na.strings = "NA")

#2.Aplicar homogen en modo exploratorio diario
homogen("pre",anio_min, anio_max, expl = TRUE)

#3.Transformar los datos diarios a datos mensuales  valm = 1 para precipitaci?n
dd2m(varcli = "pre",anio_min,anio_max,valm = 1)

#4.Aplicar homogen en modo exploratorio mensual
homogen("pre-m",anio_min, anio_max, expl = TRUE)

#5.Ajuste mensual  std = 2 (El valor 2 se utiliza para variables como precipitaci?n)
#dz.min y dz.max Histogram of normalized anomalies 
#Histogram of maximum windowed SNHT para snht1  ,  Histogram of maximum global SNHT  snht2
homogen("pre-m",anio_min, anio_max, dz.min = -9, dz.max = 10, snht1 = 30, snht2 = 44, std =2, cutlev = 2.3, vmin = 0 )

#6.Ajuste diario (metad = TRUE toma los break mensuales)
homogen("pre",anio_min, anio_max,  dz.min = -16, dz.max = 26, snht1 = 220, snht2 = 250, std =2, vmin = 0, metad = TRUE)

#7.Cargar el archivo rda generado que muestra SNHT y RMSE
#load("pre_1980-2020.rda")
#View(est.c)

#8.Cargar el archivo rda generado que muestra SNHT y RMSE
load("pre-m_1981-2020.rda")
View(est.c)

#9.Generar las series homogenizadas diarias
dahstat('pre',anio_min,anio_max, stat = 'series')

#10GEnerar las series homogenizadas mensuales
dahstat('pre-m',anio_min,anio_max, stat = 'series')


#PARA TEMPERATURA M?XIMA
#Convertir datos  a formato climatol
#mindat = 1905 = 365 x 3 (3 a?os)

#1.Convertir los datos a formato climatol 
daily2climatol(stfile = "stations.txt", stcol = 1:6, datcol = c(1:3,5), varcli="tmax",anyi = anio_min ,anyf = anio_max, mindat = 365, sep = ",", na.strings = "NA")

class(anio_min)
#2.Aplicar homogen en modo exploratorio diario
homogen("tmax",anio_min, anio_max, expl = TRUE)

#3.Transformar los datos diarios a datos mensuales  valm = 2 para temperatua maxima
#View(dd2m)
dd2m(varcli = "tmax", anio_min,anio_max,valm = 2)

#4.Aplicar homogen en modo exploratorio mensual
homogen("tmax-m",anio_min, anio_max, expl = TRUE)

#5.Ajuste mensual  std =3 (El valor 3 se utiliza para variables como temperatura m?xima y m?nima)
homogen("tmax-m",anio_min, anio_max, dz.min = -8, dz.max = 6, snht1 = 80, snht2 = 170, std = 3, vmin = -10, cutlev = 2.3 )

#6.Ajuste diario (metad = TRUE toma los break mensuales)
homogen("tmax",anio_min, anio_max, dz.min = -30, dz.max = 50, snht1 = 500, snht2 = 3500,std =3, vmin = -10, vmax = 30, metad = TRUE)

#Cargar el archivo rda generado que muestra SNHT y RMSE
#load("tmax_1980-2020.rda")
#View(est.c)

#GEnerar las series homogenizadas diarias
dahstat('tmax',anio_min,anio_max, stat = 'series')

#GEnerar las series homogenizadas mensuales
dahstat('tmax-m',anio_min,anio_max, stat = 'series')


#PARA TEMPERATURA MINIMA
#Convertir datos  a formato climatol
#mindat = 1905 = 365 x 3 (3 a?os)

#1.Convertir los datos a formato climatol 
daily2climatol(stfile = "stations.txt", stcol = 1:6, datcol = c(1:3,6), varcli="tmin",anyi = anio_min ,anyf = anio_max, mindat = 365, sep = ",", na.strings = "NA")

#2.Aplicar homogen en modo exploratorio diario
homogen("tmin",anio_min, anio_max, expl = TRUE)

#3.Transformar los datos diarios a datos mensuales  valm = 2 (mean) para temperatura
#View(dd2m)
dd2m(varcli = "tmin", anio_min,anio_max,valm = 2)

#4.Aplicar homogen en modo exploratorio mensual
homogen("tmin-m",anio_min, anio_max, expl = TRUE)

#5.Ajuste mensual  std =3 (El valor 3 se utiliza para variables como temperatura m?xima y m?nima)
homogen("tmin-m",anio_min, anio_max, dz.min = -5, dz.max = 6, snht1 = 80, snht2 = 170, std = 3, vmin = -20 , cutlev = 2.3)

#6.Ajuste diario (metad = TRUE toma los break mensuales)
homogen("tmin",anio_min, anio_max, dz.min = -13, dz.max = 12, snht1 = 400, snht2 = 2400, std =3, vmin = -20, vmax = 30 , metad = TRUE)

#7.-Cargar el archivo rda generado que muestra SNHT y RMSE
#load("tmin_1980-2020.rda")

#8.-La opci?n View muestra el resumen estad?stico de los resultados
#View(est.c)

#9.-Generar las series homogenizadas diarias
dahstat('tmin',anio_min,anio_max, stat = 'series')

#9.-Generar las series homogenizadas mensuales
dahstat('tmin-m',anio_min,anio_max, stat = 'series')


#PARA TEMPERATURA MEDIA   CAMBIAR
#Convertir datos  a formato climatol
#mindat = 1905 = 365 x 3 (3 a?os)

#1.Convertir los datos a formato climatol 
daily2climatol(stfile = "stations.txt", stcol = 1:6, datcol = c(1:3,7), varcli="tmed",anyi = anio_min ,anyf = anio_max, mindat = 365, sep = ",", na.strings = "NA")

#2.Aplicar homogen en modo exploratorio diario
homogen("tmed",anio_min, anio_max, expl = TRUE)

#3.Transformar los datos diarios a datos mensuales  valm = 2 (mean) para temperatura
#View(dd2m)
dd2m(varcli = "tmed", anio_min,anio_max,valm = 2)

#4.Aplicar homogen en modo exploratorio mensual
homogen("tmed-m",anio_min, anio_max, expl = TRUE)

#5.Ajuste mensual  std =3 (El valor 3 se utiliza para variables como temperatura m?xima y m?nima)
homogen("tmed-m",anio_min, anio_max, dz.min = -5, dz.max = 6, snht1 = 80, snht2 = 170, std = 3, vmin = -20 , cutlev = 2.3)

#6.Ajuste diario (metad = TRUE toma los break mensuales)
homogen("tmed",anio_min, anio_max, dz.min = -10, dz.max = 12, snht1 = 400, snht2 = 2200, std =3, vmin = -20, vmax = 30 , metad = TRUE)

#7.-Cargar el archivo rda generado que muestra SNHT y RMSE
#load("tmed_1980-2020.rda")

#8.-La opci?n View muestra el resumen estad?stico de los resultados
#View(est.c)

#9.-Generar las series homogenizadas diarias
dahstat('tmed',anio_min,anio_max, stat = 'series')

#9.-Generar las series homogenizadas mensuales
dahstat('tmed-m',anio_min,anio_max, stat = 'series')

