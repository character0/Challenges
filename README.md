# Challenges
## Imply.io
The goal is to combine the files, eliminating any duplicates and write to a single .CSV file sorted alphabetically by the city name. 
The desired solution should be as generic, repeatable, and as automated as possible.

## RunBook
As this is a Gradle project, this can be executed to build and run directly with the GradleWrapper with no other requirements
other than connectivity to the internet. For manual execution, in the project directory run gradle.

A Windows and Unix script are provided to further simply execution of the application. In /app, the respective DataSourceCompaction scripts
will execute the gradle commands below. To process a different set of datasources, update the script's arguments to the desired
directory path.

The application optionally takes in a argument expecting a directory path for file processing. Without an arguement, the applicaiton 
will demo and process the provided data files from Imply, kept in the /conf folder of the app.
```base
.\gradlew run [--args='./']
```

If the application is not able to determine the provided argument as a valid File path, the application will exit.

A Gradle build will produce a .jar file that can also be executed with Java.
```bash
.\gradlew build 
```

Produces: _./build/libs/app.jar_. The application can then be executed by java with:

```bash
java -cp app.jar imply.DataSourceCompaction 
```

or since a Manifest file is also provided:

```bash
java -jar app.jar
```


**What is the count of all rows?**

_2583 Total Rows. 2078 Total Unique Rows._
            
For the total number of rows processed, a simple counter was kept to keep track of the number of rows processed per data source. 
The totals for each data source were then tallied for the total number or rows processed. 

For the number of unique rows, a HashMap was utilized to use hash collisions to detect duplicaes. Once compleated, 
the .size() of my cleansed list of data entries provides the unique count.

**What is the city with the largest population?**

_The city with the largest population is: Mumbai (Bombay), IND with a population of 10500000._

```groovy
def lisOfPopulations = mergedDataSource.collect { it.value.get("population") as Long }
def largestPopulation = lisOfPopulations.max()
def largestCity = mergedDataSource.find { key, value -> value.getAt("population") as Long == largestPopulation }
 ```

From my cleansed dataset, sorting by population values and taking the first (or last entry depending on sort order) will
yield the highest value. I am then able to find the row entry from my cleansed data set using the population value as the key.

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


Your deliverable should be the following:
- Your code to generate the dataset
- A runbook with a guide on using your program
- The dataset generated
- Answers to the previous questions
