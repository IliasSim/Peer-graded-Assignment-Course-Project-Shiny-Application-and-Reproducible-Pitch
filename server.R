library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output){
    # Creating one exponential as an example
        one_exp<-reactive(rexp(input$in3,rate=input$in2))
    # Defining the exponential mean and sd
        expmean<-reactive(1/input$in2)
        expsd<-reactive(1/input$in2)
    # Creating the samples of exponential
        simulation_e<-reactive({rexp(input$in3*input$in4,rate=input$in2)})
        simmatrix_e<-reactive(matrix(simulation_e(),ncol = input$in4,nrow = input$in3))
    # Calculating the mean of each exponential sample 
        esamplemean<-reactive(apply(simmatrix_e(),2,mean))
    # Creating one uniform as an example
        one_uni<-reactive(runif(n=input$in5,min=input$in6,max=input$in7))
    # Defining the uniform mean and sd
        unimean<-reactive((input$in6+input$in7)/2)
        unisd<-reactive({((input$in7-input$in6)/sqrt(12))})
    # Creating the samples of uniform    
        simulation_u<-reactive(runif(input$in5*input$in8,min=input$in6,max=input$in7))
        simmatrix_u<-reactive(matrix(simulation_u(),ncol = input$in8,nrow = input$in5))
    # Calculating the mean of each uniform sample 
        usamplemean<-reactive(apply(simmatrix_u(),2,mean))
    #Creating a density plot of one exponential or uniform distribution as an example 
        plot1<-reactive({if(input$in1=="Exponential"){(hist(one_exp(),density=40,
        breaks = 40,freq = FALSE,main = "",
        xlab = "Random Variables",ylab = "Density"))
    # Adding a curve depicting the the theoretical exponential or uniform distribution density
        curve(dexp(x,input$in2),add = TRUE,lwd=5,from = 0)}else{hist(one_uni(),density=40,
                                breaks = 40,freq = FALSE,main = "",
                                xlab = "Random Variables",ylab = "Density")
        curve(dunif(x,min=input$in6,max=input$in7),log=FALSE,add = TRUE,lwd=5,from = input$in6-10,
              to=input$in7+10)}})
    #Creating a density plot of the density from the sample means for the exponential or uniform distribution  
        plot2<-reactive({if(input$in1=="Exponential"){(hist(esamplemean(),density=40,
                                    breaks = 40,freq = FALSE,main = "",
                                    xlab = "Random Variables",ylab = "Density"))
    # Adding a curve depicting the the theoretical general normal distribution expected from the application of the clt
        curve(dnorm(x,mean = expmean(),sd=(1/input$in2)/sqrt(input$in3)),add=TRUE,lwd=5)}else{
        hist(usamplemean(),density=40,
                 breaks = 40,freq = FALSE,main = "",
                 xlab = "Randow Variables",ylab = "Density")
    curve(dnorm(x,mean = unimean(),sd=unisd()/sqrt(input$in5)),add=TRUE,lwd=5)
        }})
    # Define the outputs of the application
        output$text1<-renderText(expmean())
        output$text2<-renderText(expsd())
        output$text3<-renderText(unimean())
        output$text4<-renderText(unisd())
        output$text5<-renderText({paste("In the first plot we have a histogram of an exponential distribution 
             having  as ratio",input$in2,"and",input$in3,"randow variables. The curve depict the theoritical 
            density of the same exponential. ")})
        output$text6<-renderText({paste("In the first plot we have an histogram of an uniform distribution 
            having  minimum variable equal",input$in6," and upper variable equal",input$in7,"with",input$in5, " random 
            variables. The curve depict the theoritical density of the same uniform.")})
        output$text7<-renderText({paste("In the second plot we have a histogram of the means from the",input$in4, "
            samples of exponentionals having same characteristics with plot 1 distribution. The curve depict the 
            density of a general normal distribution with mean equal with the theoritical mean of the exponential 
            of the plot 1 and sd equal the theoritical sd divited by the square root of the sample which is",
            sqrt(input$in3))})
        output$text8<-renderText({paste("In the second plot we have a histogram of the means from the",input$in8, "
            samples of uniforms having same characteristics with plot 1 distribution. The curve depict the 
            density of a general normal distribution with mean equal with the theoritical mean of the uniform 
            of the plot 1 and sd equal the theoritical sd divited by the square root of the sample population  which is",
            sqrt(input$in5))})
        output$plot1<-renderPlot(plot1())
        output$plot2<-renderPlot(plot2())
    })
    
    

    

