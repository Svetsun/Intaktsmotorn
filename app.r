
###############################################
# app.R — Förenklad Excel-struktur
#
# Behåller:
# - Per-flik spar + global "Spara Alla" med backup
# - Uppgift-formulär (kund -> uppdrag filtreras) + uppgift_name
# - Tidrapportering: kund -> uppdrag -> uppgift (dropdown) + uppgift_name visas i tabell
# - Rapport-flik + export
# - Historik read-only med namn
#
# NYTT (DENNA VERSION):
# - Kund-flik: val av Fakturamottagare typ (Kund/Mäklare)
#   -> skapar FM-rad automatiskt vid "Lägg till kund"
###############################################

# ── renv ──────────────────────────────────────────────────────────────────────
# .Rprofile is NOT deployed to Posit Connect Cloud (it is gitignored), so the
# renv activation that normally lives there must be done here instead.
# On Connect, CONNECT_SERVER is set by the platform — we skip renv because
# packages are already installed from manifest.json into the server library.
# Locally, we activate renv so the project-local library is used.
if (nchar(Sys.getenv("CONNECT_SERVER")) == 0 && file.exists("renv/activate.R")) {
  source("renv/activate.R")
}

# ── packages ──────────────────────────────────────────────────────────────────
# rhandsontable loaded first and explicitly so that any installation/path error
# surfaces immediately. Namespace-qualified calls (rhandsontable::*) are used
# throughout the app as a belt-and-suspenders guard against library-path issues.
library(rhandsontable)

suppressPackageStartupMessages({
  library(shiny)
  library(readxl)
  library(writexl)
  library(janitor)
  library(dplyr)
  library(lubridate)
  library(stringr)
})

# ===================== KONFIG =====================

source("R/config.R",               encoding = "UTF-8")
source("R/helpers_core.R",         local = environment(), encoding = "UTF-8")
source("R/helpers_ids_labels.R",   local = environment(), encoding = "UTF-8")
source("R/helpers_hot.R",          local = environment(), encoding = "UTF-8")
source("R/helpers_history.R",      local = environment(), encoding = "UTF-8")

# ===================== ENSURE SHEETS =====================

source("R/helpers_ensure.R",       local = environment(), encoding = "UTF-8")
source("R/helpers_report.R",       local = environment(), encoding = "UTF-8")
source("R/interval_report.R",      local = environment(), encoding = "UTF-8")

# ===================== DISPLAY HELPERS =====================

source("R/helpers_display.R",      local = environment(), encoding = "UTF-8")

# ===================== UI =====================

source("R/ui.R",                   encoding = "UTF-8")

# ===================== SERVER =====================

source("R/server_refresh.R",       local = environment(), encoding = "UTF-8")
source("R/server_add_handlers.R",  local = environment(), encoding = "UTF-8")
source("R/server.R",               encoding = "UTF-8")

shinyApp(ui, server)
