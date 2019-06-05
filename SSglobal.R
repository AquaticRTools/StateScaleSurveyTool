# Presets for easier reports year to year - change to match your IR report
Agency<-'DEQ'
IRyear <- '2018'
IRyearWindowEnd <- '2016'
IRrange <- '2011 - 2016'
State <- 'Middle Earth'

#CDFdata<- read.csv('SS_allCDF.csv') #you would read in CDF data here
CDFdat<-CDFdat2 %>%  #For this example, CDF data is hard coded into MakeData.R
  mutate(MoE.P=StdError.P*1.96) #Margin of Error at 95% confidence interval is 1.96*StdError.P

# VLOOKUP (Excel function hack) by Julin Maloof
#extracts the rows (values) and columns (parameters) you want from your CDF data

vlookup <- function(ref, #the value or values that you want to look for
                    table, #the table where you want to look for it; will look in first column
                    column, #the column number that you want the return data to come from,
                    range=FALSE, #if there is not an exact match, return the closest?
                    larger=FALSE) #if doing a range lookup, should the smaller or larger key be used?)
{
  if(!is.numeric(column) & !column %in% colnames(table)) {
    stop(paste("can't find column",column,"in table"))
  }
  if(range) {
    if(!is.numeric(table[,1])) { #1 is always parameter values in VA's code
      stop(paste("The first column of table must be numeric when using range lookup"))
    }
    table <- table[order(table[,1]),] 
    index <- findInterval(ref,table[,1])
    if(larger) {
      index <- ifelse(ref %in% table[,1],index,index+1)
    }
    output <- table[index,column]
    output[!index <= dim(table)[1]] <- NA
    
  } else {
    output <- table[match(ref,table[,1]),column]
    output[!ref %in% table[,1]] <- NA
  }
  dim(output) <- dim(ref)
  output
}

# #### Add line to ggplot label function
#See https://stackoverflow.com/questions/20123147/add-line-break-to-axis-labels-and-ticks-in-ggplot
addline_format <- function(x,...){
  gsub('\\s','\n',x)}

# PH CDF DATA wrangling
#filtering CDF table for pH data to prepare to look up values that do not meet pH criteria for the entire state
pH <- filter(CDFdat,Subpopulation=='MiddleEarth'&Indicator=='pH') %>% 
  select(Value,Estimate.P, MoE.P)

#looking up values to show percent of acidic streams (below 6) as a table in word
#you will have to insert your own criteria into the first value of the vlookup function
totalspH <- data.frame(Condition=c('Below'), #changed from suboptimal to below
                       pct=vlookup(6,pH,2,TRUE), # vlookup variables: 6 = criteria, pH = data, 2 = column, TRUE=return closest value
                       MoE=vlookup(6,pH,3, TRUE)) %>%
            mutate(Parameter='pH (Below 6)')%>%select(Parameter,everything())

#creating table to show percent of streams not meeting standards
pHsummary <- data.frame(Parameter='pH',
                        Below=vlookup(6,pH,2,TRUE),
                        Above=100-vlookup(9,pH,2,TRUE),
                        BelowError=vlookup(6,pH,3,TRUE),
                        AboveError=vlookup(9,pH,3,TRUE))
pHsummary <- mutate(pHsummary,BelowStd=paste(formatC(Below,digits=2),"% ( +/- ",formatC(BelowError,digits=2),"% )", sep=""),
                    AboveStd=paste(formatC(Above,digits=2),"% ( +/- ",formatC(AboveError,digits=2),"% )", sep=""))%>%
             select(Parameter,BelowStd,AboveStd)
colnames(pHsummary)<-c('Parameter','Below Standard ( pH 6 )','Above Standard ( pH 9)')


# HABITAT CDF DATA
#filtering for Habitat data to prepare to look up values that do not meet thresholds
hab <- filter(CDFdat,Subpopulation=='MiddleEarth'&Indicator=='TotHab')%>%
  select(Value,Estimate.P, MoE.P)

#looking up percent of streams not meeting threshold
#you will have to insert your own thresholds into the first value of the vlookup function
totalshab <- data.frame(Condition=c('Suboptimal','Fair','Optimal'),
                        pct=c(vlookup(120,hab,2,TRUE), #suboptimal
                              vlookup(150,hab,2,TRUE)-vlookup(120,hab,2,TRUE), # fair
                              100-vlookup(150,hab,2,TRUE)))%>% #optimal
  mutate(Parameter='Habitat Disturbance')%>%select(Parameter,everything())
totalshab$Condition <- factor(totalshab$Condition,levels = unique(totalshab$Condition))

#for table displaying % of streams not meeting thresholds 
totalshabbelow <- data.frame(Condition=c('Below'), #changed condition from suboptimal to below
                                  pct=c(vlookup(120,hab,2,TRUE)),
                                  MoE=vlookup(120,hab, 3, TRUE)) %>%
                  mutate(Parameter='Habitat Disturbance')%>%
                  select(Parameter,everything())

# MMI CDF DATA
#filtering for MMI data to prepare to look up values that do not meet criteria
MMI <- filter(CDFdat,Subpopulation=='MiddleEarth'&Indicator=='MMI')%>%
       select(Value,Estimate.P, MoE.P) 

#looking up percent of streams not meeting threshold
#you will have to insert your own criteria into the first value of the vlookup function
totalsMMI <- data.frame(Condition=c('Below'),
                         pct=vlookup(60, MMI, 2, TRUE),
                         MoE=vlookup(60, MMI, 3, TRUE)) %>%
              mutate(Parameter='MMI (Biomonitoring)')%>%
              select(Parameter,everything()) #for word table

# initial CDF Graph
paramsummary <- rbind(totalshabbelow,totalspH, totalsMMI)%>%
  mutate(Standard=c('no', 'yes','yes'))
paramsummary$Parameter <- c('Habitat\nDisturbance', 'pH\n(Below 6)',
                            'MMI\n(Biomonitoring)')
paramsummary$Parameter <- factor(paramsummary$Parameter,
                                 levels=c('pH\n(Below 6)', 'Habitat\nDisturbance', 'MMI\n(Biomonitoring)'))
