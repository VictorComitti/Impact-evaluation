library(Synth)
library(dplyr)
library(data.table)

# Reading the file -------------------------------------------------------------

cob_sus <- read.csv("cob_sus.csv", 
                    dec = ".", 
                    sep = ";", 
                    header = TRUE, 
                    fileEncoding = "latin1") %>% 
  setDT()




# Filtering the cohorth of municipalities --------------------------------------

coohort <- cob_sus %>% 
  filter(Município %in% c("Barueri", "Cajamar", "Diadema", "Osasco", "Santo André", 
                          "São Caetano do Sul", "São Bernardo do Campo")) %>% 
  as.data.frame()

# creating the database --------------------------------------------------------

dataprep.out <- dataprep(foo = coohort,
                         predictors = c("pop_ratio",  "DESP_CAP"),
                         predictors.op = "mean", # the operator
                         time.predictors.prior = 2000:2015, 
                         special.predictors = list(
                           list("IDH_MUN", 2010, "mean"),
                           list("LEIT_porc_MUN", 2005:2015,"mean"),
                           list("MED_porc_MUN", 2005:2015,"mean"),
                           list("UBS_porc_MUN", 2005:2015,"mean"),
                           list("PIB_CAP", 2002:2015, "mean"),
                           list("COB_SUS", 2003, "mean"),
                           list("COB_SUS", 2009, "mean"),
                           list("COB_SUS", 2015, "mean"),
                           list("COB_SUS", 2001, "mean"),
                           list("COB_SUS", 2005, "mean"),
                           list("COB_SUS", 2007, "mean"),
                           list("COB_SUS", 2011, "mean"),
                           list("COB_SUS", 2013, "mean")
                         ),
                         dependent = "COB_SUS",
                         unit.variable = "id",
                         unit.names.variable = "Município",
                         time.variable = "Ano",
                         treatment.identifier = 35, #the treated case
                         controls.identifier = id_ideal,
                         time.optimize.ssr = 2000:2015,
                         time.plot = 2000:2020)



dataprep.out$X1
dataprep.out$X0
dataprep.out$Z0
dataprep.out$Z1

# Optimization -----------------------------------------------------------------

synth.out = synth(data.prep.obj = dataprep.out, optimxmethod  = "BFGS")

# Final Result -----------------------------------------------------------------
path.plot(synth.res=synth.out,dataprep.res = dataprep.out, 
          Ylab="Cobertura SUS (%)",Xlab="Ano",
          Ylim = c(0,100),Legend = c("SBC", 
                                     "Synthetic SBC"),
          Legend.position = "bottomleft")

abline(v   = 2015,  lty = 2, col="red")

synth.tables <- synth.tab(
  dataprep.res = dataprep.out,
  synth.res = synth.out)

print(synth.tables)
