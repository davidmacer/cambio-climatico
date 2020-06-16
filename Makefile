# I. Definición del _phony_ *all* que enlista todos los objetivos principales
# ===========================================================================
all: tests \
	reports/baja_california_pattern_of_the_blob.pdf \
	reports/impacts_of_climate_change_on_mexican_islands.pdf

# II. Declaración de las variables
# ===========================================================================
# Variables de datos
ncVariablesOceanograficas = \
	inst/extdata/temperatura_superficial_mar.nc \
	inst/extdata/clorofila.nc

# Variables a resultados
#Resultados para el artículo de el blob
pngMapaCoberturaDatosPacificoNorte = \
	resultados/mapa_espacio_cobertura_datos_satelitales_pacifico_norte.png

pngDiagramaMatricialPacificoNorte = \
	resultados/diagrama_matricial_datos_mensuales.png

pngDiagramaHovmollerAnomaliasPacificoNorte = \
	resultados/diagrama_hovmoller_anomalias_mensuales_clorofila_pacifico_norte.png \
	resultados/diagrama_hovmoller_anomalias_mensuales_temperatura_pacifico_norte.png

pngAnoTipicoPacificoNorte = \
	resultados/ano_tipico_clorofila.png \
	resultados/ano_tipico_temperatura.png

pngAnomaliaMensualEstandarizadaPacificoNorte = \
	resultados/anomalia_mensual_estandarizada_clorofila_2003_2016_pacifico_norte.png \
	resultados/anomalia_mensual_estandarizada_clorofila_2013_2016_pacifico_norte.png \
	resultados/anomalia_mensual_estandarizada_temperatura_2003_2016_pacifico_norte.png \
	resultados/anomalia_mensual_estandarizada_temperatura_2013_2016_pacifico_norte.png

#Resultados para el artículo de cambio climático
pngNumeroTotalEspeciesPorAreaTodasIslas = \
	resultados/grafica_loglog_especies_por_area_todas_islas.png

pngSuperficiePerdidaIncrementoNivelMarTodasIslas = \
	resultados/porcentaje_area_perdida_incremento_nivel_mar_todas_islas.png

pngEspeciesAreaPerdidaIslasGolfoMexicoMarCaribe = \
	resultados/numero_especies_porcentaje_area_perdida_incremento_nivel_mar_islas_golfo_mar_caribe.png

pngEspeciesPerdidasIncrementoNivelMarTodasIslas = \
	resultados/especies_perdidas_incremento_nivel_mar_todas_islas.png

# III. Reglas para construir los objetivos principales
# ===========================================================================
reports/baja_california_pattern_of_the_blob.pdf: reports/baja_california_pattern_of_the_blob.tex \
	$(pngMapaCoberturaDatosPacificoNorte) \
	$(pngDiagramaMatricialPacificoNorte) \
	$(pngDiagramaHovmollerAnomaliasPacificoNorte) \
	$(pngAnoTipicoPacificoNorte) \
	$(pngAnomaliaMensualEstandarizadaPacificoNorte)
	cd reports && pdflatex $(<F)
	cd reports && pdflatex $(<F)

reports/impacts_of_climate_change_on_mexican_islands.pdf: reports/impacts_of_climate_change_on_mexican_islands.tex \
	$(pngNumeroTotalEspeciesPorAreaTodasIslas) \
	$(pngSuperficiePerdidaIncrementoNivelMarTodasIslas) \
	$(pngEspeciesAreaPerdidaIslasGolfoMexicoMarCaribe) \
	$(pngEspeciesPerdidasIncrementoNivelMarTodasIslas) 
	cd reports && pdflatex $(<F)
	cd reports && pdflatex $(<F)

# IV. Reglas para construir las dependencias de los objetivos principales
# ===========================================================================
#Construye dependencias para el artículo del blob

$(pngMapaCoberturaDatosPacificoNorte) $(pngDiagramaMatricialPacificoNorte) $(pngDiagramaHovmollerAnomaliasPacificoNorte) $(pngAnoTipicoPacificoNorte) $(pngAnomaliaMensualEstandarizadaPacificoNorte): src/make_image
	if [ ! -d $(@D) ]; then mkdir -p $(@D); fi
	$< $(@F)

#Construye dependencias para el artículo de cambio climático
$(pngNumeroTotalEspeciesPorAreaTodasIslas) $(pngSuperficiePerdidaIncrementoNivelMarTodasIslas) $(pngEspeciesAreaPerdidaIslasGolfoMexicoMarCaribe) $(pngEspeciesPerdidasIncrementoNivelMarTodasIslas): src/make_image
	if [ ! -d $(@D) ]; then mkdir -p $(@D); fi
	$< $(@F) 

# V. Reglas del resto de los phonies
# ===========================================================================
# Elimina los residuos de LaTeX

tests:
	geci-checkanalyses

clean:
	rm reports/*.pdf
	rm reports/*.aux
	rm reports/*.out
	rm reports/*.log