# StateScaleSurveyTool
This tool is Rmarkdown code that creates an example automated word report (and graphs) from pretend state scale survey CDF and categorical condition population estimates.  This code is largely based on Emma Jones and Jason Hill's (VA) work automating the creation of their IR report Probabilistic Monitoring Chapter.  The Rmarkdown document is meant to be modified and tailored for your specific needs; you will need to customize it based on your population estimates (usually generated with the R package spsurvey) and the results or comparisons you wish to display and highlight.  

To use, open the StateScaleSurveyTool folder in github and click on the green "Clone or download" button to download all R code and shapefiles needed for the example. In the StateScaleSurveyTool.Rmd, you will need to update the working directory filepath in the setwd() function to match where you saved your files.  The files include:
1. StateScaleSurveyTool.Rmd - RMarkdown document that integrates text and code to produce a word report with graphs
2. SSglobal.R - a couple of functions and data wrangling, sourced by StateScaleSurveyTool.Rmd
3. MakeData.R - creation of fake data used in the example and sourced by StateScaleSurveyTool.Rmd.  (You will not need this for your own report.)
4. ME-GIS-Master Folder, which contains the shapefiles needed (Coastline2 and Rivers19)
5. ReferenceStyle2.docx - word document that sets the formatting for the rendered word document
6. StateScaleSurveySupplement1.Rmd - optional, additional code and functions
7. Rendered Documents - word documents rendered from the StateScaleSurveyTool.Rmd and StateScaleSurveySupplement1.Rmd, for your reference

Once you download all of the files and set up file paths in the StateScaleSurveyTool.Rmd (and save the SSglobal.R and MakeData.R in the same folder as StateScaleSurveyTool.Rmd), you should be able to run all the code.  To generate the word document from the StateScaleSurveyTool.Rmd (or Supplement.Rmd) file, click 'Knit->Knit to word' in Rstudio (near to the save icon).

More information about the data, code, and useful tips are in the StateScaleSurveyTool.Rmd text (and the rendered word document).  If you'd like a demonstration, or have any questions, suggestions, or comments, please contact Leah Ettema at EPA's R3 Wheeling, WV office (ettema.leah@epa.gov, 304-234-0245).    

###Software and code specifications
This StateScaleSurveyTool.Rmd report was created using:
R version 3.5.1 (2018-07-02)
RStudio Version 1.1.423
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)




