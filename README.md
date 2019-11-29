
## Analysis of State of CT open mfi, pension and opeb data

This Project downloads all [State of Connecticut OPB Municipal Fiscal Indicators (MFI) reports](https://portal.ct.gov/OPM/IGP-MUNFINSR/Municipal-Financial-Services/Municipal-Fiscal-Indicators)
from open public Microsoft Access databases. This data is used in the blogpost: 
[Connecticut City Unfunded Pension and OPEB Liabilities Over Time](https://redwallanalytics.com/2019/10/11/connecticut-city-unfunded-pension-and-opeb-liabilities-over-time/)

The file "load_ct_mfi_data_1.Rmd" extracts key data from three tables, the anual CAFR, the pension and opeb tables and 
aggregates and saves "ct_mfi_DT.csv" for the years 2001-2017. In order to download the data, change the variable at line 32 
"maindir" to your working directory and set the chunk to eval = TRUE. 

The file "ct_calc_yankee_2.Rmd" takes "ct_mfi_DT.csv" and attempts to replicate the risk metrics from The Yankee Intitute 
[Warnings 
Signs: Assessing Municipal Fiscal Health in Connecticut](https://yankeeinstitute.org/wp-content/uploads/2018/08/Warning-Signs-min-1.pdf) 
report, but for year's 2004-2017 (instead of just 2016). Because of differences in the available data, the
risk scores will be similar to what would have been calculated by the Yankee Institute. The output yankee.csv is
used in the Shiny app (yankee_shiny). See the blogpost for further detail: 
[Replicating Yankee Institute Risk Score over 15 Years](https://redwallanalytics.com/2019/10/12/replicating-yankee-institute-risk-score-over-15-years/)

https://luceyda.shinyapps.io/yankee_shiny/

The yankee_shiny folder contains the Shiny app used in Replicating Yankee Institute blogpost.

