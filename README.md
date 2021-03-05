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
##About The Solution
The solution is a Gradle application written in Groovy. This application can be executed directly in the project with 
the provided GradleWrapper with no other requirements other than connectivity to the internet. Gradle is not only the 
build tool for the application, but also allows the application to be executed in isolation with the bundled _gradelw_ library. 
The **Standalone Execution** section outlines this process. Groovy was used as the programming language over pure Java 
because of my relevant experience and because of its wonderful I/O libs.

The application optionally takes in an argument which expects a valid directory path for processing datasource files. 
Without a directory argument, the application will process the sample data files from Imply, kept in the ./conf folder 
of the project. If the application is not able to determine the provided argument as a valid file path, the application will exit.

The application will output logging into the console only. There is no external logging kept for the application.

Files that have been processed will remain in their source directory and any generated .csv files from the application 
will be timestamped and named as CityList.$timestamp.csv. 


## Standalone Execution
To execute the application to process the sample files in the ./conf folder, run this command in the project's root folder
where the gradlew scripts live.

To further simplify execution, Windows and Unix scripts (_DataSourceCompaction.cmd_ & _DataSourceCompaction.sh_, respectively) 
are provided to execute the application via standalone mode. In the project's root folder, the respective DataSourceCompaction 
scripts will execute the gradle commands outlined below.

To execute the application to process datasource files in another directory pass the '--args=' flag and provide a valid 
fully qualified directory path.

On Unix (Bash)
```base
sh gradlew run
```

With the directory argument:
```base
sh gradlew run --args='/path/to/datasources'
```


On Windows (Command Prompt)
```base
gradlew.bat run
```

On Windows (PowerShell)
```base
.\gradlew run
```

With the directory argument:
```base
.\gradlew run --args='C:\path\to\datasources'
```



## Java Execution [TBD]
~~A Gradle build will produce a .jar file that can also be executed with Java.~~
```bash
.\gradlew build 
```

~~Produces: _./build/libs/app.jar_. The application can then be executed by java with:~~

```bash
java -cp app.jar imply.DataSourceCompaction 
```

~~or since a Manifest file is provided:~~

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

See the method _imply.DataSourceCompaction.processDataFromSource()_ for the implementation of how both totals were generated.

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
        braTotalPopulation += it.value.get("population")
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
- Using async calls for processing multiple files of the same type simultaneously.
- Using async calls for processing of different file types simultaneously.

**How would you scale your solution to a much larger dataset (too large for a single machine to store)?**

In order to scale to a larger dataset, I would migrate the program to a Spark job and leverage Apache Spark. The code 
can easily be modified to a Java Spark job for exactly this purpose, distributed computing of much larger datasets.