# MHQI-Dashboard
Repo for the Mental Health Quality Indicators Dashboard. Maintained by the Public Health Scotland (PHS) Mental Health Analytics team: phs.mentalhealthanalytics@phs.scot

**Most recent publication:**
https://publichealthscotland.scot/publications/mental-health-quality-indicator-profile/mental-health-quality-indicator-profile-29-july-2025/

**Direct dashboard link:**
https://scotland.shinyapps.io/phs-mental-health-quality-indicators-July-2025/

## Maintaining
This dashboard makes use of a file 'stylesheet.css' (which can be found in the www folder - where it must remain in order to work) to define styling of various elements. This styling overrides the default styling set by the Shiny package and enables styling to be changed once in one place and affect every incidence of that element. As a result, editing aesthetics and certain behaviours of this dashboard should be a much simpler process.

To edit an element you need to know what 'class(es)' refers to the element. If you need to find out the class(es) of a particular element you can run the app within RStudio and right click on the element you are interested in. Then click "inspect" and it will bring up the developer window with the relevant bits of code.

