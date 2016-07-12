# Converts UK scale into US with warning signals & vice versa
lipid.panel<-function(Date,TotalCholesterol,Triglyceride,HDL,scale,gender){
     
      # Conversion Constants
      lipid.constant<-38.66976      
      triglyceride.constant<-88.4956
      
      if(scale =="UK"){
            # For UK -> US conversion (multiply by constants)
            cholesterol<-TotalCholesterol*lipid.constant
            triglyceride<-Triglyceride*triglyceride.constant
            hdl<-HDL*lipid.constant
            us.ldl<- cholesterol-hdl-(triglyceride/5)## Calculate US ldl
            uk.ldl<- TotalCholesterol-HDL-(Triglyceride/5)# Calculate UK ldl
            
            # Make US & UK variables; UKvar = User input + UK ldl calc
            US<-as.numeric(c(cholesterol,hdl,us.ldl,triglyceride))
            UK<-as.numeric(c(TotalCholesterol,HDL,uk.ldl,Triglyceride))  
            
            # Add Lipid panel ranges - run flag functions 1 through 4; data = conversions
            tot.range<-cholesterol.flag(cholesterol)
            tri.range<-triglyceride.flag(triglyceride)
            hdl.range<-hdl.flag(hdl,gender)
            ldl.range<-ldl.flag(us.ldl)
            Range<-c(tot.range,hdl.range,ldl.range,tri.range)
      } else if(scale =="US"){
            # For US -> UK conversion (divide by constants)
            cholesterol<-TotalCholesterol/lipid.constant
            triglyceride<-Triglyceride/triglyceride.constant
            hdl<-HDL/lipid.constant
            uk.ldl<-cholesterol-hdl-(triglyceride/5)# Calculate UK LDL
            us.ldl<-TotalCholesterol-HDL-(Triglyceride/5) # Calculate US LDL 
            
            # Make US & UK variables; USvar = user input + US ldl calc
            UK<-as.numeric(c(cholesterol,hdl,uk.ldl,triglyceride))
            US<-as.numeric(c(TotalCholesterol,HDL,us.ldl,Triglyceride))
            
            # Add Lipid panel ranges - run flag functions 1 through 4; data = user input
            tot.range<-cholesterol.flag(TotalCholesterol)
            tri.range<-triglyceride.flag(Triglyceride)
            hdl.range<-hdl.flag(HDL,gender)
            ldl.range<-ldl.flag(us.ldl)
            Range<-c(tot.range,hdl.range,ldl.range,tri.range)
      }    
      # Create & Return output data table
      Measurements<-as.character(c("TotalCholesterol","HDL","LDL","Triglyceride"))
      df<-data.frame(Date,Measurements,UK,US,Range,row.names = NULL)
      df
}
# 1. Total Cholesterol Flag
cholesterol.flag<-function(x){
      # Total Cholesterol Ranges - 3 conditions
      if(x < 200){
            range<-"Desirable"
      } else if(x >= 200 && x <=239){
            range<-"Borderline High"
      } else if (x >= 240){
            range<-"High"
      }
}
# 2. Triglyceride Flag
triglyceride.flag<-function(x){
      # Triglyceride Level Flags: 4 conditions
      if (x < 150){
            range<-"Desirable"
      } else if(x >=150 && x <=199){
            range<-"Borderline High"
      } else if(x >=200 && x<=499){
            range<-"High"
      } else if(x >= 500){
            range<-"Very High"
      }
}
# 3. HDL Flag
hdl.flag<-function(x,gender){
      # HDL Levels Flag: 5 conditions
      if (x < 40 && gender =="Male"){
            range<-"Poor"
      } else if (x < 50 && gender =="Female"){
            range<-"Poor"
      } else if (x >= 40 && x <=59 && gender == "Male"){
            range<-"Better"
      } else if (x >=50 && x <=59 && gender =="Female"){
            range<-"Better"
      } else if (x >= 60){
            range<-"Best"
      }
}
# 4. LDL Flag
ldl.flag<-function(x){
      # LDL Level Flag: 6 conditions
      if (x <= 69){
            range<-"Ideal very high risk of CvD"
      } else if (x >=70 && x <= 99){
            range<-"Ideal for high risk CvD"
      } else if (x >= 100 && x <= 129){
            range<-"Ideal range"
      } else if (x >= 130 && x <=159){
            range<-"Boderline High"
      } else if (x >= 160 && x <=189){
            range<-"High"
      } else if (x >=190){
            range<-"Very High"
      }
} 
# Plotting Lipid panels by lab date
lipid.plot<-function(data){
      # Load Packages
      require(ggplot2)
      require(RColorBrewer)
      # Create Date Range for Plot Title
      earliest.date<-data$Date[1]
      max.date<-length(data$Date)
      recent.date<-paste(data$Date[max.date])
      test.range<-paste("Lipid Panel Results from",earliest.date,"to",recent.date)
      # Create Mean lines for each measurement
      complines<-data.frame("Yint"=c(200,40,130,150),
                            "color"=c("darkgoldenrod1","brown2","chartreuse4","cornflowerblue"))
      # Create Scatter Plot
      plot<-ggplot(data=data,aes(x=Date,y=US,group=Measurements,colour=Measurements))+
            geom_point(size = 4)+ geom_line(aes(group=Measurements, colour= Measurements))+
            scale_colour_manual(values=c("HDL"="brown2", ## redish brown, more red
                                         "LDL"="chartreuse4", ## bright green
                                         "TotalCholesterol"="darkgoldenrod1", ## Yellowish 
                                         "Triglyceride"="cornflowerblue"))+ ## 
            geom_hline(xintercept=0,yintercept=complines$Yint,
                       colour=complines$color,linetype="twodash",size=0.75)+
            # Add Titles
            xlab("Results by Test Date")+ ylab("Panel Unit: mg/dL")+  ggtitle(test.range)+
            # Format ggtitle
            theme(plot.title=element_text(size=20,vjust=1.5))+
            # Remove plot background
            theme(panel.background = element_blank())+
            # Customize the colour of the plot borders colour
            theme(panel.background = element_rect(colour="grey"))+
            # Remove X & Y axis grid lines
            theme(panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank())+
            theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())+
            # Remove legend
            theme(legend.position=c("bottom"))+
            # Format X & Y Axis Text
            theme(axis.text.x = element_text(colour="black",size=12))+
            theme(axis.text.y = element_text(colour="black",size=12))
}     

labsummaries<-read.csv("parameters.csv")
x<-lipid.plot(labsummaries)
x