# Imply.io Coding Exercise
There are three source files. _CityListA.json_, _CityListB.avro_, and _CityListC.csv_. They each contain data in three columns:

- name:string
- code:string
- Population:long

The goal is to combine the files, eliminating any duplicates and write to a single .CSV file sorted alphabetically by the 
city name. You can use any technology that you prefer. The desired solution should be as generic, repeatable, and as 
automated as possible. Once the dataset is completed, answer the following questions (and provide an explanation of how 
you determined your answer with any applicable code):

- What is the count of all rows?
- What is the city with the largest population?
- What is the total population of all cities in Brazil (CountryCode == BRA)?
- What changes could be made to improve your program's performance.
- How would you scale your solution to a much larger dataset (too large for a single machine to store)?

# RunBook
##About
As this is a Gradle project, this can be executed to build or execute directly in the project with the provided GradleWrapper 
with no other requirements other than connectivity to the internet. The **Standalone Execution** section outlines this process.

The application optionally takes in an argument expecting a directory path for processing datasource files. Without a directory
argument, the application will process the sample data files from Imply, kept in the ./conf folder of the app. If the 
application is not able to determine the provided argument as a valid File path, the application will exit.

To further simplify execution, a Windows and Unix script are also provided to execute the application via standalone mode. 
In the ./app folder, the respective DataSourceCompaction scripts will execute the gradle commands below.

The application will output logging into the console only. There is no external logging kept for the application.

Files that have been processed will remain and generated .csv files will be timestamped, creating a new file on each execution.

## Standalone Execution
To execute the application to process the sample files in the ./conf folder, run this command in the base folder of the project
where the gradlew scripts live.
```base
.\gradlew run
```

To execute the application to process datasource files in another directory pass the --args= flag and provide a valid 
fully qualified directory path. A Unix example is shown below.
```base
.\gradlew run --args='/path/to/datasources'
```


## Java Execution
A Gradle build will produce a .jar file that can also be executed with Java.
```bash
.\gradlew build 
```

Produces: _./build/libs/app.jar_. The application can then be executed by java with:

```bash
java -cp app.jar imply.DataSourceCompaction 
```

or since a Manifest file is provided:

```bash
java -jar app.jar
```

# Deliverables
- The Runbook section of this README serves as the runbook for the application.
- The _CompactedCityList.csv_ file included with this project is a sample dataset generated from the sample CityList files in ./conf.

**What is the count of all rows?**

_2583 Total Rows. 2078 Total Unique Rows._
            
For the total number of rows processed, a simple counter was kept to keep track of the number of rows processed per data source. 
The totals for each data source were then tallied for the total number or rows processed. 

For the number of unique rows, a HashMap was utilized to use hash collisions to detect duplicates. Once completed, 
the .size() of my cleansed list of data entries provides the unique count of rows.

**What is the city with the largest population?**

_The city with the largest population is: Mumbai (Bombay), IND with a population of 10500000._

```groovy
def lisOfPopulations = mergedDataSource.collect { it.value.get("population") as Long }
def largestPopulation = lisOfPopulations.max()
def largestCity = mergedDataSource.find { key, value -> value.getAt("population") as Long == largestPopulation }
 ```

From my cleansed dataset, I collect the population values and place them into a simple List where I am then able to find the max value
using the lib. function. I am then able to find the row entry from my cleansed data set using the population value as the key.

**What is the total population of all cities in Brazil (CountryCode == BRA)?**

_The total population for Brazil amongst the dataset is: 55955012._

From my cleansed dataset, I keep a counter that adds the population value of any row entry where the country value is BRA
ignoring case.

```groovy
def braTotalPopulation = 0;
mergedDataSource.each {
    if (it.value.get("country").toString().equalsIgnoreCase("BRA")) {
        braTotalPopulation += Long.parseLong(it.value.get("population").toString())
    } else {
        return
    }
}
```

**What changes could be made to improve your program's performance?**
- Eliminating full data scans where possible:
    - Eliminating duplicates with hash collisions to find duplicates for scanning is one optimization implemented.
    - Keeping sort order while building list.
    - Keeping track of population statistics while processing files to find the highest populated city
    and total population for each city.
- Async calls for file processing.
- Processing of different file types simultaneously.

**How would you scale your solution to a much larger dataset (too large for a single machine to store)?**
- Migrate the program to a Spark job and leverage Apache Spark. The code can easily be modified to a Java Spark job
for disributed computing of much larger datasets.