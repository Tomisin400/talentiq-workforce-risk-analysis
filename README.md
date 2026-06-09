
# 🧠 Beyond Attrition: A People Analytics Investigation into Workforce Risk, Compensation & Retention

---

> *"One in every three employees has already left TalentIQ. The real question isn't why they left , it's whether the company is paying attention to the warning signs from the employees who stayed."*

---

## 📌 Table of Contents
- [Executive Summary](#-executive-summary)
- [The Real Problem](#-the-real-problem)
- [Dataset Overview](#-dataset-overview)
- [Tools & Methodology](#tools--methodology)
- [Dashboard 1 — Attrition & Retention](#-dashboard-1--attrition--retention)
- [Dashboard 2 — Compensation & Pay Equity](#-dashboard-2--compensation--pay-equity)
- [Dashboard 3 — Burnout & Engagement](#-dashboard-3--burnout--engagement)
- [Hidden Insights](#hidden-insights)
- [Team Retention Analysis](#-team-retention-analysis)
- [Recruitment Source Effectiveness](#-recruitment-source-effectiveness)
- [What Leadership Should Be Watching Next](#what-leadership-should-be-watching-next)
- [Strategic Recommendations](#-strategic-recommendations)
- [Conclusion](#-conclusion)
- [Connect With Me](#-connect-with-me)



## 📋 Executive Summary

Organizations often treat employee turnover as the problem.
This analysis suggests turnover is only the symptom.

After analyzing attrition, compensation, engagement, attendance, workload, performance and recruitment data across 310 employees, a more complex picture emerged.

The organization is not experiencing a single workforce challenge. Different departments are exhibiting different warning signs:

- Production is facing a retention crisis
- Software Engineering is showing signs of disengagement
- IT/IS is carrying the highest workload burden
- Sales records the highest lateness levels
- Admin Offices shows the largest compensation disparity

Viewed independently, these findings appear unrelated.
Viewed together, they reveal an organization facing multiple workforce risks simultaneously.

Key Findings:
- 33.23% of employees have left — Production accounts for the majority of exits
- Software Engineering recorded the lowest engagement score (2.63) despite not having the highest attrition
- IT/IS employees manage an average of 5.92 special projects creating potential burnout risk
- Admin Offices displays the largest gender pay gap
- Employee referrals generated the strongest long-term hires
- Top performers earn only $0.78/hour more than average performers

The most important finding: Workforce risk is distributed across the organization rather than concentrated in a single department. A single company-wide solution is unlikely to address the underlying causes.



## ❗ The Real Problem

Most HR reports answer: *"How many employees left?"*

This analysis was built to answer: *"What workforce risks are emerging before employees decide to leave?"*

TalentIQ Analytics employed 310 people during the period analyzed.
103 employees exited — an attrition rate of 33.23%.

The deeper investigation revealed findings traditional HR reporting would likely miss:

- Production accounted for the majority of exits, particularly during the 2018 turnover spike
- More than half of all departures were linked to potentially preventable factors
- Two managers experienced turnover rates exceeding 60%
- The highest-performing employees earned only marginally more than average performers
- Employees hired through referrals consistently remained longer than those hired through several external channels
- The department with the lowest engagement was not the department with the highest attrition

The data did not reveal a single organizational weakness.
It revealed a collection of disconnected warning signs that, when viewed together, form a much larger workforce risk story.



## 📂 Dataset Overview

| Property | Details |
|---|---|
| Company | TalentIQ Analytics (fictional) |
| Total Employees | 310 |
| Active Employees | 184 (59.4%) |
| Terminated Employees | 103 (33.23%) |
| Time Period | 2012 — 2019 |
| Tool | PostgreSQL + Power BI |

> ⚠️ Dataset Note: HRDataset_v13 is a publicly available HR dataset. 



## Tools & Methodology

| Tool | Purpose |
|---|---|
| PostgreSQL | Data cleaning, transformation and analysis |
| pgAdmin 4 | Query execution |
| VS Code | Writing and saving SQL scripts |
| Power BI Desktop | Interactive dashboards |
| DAX | KPI measures and dynamic calculations |



## 📊 Dashboard 1 — Attrition & Retention

<img width="1462" height="821" alt="Dashboard 1" src="https://github.com/user-attachments/assets/742d0fd8-d7cd-40a9-94bd-ebff9911d42e" />


### KPIs

| Metric | Value | Indicator |
|---|---|---|
| Total Employees | 310 | 59.4% Active |
| Overall Attrition Rate | 33.23% | 🔴 Above healthy level |
| Voluntary Attrition Rate | 28.39% | 🟢 ↓ 35.9% vs 2018 |
| Top Termination Reason | Another Position | 19.42% of exits |

### The 2018 Crisis

In 2017 TalentIQ lost 2 employees.
In 2018 TalentIQ lost 83 employees.

No organization loses 83 employees in a single year without warning signs. The challenge is that those warning signs often appear long before they become visible in annual HR reports.

The investigation reveals:
- Production lost 70 out of 83 people who left in 2018
- Production Technician I — 45 people left from this single role
- Top reasons: *Another Position, More Money, Career Change* — all tied at 7 each

By 2019 terminations dropped to 68 — an 18.07% improvement.
The turnover surge likely increased recruitment costs, disrupted productivity, and resulted in the loss of organizational knowledge.

### Why Are They Really Leaving?



| Reason | Count | Type |
|---|---|---|
| Another Position | 20 | Preventable |
| Unhappy | 14 | Preventable |
| More Money | 11 | Preventable |
| Career Change | 9 | Partially Preventable |
| Hours | 9 | Preventable |

Another Position + Unhappy + More Money + Hours = 52.43% of all exits

More than half of everyone who left could potentially have been retained.

### Early vs Long-Term Leavers

| Group | Root Cause |
|---|---|
| Early Leavers (< 2 years) | Hiring problem — wrong people being brought in |
| Long-Term Leavers (2+ years) | Retention problem — good people being pushed out |

These require two completely different HR interventions.



## 💰 Dashboard 2 — Compensation & Pay Equity

<img width="1460" height="817" alt="Dashboard 2" src="https://github.com/user-attachments/assets/95d48d4e-3594-4aca-a5f1-76d9b7888c2d" />


### KPIs

| Metric | Value | Indicator |
|---|---|---|
| Avg Pay Rate | $31.28/hr | Range: $14 — $80/hr |
| Gender Pay Gap | 12.54% | 🔴 $4.23/hr gap |
| Female Avg Pay | $29.47/hr | 🔴 ↓ $1.81 below avg |
| Male Avg Pay | $33.70/hr | 🟢 ↑ $2.42 above avg |

### Pay Equity Findings

*(Insert Combo chart screenshot here)*

The overall gender pay gap is 12.54% — but department analysis reveals a more nuanced story:

| Department | Female Avg | Male Avg | Gap |
|---|---|---|---|
| Admin Offices | $26.16 | $40.50 | $14.34 🔴 |
| IT/IS | $43.57 | $47.54 | $3.97 🟡 |
| Production | $22.61 | $23.83 | $1.22 🟢 |
| Sales | $55.68 | $55.38 | -$0.30 ✅ |
| Software Engineering | $52.33 | $43.17 | -$9.16 ✅ |

The pay gap is not company-wide. It is concentrated in Admin Offices.

### Salary Band Compliance


The analysis revealed potential inconsistencies between the organization's compensation framework and actual pay practices. When employees at the highest levels fall below established salary band minimums, it raises important questions about how compensation policies are being applied across the organization.

| Position | Actual Pay | Minimum Band | Shortfall |
|---|---|---|---|
| IT Manager DB | $21.00 | $50.00 | $29.00 🔴 |
| President & CEO | $80.00 | $95.00 | $15.00 🔴 |
| CIO | $65.00 | $75.00 | $10.00 🔴 |

### Performance vs Pay


| Performance | Avg Pay |
|---|---|
| Exceeds | $32.08/hr |
| Fully Meets | $31.30/hr |
| PIP | $31.79/hr |
| Needs Improvement | $29.08/hr |

The compensation difference between employees who exceed expectations and those who simply meet them is relatively small. This raises a strategic question: *Are current compensation practices providing enough incentive for employees to consistently perform at the highest level?*



## 🔥 Dashboard 3 — Burnout & Engagement

<img width="1460" height="811" alt="Dashboard 3" src="https://github.com/user-attachments/assets/571aae9c-5f5a-4813-800c-602f428becd0" />


### KPIs

| Metric | Value | Indicator |
|---|---|---|
| Avg Engagement | 3.33 | 🔴 4.0 Goal |
| Avg Satisfaction | 3.89 | 🟢 3.5 Benchmark |
| Avg Days Late | 0.89 | 🔴 Sales: 1.55 Days |
| Highest Workload | IT/IS | 🔴 5.92 Projects |

### The Distributed Risk Map


| Department | Primary Risk |
|---|---|
| Production | Retention Risk 🔴 |
| Software Engineering | Engagement Risk 🔴 |
| IT/IS | Workload Risk 🟡 |
| Sales | Attendance Risk 🟡 |
| Admin Offices | Pay Equity Risk 🟡 |

No single intervention will fix this. Each department needs a targeted response based on its specific risk profile.

### The Danger Zone

Production has the highest attrition (39.90%) but moderate engagement (3.37).
Software Engineering has the lowest engagement (2.63) but moderate attrition (30%).

These two departments represent different stages of the same challenge:
- Production is already losing people
- Software Engineering may represent the organization's next retention challenge if engagement levels continue to decline



## Hidden Insights

Insight 1 — The Attendance Signal

Terminated employees averaged 0.99 days late vs active employees at 0.84 days late.
Attendance is an early warning signal not just a performance issue.

Insight 2 — The Referral Advantage

Employee referrals consistently produced the strongest retention outcomes. In contrast, several external recruitment channels generated substantially higher attrition rates suggesting an opportunity to reallocate recruitment spending toward sources with demonstrated long-term hiring success.

Insight 3 — The 2018 Warning

The 2018 spike appeared sudden, but the Production department had been experiencing turnover issues for years before the crisis became visible at the organizational level.



## 👥 Team Retention Analysis

| Manager | Team Size | Turnover Rate | Avg Engagement |
|---|---|---|---|
| Webster Butler | 21 | 61.90% 🔴 | 3.78 |
| Amy Dunn | 21 | 61.90% 🔴 | 3.58 |
| Kissy Sullivan | 22 | 54.55% 🔴 | 2.93 |
| Simon Roup | 17 | 47.06% 🔴 | 3.53 |
| Michael Albert | 22 | 40.91% 🟡 | 3.73 |

These patterns raise important questions about team culture, workload distribution and leadership support without placing direct blame on individual managers.



## 🎯 Recruitment Source Effectiveness

| Source | Attrition Rate | Avg Engagement |
|---|---|---|
| Employee Referral | 14.29% 🟢 | 3.60 |
| LinkedIn | 25.00% 🟢 | 3.61 |
| Indeed | 30.84% 🟡 | 3.40 |
| Diversity Job Fair | 36.00% 🟡 | 3.20 |
| Word of Mouth | 38.46% 🔴 | 2.85 |
| Monster.com | 46.15% 🔴 | 3.50 |
| Website Banner Ads | 50.00% 🔴 | 3.09 |
| Glassdoor | 100.00% 🔴 | 1.87 |

> ⚠️ Glassdoor recorded the highest attrition rate in the dataset. However this result should be interpreted cautiously due to an extremely small sample size (one hire).

Employee referrals consistently produced the strongest retention outcomes. Reallocating recruitment budget toward referral incentives and away from underperforming channels represents a clear opportunity.



## What Leadership Should Be Watching Next

- Engagement trends in Software Engineering
- Workload growth within IT/IS
- Retention outcomes following Production interventions
- Department-level pay equity reviews
- Referral hiring expansion and ROI



## ✅ Strategic Recommendations

1. Emergency — Production — Immediate pay review and retention initiatives for frontline roles
2. Early Warning — Software Engineering — Launch targeted engagement survey before attrition accelerates
3. Fix Salary Band Compliance — 8 employees including senior leadership paid below minimum bands
4. Redesign Performance Pay — $0.78/hour gap between top and average performers is insufficient
5. Address Admin Offices Pay Gap — $14.34/hour gender disparity requires immediate review
6. Invest in Referral Programs — Reallocate budget from high-attrition channels
7. Manager Support — Three managers with 50%+ turnover need leadership coaching and team support
8. Build Early Warning System — Monitor attendance and engagement monthly as leading indicators



## 💡 Conclusion

The findings suggest that TalentIQ's workforce challenges cannot be explained by attrition alone. The organization is experiencing multiple workforce risks emerging in different departments at different stages of severity.

Production is already in crisis.
Software Engineering is approaching one.
IT/IS is overloaded and quietly disengaging.
Sales is showing attendance patterns that historically precede attrition.
Admin Offices has a pay equity problem hiding in plain sight.



---
### SQL Queries Snapshot

Query 1 — Department Attrition Analysis
```sql
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(termd) AS terminated_employees,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_employees
GROUP BY department
ORDER BY attrition_rate DESC;
```

Query 2 — Recruitment Source Effectiveness
```sql
SELECT
    recruitmentsource,
    COUNT(*) AS hires,
    SUM(termd) AS terminated,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM hr_employees
GROUP BY recruitmentsource
ORDER BY attrition_rate;
```

Query 3 — Manager Turnover Analysis
```sql
SELECT
    managername,
    COUNT(*) AS team_size,
    SUM(termd) AS terminations,
    ROUND(SUM(termd) * 100.0 / COUNT(*), 2) AS turnover_rate
FROM hr_employees
GROUP BY managername
ORDER BY turnover_rate DESC;
```


## 📬 Connect With Me

[

![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)

](https://www.linkedin.com/in/odu-deborah)
