# I. Definición del _phony_ *all* que enlista todos los objetivos principales
# ===========================================================================
all: tests \
	reports/baja_california_pattern_of_the_blob.pdf \
	reports/impacts_of_climate_change_on_mexican_islands.pdf

# II. Declaración de las variables
# ===========================================================================
# Variables de datos

define renderLatex
cd $(<D) && pdflatex $(<F)
cd $(<D) && pdflatex $(<F)
endef

ncVariablesOceanograficas = \
	inst/extdata/temperatura_superficial_mar.nc \
	inst/extdata/clorofila.nc

# Variables a resultados
#Resultados para el artículo de el blob
pngMapaCoberturaDatosPacificoNorte = \
	reports/figures/mapa_espacio_cobertura_datos_satelitales_pacifico_norte.png

pngDiagramaMatricialPacificoNorte = \
	reports/figures/diagrama_matricial_datos_mensuales.png

pngDiagramaHovmollerAnomaliasPacificoNorte = \
	reports/figures/diagrama_hovmoller_anomalias_mensuales_clorofila_pacifico_norte.png \
	reports/figures/diagrama_hovmoller_anomalias_mensuales_temperatura_pacifico_norte.png

pngAnoTipicoPacificoNorte = \
	reports/figures/ano_tipico_clorofila.png \
	reports/figures/ano_tipico_temperatura.png

pngAnomaliaMensualEstandarizadaPacificoNorte = \
	reports/figures/anomalia_mensual_estandarizada_clorofila_2003_2016_pacifico_norte.png \
	reports/figures/anomalia_mensual_estandarizada_clorofila_2013_2016_pacifico_norte.png \
	reports/figures/anomalia_mensual_estandarizada_temperatura_2003_2016_pacifico_norte.png \
	reports/figures/anomalia_mensual_estandarizada_temperatura_2013_2016_pacifico_norte.png

#Resultados para el artículo de cambio climático
pngNumeroTotalEspeciesPorAreaTodasIslas = \
	reports/figures/grafica_loglog_especies_por_area_todas_islas.png

pngSuperficiePerdidaIncrementoNivelMarTodasIslas = \
	reports/figures/porcentaje_area_perdida_incremento_nivel_mar_todas_islas.png

pngEspeciesAreaPerdidaIslasGolfoMexicoMarCaribe = \
	reports/figures/numero_especies_porcentaje_area_perdida_incremento_nivel_mar_islas_golfo_mar_caribe.png

pngEspeciesPerdidasIncrementoNivelMarTodasIslas = \
	reports/figures/especies_perdidas_incremento_nivel_mar_todas_islas.png

# III. Reglas para construir los objetivos principales
# ===========================================================================
reports/baja_california_pattern_of_the_blob.pdf: reports/baja_california_pattern_of_the_blob.tex \
	$(pngMapaCoberturaDatosPacificoNorte) \
	$(pngDiagramaMatricialPacificoNorte) \
	$(pngDiagramaHovmollerAnomaliasPacificoNorte) \
	$(pngAnoTipicoPacificoNorte) \
	$(pngAnomaliaMensualEstandarizadaPacificoNorte)
	$(renderLatex)

reports/impacts_of_climate_change_on_mexican_islands.pdf: reports/impacts_of_climate_change_on_mexican_islands.tex \
	$(pngNumeroTotalEspeciesPorAreaTodasIslas) \
	$(pngSuperficiePerdidaIncrementoNivelMarTodasIslas) \
	$(pngEspeciesAreaPerdidaIslasGolfoMexicoMarCaribe) \
	$(pngEspeciesPerdidasIncrementoNivelMarTodasIslas) 
	$(renderLatex)
	
# IV. Reglas para construir las dependencias de los objetivos principales
# ===========================================================================
#Construye dependencias para el artículo del blob

$(pngMapaCoberturaDatosPacificoNorte) $(pngDiagramaMatricialPacificoNorte) $(pngDiagramaHovmollerAnomaliasPacificoNorte) $(pngAnoTipicoPacificoNorte) $(pngAnomaliaMensualEstandarizadaPacificoNorte): src/make_image
	mkdir --parents $(@D)
	$< $(@F)

#Construye dependencias para el artículo de cambio climático
$(pngNumeroTotalEspeciesPorAreaTodasIslas) $(pngSuperficiePerdidaIncrementoNivelMarTodasIslas) $(pngEspeciesAreaPerdidaIslasGolfoMexicoMarCaribe) $(pngEspeciesPerdidasIncrementoNivelMarTodasIslas): src/make_image
	mkdir --parents $(@D)
	$< $(@F) 

# V. Reglas del resto de los phonies
# ===========================================================================
# Elimina los residuos de LaTeX

tests:
	geci-checkanalyses

clean:
	rm --force reports/*.pdf
	rm --force reports/*.aux
	rm --force reports/*.out
	rm --force reports/*.log
	rm --force --recursive reports/figures