# Glossary Page

tabItem(tabName = "glossary",
        fluidPage(
          mainPanel(
            
        # Page title ----
            h1("Glossary"),
            
            hr(),       # page break
            
        # Glossary content ----
            h3("Admission"),

              p("An admission marks the start of an inpatient or day case episode."),
            
            hr(),       
            
            
            h3("Advance statements"),
            
              p(paste0("Advance statements are written statements made by a person when 
              they are well, setting out the care and treatment they would prefer 
              or would dislike should they become mentally unwell in the future. 
              The advance statement register has been in operation since 2017. 
              Each time someone either writes a statement or withdraws 
              a statement, health boards should notify the Mental Welfare Commission 
              for Scotland about this. More information about advance statements 
              can be found in pages 61 - 63 of the "), 
              a(href = "https://www.mwcscot.org.uk/sites/default/files/2024-10/MHA-MonitoringReport2023-24.pdf",
                "Mental Welfare Commission for Scotland Mental Health Act monitoring 
                report 2023-24.",
                target = "_blank")), # forces link to open in a new tab
              # previously: "pages 56 - 57 of the report in 2022-23."
            
            hr(), 
            
            
            h3("Bed day"),
            
              p("A bed day is a unit used for quantifying the availability and use 
              of beds over time, i.e. bed counts are expressed as a number of bed 
              days."),
            
            hr(), 
            
            
            h3("Community mental health services"),
            
              p(paste0("The Scottish Government's "), 
                a(href = "https://www.gov.scot/publications/core-mental-health-standards/pages/12/", 
                  "'Core mental health standards' publication", 
                  target = "_blank"), 
                HTML(paste(" states: ",
                       em("'Community Services: This is care and support which can 
                          be accessed without the need to be admitted to an 
                          inpatient hospital ward.'"), 
                       sep = "<br/>"))), 
            
            hr(),

            
            h3("Continuous Inpatient Stay (CIS)"),
            
              p("A Continuous Inpatient Stay (CIS) is an unbroken period of time 
              that a patient spends as an inpatient. A patient may change 
              consultant, significant facility, specialty and hospital during a 
              Continuous Inpatient Stay."),
            
            hr(), 
            
            
            h3("Discharge"),
            
              p("A hospital discharge marks the end of an episode of care. This 
              may include deaths, transfers to other specialties/facilities/hospitals, 
              and discharges to place of residence."),
            
            hr(), 
            
            
            h3("Emergency detention certificate (EDC)"),
            
              p("An emergency detention certificate (EDC) is issued where it is 
              necessary as a matter of urgency to detain a patient in hospital 
              for the purpose of permitting a full assessment of their mental state, 
              or where if the patient were not detained in hospital there would 
              be a significant risk to either themselves or others. An EDC can be 
              issued by any doctor, with the input of a mental health officer (MHO), 
              which allows someone to be kept in hospital for up to 72 hours. 
              For further information on compulsory treatment under the Mental 
              Health act, see from page 11 of the ",
                a(href = "https://www.mwcscot.org.uk/sites/default/files/2025-03/MHA-MonitoringReport-2023-24.pdf", 
                target = "_blank", 
                "Mental Welfare Commission for Scotland Mental Health Act monitoring 
                report 2023-24")),
        
            hr(), 
            
            
            h3("Emergency readmissions"),
            
              p("Admissions are defined as completed Continuous Inpatient Stays 
              (CIS - see above for more information). These can be Elective or 
              Emergency admissions. Emergency readmissions are those generated 
              by patients who have a subsequent Emergency admission within 28 days 
              from the discharge date of a previous CIS. The discharge type of 
              the previous CIS is used to identify those that have been transferred 
              internally or externally to another NHS provider. Subsequent stays 
              within 28 days of the discharge date of a previous CIS will not be 
              flagged as emergency readmissions where the discharge type of the 
              previous CIS is 12 (Transfer within the same Health Board/ Health 
              Care Provider) or 13 (Transfer to another Health Board/ Health Care 
              Provider). Each patient may be counted more than once i.e. as many 
              times as the individual is readmitted. The Date of Admission is from 
              the first episode of the original CIS and the Specialty is taken from 
              the last episode of the original CIS."),
            
            hr(), 
            
            
            h3("Episode"),
            
              p("An episode starts with a referral (including re-referral) or 
              admission. It ends with a discharge."),
            
            hr(), 
            
            
            h3("European age-sex standardised rates (EASRs)"),
            
            p("In order to compare rates in populations with different age 
              structures (i.e. different areas or over time), rates can be 
              age-standardised by applying a 'standard population'. The 
              standardised rate is calculated by multiplying each crude 
              age-specific rate by the corresponding age group weight from the 
              standard population and then summing these values over all ages."), 
            p(paste0("Age-standardised mortality rates for deaths by probable suicide 
              are presented per 100,000 people and standardised to the 2013 European 
              Standard Population. Age-standardised mortality rates allow for 
              differences in the age structure of populations and therefore allow 
              valid comparisons to be made between geographical areas, the sexes 
              and over time. For additional information see the "),
              a(href = "https://www.nrscotland.gov.uk/publications/probable-suicides-2024/",
                "NRS probable suicide publication webpage.",
                target = "_blank")),
            
            hr(),
            
            
            h3("Financial year"),
            
              p("Financial years start on 1 April and end on 31 March. For 
              example, financial year 2024/2025 covers the period 1 April 2024 – 
              31 March 2025."),
            
            hr(),
            
            
            h3("Hospital"),
            
              p("A hospital is an institution which is managed, staffed and 
              equipped for the provision of health care services. Hospitals 
              comprise facilities for the diagnosis and treatment of disease."),
            
            hr(),
            
            
            h3("Hospital resident"),
            
              p("A hospital resident is an individual who is an inpatient at 
              midnight on 31 March, before the beginning of the next financial 
              year (1 April). The term 'hospital resident' is used for simplicity. 
              This is because some people will be looked after in care homes 
              under contract to the local NHS Board."),
            
            hr(),
            
            
            h3("NHS Board of residence"),
            
              p("Describes which of the 14 Scottish territorial NHS Boards the 
              patient lives in. This is based on the postcode of their home address. 
              This report uses the 2019 NHS Board boundaries throughout, for all 
              years of data."),
            
            hr(),
            
            
            h3("NRAC - National Resource Allocation Committee"),
            
              p("The National Resource Allocation Committee (NRAC) is the 
              body that developed the Scottish Resource Allocation Formula. The 
              formula is used to predict and advise how the allocation of around 
              70% of the total NHS Budget between the 14 territorial NHS Boards 
              in Scotland is distributed in each financial year. This provides 
              funding to NHS Boards for the provision of Hospital and Community 
              Health Services (HCHS) and GP Prescribing."), 
              p("More information can be found in the ", 
              a(href = "https://www.publichealthscotland.scot/publications/show-all-releases?id=20539", 
                target = "_blank", 
                "Resource Allocation Formula (NRAC) publications.")),
        
            hr(),
            
            
            h3("Patient"),
            
              p("A patient is an individual discharged from hospital at least once 
              during the financial year."),
            
            hr(),
            
            
            h3("Rate (per 100,000 population)"),
            
              p("The annual number of events relative to the size of the 
              population, expressed per 100,000 population. It takes no account 
              of differences between populations with regards to age and gender 
              composition."),
            
            hr(),
            
            
            h3("Readmission"),
            
              p("A readmission occurs when a patient is admitted as an inpatient 
              to any specialty in any hospital within a specified time period 
              following discharge from a Continuous Inpatient Stay."),
            
            hr(),
            
            
            h3("Referral"),
            
              p("A referral is a request to a healthcare professional or to an 
              organisation to provide appropriate healthcare to a patient. A 
              referral may be made by a person or an organisation on behalf of a 
              patient, or a patient may refer him/herself."),
            
            hr(),
            
            
            h3("SMR04 - Scottish Morbidity Record 04"),
            
              p("An episode-based patient record relating to all inpatients and 
              day cases in a mental health specialty admitted to and discharged 
              from a psychiatric hospital or unit, or a facility treating people 
              with learning disabilities, in NHS Scotland. In addition, if the 
              NHS contracts out psychiatric or learning disability care to a 
              private care home or hospital, an SMR04 record should be generated 
              for each inpatient or day case episode. As inpatient stays in mental 
              health specialties can often be quite lengthy - perhaps several 
              years - the SMR04 record was developed with two elements: one 
              completed and submitted on admission; and one completed and submitted 
              on discharge. This was to ensure that it was not necessary to wait 
              until discharge for information on the admission to become available 
              (but if the stay is short, the admission and discharge information 
              can be submitted together)."),
              p("The SMR04 record allows patients to be allocated to the following 
              specialties: General Psychiatry; Child and Adolescent Psychiatry; 
              Forensic Psychiatry; Psychiatry of Old Age; Learning Disability; 
              and Psychotherapy."),
              p(paste0("More information, including information on completeness, 
                       can be found in Public Health Scotland's National Data 
                       Catalogue "), 
                a(href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/national-data-catalogue/national-datasets/search-the-datasets/mental-health-inpatient-and-day-case-scottish-morbidity-record-smr04/", 
                  "'Dataset summary for SMR04'",
                  target = "_blank"), 
                paste0(" and in the "), 
                a(href = "https://publichealthscotland.scot/resources-and-tools/health-intelligence-and-data-management/national-data-catalogue/smr-data-manual/definitions-by-smr-record-section/smr04-mental-health-inpatient-and-day-case/general-definitions/", 
                  "'SMR04 definitions'.",
                  target = "_blank")),
            
            hr(),
            
            
            h3("Specialty"),
            
              p("A specialty is defined as a division of medicine covering a 
              specific area of clinical activity and identified within one of 
              the Royal Colleges or Faculties."),
            
            hr(),
            
            
       # Navigation button ----    
            fluidRow(
              column(4, actionButton(inputId = "data_scot_hub_button", 
                                     label = "Scotland Hub", icon = icon("home"),
                                     class = "navpageButton"))
            ) 
            

            
) # end of mainPanel
) # end of fluidPage
) # end of tabItem

