# StateScaleSurveyTool
Rmarkdown code to create an example automated word report (and graphs) from example state scale survey CDF and categorical condition population estimates.  The Rmarkdown document is meant to be modified and talored for your specific needs; you would need to customize it based on your population estimates (usually generated with the R package spsurvey).

To use, open the StateScaleSurveyTool folder and click on the green "Clone or download" button to download all R code and shapefiles needed for the example. You will need to update the working directory filepath in the setwd() function in the StateScaleSurveyTool.Rmd to match the folder you downloaded to.  The files include:
1. StateScaleSurveyTool.Rmd - RMarkdown document that integrates text and code to produce graphs
2. SSglobal.R - data wrangling and some functions sourced by StateScaleSurveyTool.Rmd
3. MakeData.R - creation of fake data used in the example and sourced by StateScaleSurveyTool.Rmd 
4. ME-GIS-Master Folder, which contains the shapefiles needed (Coastline2 and Rivers19)
5. StateScaleSurveySupplement1.Rmd - optional, additional code and functions
6. Rendered Documents - word documents rendered from the StateScaleSurveyTool.Rmd and StateScaleSurveySupplement1.Rmd for your reference

Once you download all of the files and set up file paths in the StateScaleSurveyTool.Rmd (and save the SSglobal.R and MakeData.R in the same folder as StateScaleSurveyTool.Rmd), you should be able to run all the code and Render (Knit to word) the StateScaleSurveyTool.Rmd (and/or the StateScaleSurveySupplement1.Rmd).

More information about the code and the data you will need is in the StateScaleSurveyTool.Rmd text (and the rendered word document).

###Software and code
This StateScaleSurveyTool.Rmd report was created using:
R version 3.5.1 (2018-07-02)
RStudio Version 1.1.423
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)




