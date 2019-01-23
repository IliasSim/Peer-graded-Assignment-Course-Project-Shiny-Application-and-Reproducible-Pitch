library(shiny)
shinyUI(fluidPage(
    
    # Application title
    headerPanel("Visualizing Central Limit Theorem "),
        h5('The CLT states that even when a population do not follow a normal distribution 
        the means from repeated samples from this population follow a general normal distribution 
        with mean equal to the mean of the distribution the population has and std. deviation 
        equal with the std. deviation of the population distribution divited by the 
        square root of the sample size. In this applicaton we will visualize the validity of the
        CLT for the Exponential and the Uniform distribution'),
        # Chose the distribution to be checked selection selection.
    sidebarPanel(
        radioButtons("in1", "Distribution to be checked",
                    c(Exponential = "Exponential", Uniform = "Uniform")
        ),
    # Only show this panel if the dystribution type is exponential
        conditionalPanel(
    # A brief description of the exponential distribution
            h4('Definition of the Exponential distribution'),
            h5('Exponential is the probability distribution that describes the time between 
            events in a Poissonpoint process, i.e., a process in which events   
            occur continuously and independently at a constant average rate
            The mean and the std.deviation of the distribution is 1/lambda. Lamda is a
            constant rate, in event occurance per unit of measurement, (eg. )failures 
            per hour,per cycle,etc.'),
            condition = "input.in1 == 'Exponential'",
    # Numeric input for the rate of the exponential distribution.
            numericInput(
                "in2", "Choose the Lamda/rate of the exponential distribution 
                each sample will follow",min = 0, value = .1),
    # Numeric input for the number of random variables for each sample of the distribution
            numericInput(
                "in3", "Choose the number of random variables for each sample of the distribution",
                min = 10,max = 1000, value = 40,step = 1),
    # Numeric input of the Number of samples to be gathered
            numericInput(
                "in4", "Choose the number of samples to be gathered",min = 100,max = 10000, 
                value = 100,step = 10),
    # Showing the theoretical mean and sd of the exponential based on the chosed lambda
            h5('Theoretical mean and sd of the exponential based on the choosed lambda '),
            h6('mean'),textOutput("text1"),h6('sd'),textOutput("text2")),
            conditionalPanel(
            condition = "input.in1 == 'Uniform'",
    # A brief description of the exponential distribution
            h4('Definition of the uniform distribution'),
            h5('Uniform is a type of probability distribution in which all outcomes
            are equally likely; each variable has the same probability that it will be
            the outcome. The mean is equal with the sum of the minimum and maximum 
            values of the distribution divided by two and the std.deviation is equal 
            with the maximum minus the minimum value of the distribution divited by the 
            square root of twelve'),
    # Slider input for the Number of Random Variables for each sample of the distribution
            sliderInput(
            "in5", "Choose the number of random variables for the distribution",min =0,max=10000,
            value = 40),
            sliderInput(
            "in6", "Choose the lower limit of the distirbution",min = -1000,max=1000, value = 0),
            sliderInput(
            "in7", "Choose the upper limit of the distirbution",min = -1000,max = 1000, 
            value = 40,step = 1),
    # Slider input of the Number of samples to be gathered
            sliderInput(
            "in8", "Choose the number of simulated Uniforms ",min = 100,max = 10000, 
            value = 100,step = 10),
            h5('Theoreticalmean and sd of the uiform based on the choosed min and max varables valiues'),
            h6('mean'),textOutput("text3"),h6('sd'),textOutput("text4"))),
    mainPanel(
            plotOutput("plot1"),
            conditionalPanel(
                condition = "input.in1 == 'Exponential'",
                textOutput("text5"),
                strong("HINT The more variables we choose from the sidebar the closest 
            resemblances we have between theoritical density curve and actual exponential distribution")),
            conditionalPanel(
                condition = "input.in1 == 'Uniform'",
                textOutput("text6"),
                strong("HINT: The more variables we choose from
            the sidebar the closest resemblances we have between theoritical density curve and actual uniform distribution")),
            plotOutput("plot2"),
            conditionalPanel(
            condition = "input.in1 == 'Exponential'",
            textOutput("text7"),
                strong("HINT:The histogram will match the density curve of the general normal distribution as 
            the number of samples getting bigger  ")),
            conditionalPanel(
                condition = "input.in1 == 'Uniform'",
                textOutput("text8"),
                strong("HINT:The histogram will match the density curve of the general normal distribution as 
            the number of samples getting bigger  "))
                )
            
    
    ))
                
    
                 
