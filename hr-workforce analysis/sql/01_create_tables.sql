-- Create HR employees table
CREATE TABLE hr_employees (
    Employee_Name VARCHAR(100),
    EmpID VARCHAR(20),
    MarriedID INT,
    MaritalStatusID INT,
    GenderID INT,
    EmpStatusID INT,
    DeptID INT,
    PerfScoreID INT,
    FromDiversityJobFairID INT,
    PayRate NUMERIC(10,2),
    Termd INT,
    PositionID INT,
    Position VARCHAR(100),
    State VARCHAR(10),
    Zip VARCHAR(10),
    DOB VARCHAR(20),
    Sex VARCHAR(5),
    MaritalDesc VARCHAR(50),
    CitizenDesc VARCHAR(50),
    HispanicLatino VARCHAR(5),
    RaceDesc VARCHAR(100),
    DateofHire VARCHAR(20),
    DateofTermination VARCHAR(20),
    TermReason VARCHAR(100),
    EmploymentStatus VARCHAR(50),
    Department VARCHAR(100),
    ManagerName VARCHAR(100),
    ManagerID INT,
    RecruitmentSource VARCHAR(100),
    PerformanceScore VARCHAR(50),
    EngagementSurvey NUMERIC(3,2),
    EmpSatisfaction INT,
    SpecialProjectsCount INT,
    LastPerformanceReview_Date VARCHAR(20),
    DaysLateLast30 INT
);

-- Create salary grid table
CREATE TABLE salary_grid (
    Position VARCHAR(100),
    Min_Hourly NUMERIC(10,2),
    Mid_Hourly NUMERIC(10,2),
    Max_Hourly NUMERIC(10,2),
    Min_Annual INT,
    Mid_Annual INT,
    Max_Annual INT
);