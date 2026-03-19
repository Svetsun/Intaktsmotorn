# ===================== KONFIG =====================
# Central configuration for the Roban Shiny app.
# All environment-specific constants live here.
# Source this file at the top of app.R.

# Path to the Excel workbook used as the data store.
# On Posit Connect Cloud the data/ folder may not be present, so we fall back
# to downloading the file from GitHub and caching it in a temp location.
.local_xlsx  <- file.path("data", "Base_data.xlsx")
.github_url  <- "https://raw.githubusercontent.com/Svetsun/Intaktsmotorn/main/data/Base_data.xlsx"

if (file.exists(.local_xlsx)) {
  TARGET_XLSX <- .local_xlsx
} else {
  .tmp <- tempfile(fileext = ".xlsx")
  download.file(.github_url, destfile = .tmp, mode = "wb", quiet = TRUE)
  TARGET_XLSX <- .tmp
  rm(.tmp)
}

rm(.local_xlsx, .github_url)

# Revenue threshold above which the bonus percentage applies (SEK / month).
BONUS_THRESHOLD <- 100000

# Date columns per sheet — used by normalize_wb_dates() to coerce date fields
# after reading the workbook from disk.
DATE_COLS_MASTER <- list(
  "Konsulter"              = c("startdatum", "slutdatum"),
  "Uppdrag"                = c("startdatum", "slutdatum"),
  "Uppgift"                = c("startdatum", "slutdatum", "created_at"),
  "Tidrapportering"        = c("startdatum", "slutdatum", "created_at"),
  "TimprisHistory"         = c("created_at"),
  "GrundlonHistory"        = c("created_at"),
  "BonusHistory"           = c("created_at"),
  "GroupBonusHistory"      = c("created_at"),
  "SalesBonusHistory"      = c("created_at"),
  "Maklare"                = c("created_at"),
  "Kunder"                 = c("created_at"),
  "ArbetstimmarGrund"      = c("date"),
  "FaktureringInformation" = c()
)
