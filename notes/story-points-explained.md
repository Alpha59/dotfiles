# Story Points Explained

Estimations of story points are simply the best guess based on experience with similar work. No-one can estimate perfectly, and with human bias, story point estimations turn into currency within a team. This means that when teams need to complete more work, they will estimate stories lower – Supply and Demand can heavily influence pointing. Thoughts like “I would rather not work on this, I’ll estimate it higher”, or “Let’s point this lower, so we can fit it into the sprint”, influence pointing outcome.

With some stories, there are known factors, or direct comparisons. For others, there are risks, ambiguity, or expected unknowns. Finally, there are unexpected unknowns to every story. Given that we understand a story point to be simply an estimation, these things are to be expected. In rare cases, there are unknowns that make a story complete faster, or make a story less effort. These are much less likely than unknowns, risks, or ambiguities that increase stories time to complete. This leads to the understanding, that any stories time to complete – given an estimate, will be a positive-skewed bell curve.

[Image: image.png]


>Positive skewed distributions **occur when the long tail is on the right side of the distribution**. Analysts also refer to them as positively skewed. This condition occurs because probabilities taper off more slowly for higher values.


We can take the mode of the right skew to be the story point assigned. In the above example, the Orange line represents a point value of 1. The mean will then fall in the middle of the bell curve, but always to the right. The mean will always be greater than the mode. This applies to any story point value, and can be easily reasoned. Given 5 stories, all assigned a value of 3, it is more likely that one story will require significantly more effort due to the unknowns. This is, of course, paired with a lower bound of 0.

Continuing our example of 5 stories pointed at 3 points each, they may result in efforts equalling: 3,3,8,5,1 - which has a mode of 3, but a mean of 4. Extrapolating to a higher number of stories, this example shows 80 stories, with a mean of 4, but a mode of 3. This creates a total of 320 points, expended, but only 240 estimated. Estimated capacity is therefore 30% lower than the actual effort given.

Taking the same example for datasets of 1,2,3,5,8,13,21 point stories, with a mean 25% higher, we will see a pattern emerge of dips and peaks surrounding the story points


We also know that sprints tend to be 3 point story heavy. So let’s extrapolate that to be 50%, with degrading totals moving away from that midpoint. This gives us 74 total stories, with a sum of 354 points. A mean of 4.75, but a mode of 3.

Combing this data set, we get a clear histogram of this theoretical sprint

Stretching from 1 point to 21, with a mode of 3 – but mean of almost 5. This means 60% of the work in this theoretical sprint was not accounted for when the sprint was planned. These numbers are of course theoretical, and anecdotal at best.

When we take this example, this means that 40% of the work in the sprint is unlikely to be finished. To offset this, teams should always utilize a sprint capacity of 60-80% of their total expected capacity. The exact value can be calculated by taking the mode (3) and dividing by the mean (5) to determine: 3/5 = 60%. This requires numerous data points to determine, so teams may find it more useful to examine the number of stories completed, the number of points completed, and the mode value of those stories.

A series of binomial distributions could be added together to calculate exact values. This is impractical. A more practical way to calculate is:

1. Agree as a team on time value for 3 points
    1. e.g., 1/2 day == 3 points
    2. e.g., 1 day == 5 points
2. Aim to create stories at the 3 point mark.
3. Create and estimate stories accordingly.
4. Multiply (Number of Devs)*(Days per sprint)
    1. e.g., 7 × 10 = 70
5. Determine “Coding hours” per day. This is typically 6 in an 8-hour workday.
    1. 2 hours are reserved for meetings, stand-up, discussions, and helping other developers.
6. Multiply the number of Development days by Hours per day
    1. 70 × 6 = 420
7. Divide this by the Mode (3) expected hours
    1. 1 day (6 hours) * .5 = 3 hours.
    2. 420 / 3 = 140 points
8. Start with 60%
    1. 140 x 60% = 84 points / Sprint.
9. Increase multiplier by 5% each time the team finishes all stories in a sprint
    1. 140 x 60% = 84 points / Sprint
    2. 140 x 65% = 91 points / Sprint
    3. 140 x 70% = 98 points / Sprint
    4. 140 x 75% = 105 points / Sprint
    5. 140 x 80% = 112 points / Sprint
10. Stop increasing, or possibly decrease, the multiplier if the team does not complete the sprint, or the team reaches 80% and is still completing the sprint.

After determining the team's ideal capacity, if the team continually completes the sprint within the 80% mark – attempt the same variation, but decrease the baseline of the mode's expected hours. In the above example, this would lead to 3 points requiring 2 hours instead of 3.

1. 3 points == 1/3 day
    1. 210 x 60% = 126 points / Sprint
    2. 210 x 65% = 137 points / Sprint
    3. 140 x 65% = 91 points / Sprint
    4. 210 x 70% = 147 points / Sprint
    5. 210 x 75% = 158 points / Sprint
    6. 210 x 80% = 168 points / Sprint

This can be repeated numerous times – with a lower limit of the mode (3 points) requiring 30 minutes of time. Points apart from the mode should not have any tangible association with time. If mode shifts away from 3, there is a high likelihood that the stories written by the team need to be adjusted. This will maintain the team’s sprint capacity, while not under or over boarding the team’s workload.


## Project Planning

In an ideal world, a team would estimate stories with 100% certainty, and get a perfect estimation of the amount of time/effort required to complete the project. In the real world, reporting should be done on the 95% (2 standard deviations) of the mean. Using the example above, we can take a common mode of 3, a mean of 5, and a standard deviation of .5. This allows us to report stories as being 5+(2*.5) = 6. This is double the mode value.

A theoretical project planned with a total of 691 points, distributed across 181 stories, would have an expected vs actual distribution of point values leaning higher than estimated.

If we utilize the (hypothetical) team's known distribution, of a mode of 3 but mean of 5, the total is 905 points. Given a safe skewness of 6, the standard deviation for this distribution would be 1 point. This gives a 95% chance that the team will complete the project within 1,267 points. Calculating project timelines would therefore break down into:


1. Point all tickets with a mode of 3
2. Multiply the number of stories by:
    1. Total Story Count x ( (mean) + (2 x (std_dev)) )
        1. (5 + (2 x 1)) x Total Story Count == 1,267
    2. Simplified to
        1. Total Story Count x 7 == 1,267
3. Convert this to sprints by dividing by points / sprint
    1. CEIL(1,267 / (points per sprint))
    2. CIEL(1,267 / 126) = 11 Sprints.

This gives a total project total of:

```
           TOTAL_STORY_COUNT * (MEAN_POINTS + (2*STD_DEV))
-------------------------------------------------------------------
((DEVS * HOURS_PER_SPRINT)/MODE_HOURS_EXPECTED) * SPRINT_MULTIPLIER
```

Which, with some assumptions, can be simplified. These assumptions are based on recommendations for what teams should aim to complete.

1. Mode = 3 points
2. Mode = 1/2 day
3. Mean = 5
4. Standard Deviation is 1 point
5. A 70% Sprint multiplier is being utilized

```
TOTAL_STORY_COUNT
----------------- = Expected Number of Sprints
   DEVS * 2
```

In the standard project. This value will fall between 1 and 3 depending on the team and assumptions. A value of 3 would be a very high performing team with minimal deviation in estimations, and a full workload. A value of 1 would be expected for teams with higher unknowns.


## Sprint Planning

Calculating Sprint capacity requires knowing several factors of previous sprints.

From the last 5 sprints, you will need to know

* Completed Points
* Capacity Percent
* Number of Days off in Sprint
* Number of Developers in the Sprint
* Planned Points

For each of the variables above, you will take a weighted average - with weights equal to 1.2,1.1,1,.9, and .8 as they move backwards through the previous sprints. So the previous sprint (-1) would have a weight of 1.2, and the one before that (-2) would have a weight of 1.1, and so on.

Using these weighted averages helps to ensure that although the most recent sprints more heavily influence the scores, we are not working with outliers that do not accurately reflect real-world situations.

For the Current Sprint, you will need to know:

* Number of Days off in the Sprint
* Number of Developers working in the Sprint

And you will have to determine a few constants that work for your team:

* Days off Adjustment (1.5)
* Reduced Capacity adjustment

Finding the points per sprint is now relatively easy:

This average theoretical max is the number of points that would have theoretically been completed, if everyone was working at full capacity.


```
AVERAGE_COMPLETED_POINTS
------------------------ = AVERAGE_THEORETICAL
AVERAGE_CAPACITY_PERCENT

AVERAGE_THEORETICAL
------------------- = AVERAGE_DEVELOPER_POINTS
AVERAGE_DEVELOPERS

DAYS_PER_SPRINT - (AVERAGE_NUMBER_OF_DAYS_OFF * DAYS_OFF_ADJUSTMENT) = AVERAGE_DAYS_TOTAL

                            DAYS_PER_SPRINT
AVERAGE_DEVELOPER_POINTS * ------------------- = THEORETICAL_DEVELOPER_POINTS
                           AVERAGE_DAYS_TOTAL

DAYS_PER_SPRINT - (DAYS_OFF * DAYS_OFF_ADJUSTMENT) = SPRINT_DAYS_TOTAL

                    THEORETICAL_DEVELOPER_POINTS
SPRINT_DAYS_TOTAL * ---------------------------- * NUMBER_OF_DEVELOPERS = MAX_SPRINT_CAPACITY
                         DAYS_PER_SPRINT

MAX_SPRINT_CAPACITY * SPRINT_CAPACITY_PERCENT = SPRINT_CAPACITY
```

Or, Reduced to a single formula:

```
                           NUMBER_OF_DEVELOPERS * SPRINT_CAPACITY_PERCENT  * (DAYS_PER_SPRINT - (          DAYS_OFF         * DAYS_OFF_ADJUSTMENT))
AVERAGE_COMPLETED_POINTS * ------------------------------------------------------------------------------------------------------------------------ = S
                           AVERAGE_DEVELOPERS   * AVERAGE_CAPACITY_PERCENT * (DAYS_PER_SPRINT - (AVERAGE_NUMBER_OF_DAYS_OFF * DAYS_OFF_ADJUSTMENT))
```


Using a practical Example, of a team who averages 100 points per sprint, at 80% capacity, and 10 developers in a 2 week sprint, with 1 day off.

```
 100
----- = 125 AVERAGE_THEORETICAL
 80%

 125
----- = 12.5 AVERAGE_DEVELOPER_POINTS_PER_SPRINT
 10

10 - (.2 * 1.5) = 9.7 AVERAGE_DAYS_TOTAL

        10
12.5 * ---- = 12.89 THEORETICAL_DEVELOPER_POINTS
       9.7

10 - (1 * 1.5) = 8.5

       12.89
8.5 * ------- * 10 = 110 MAX_SPRINT_CAPACITY
        10

110 * 80% = 88 SPRINT_CAPACITY
```

```
      10 * .8  * (10 - (1  * 1.5))
100 * ---------------------------- = 88
      10 * .8  * (10 - (.2 * 1.5))
```

Or, a team who averages 200 points per sprint, at 70% capacity, who added a new developer this week, for a total of 10, with 1 day off last sprint, but none this sprint:

```
      10 * .75  * (10 - (0  * 1.5))
200* ---------------------------- = 245
       9 *  .7  * (10 - (.2 * 1.5))
```

Even though in the previous sprints they averaged 22 points per developer, their stretch goal of +5%, adding a new developer, and not having any time off this sprint - brings the team to a total of 45 additional points. The next sprint, their moving averages would have changed, but nothing else.

```
          10 * .762 * (10 -  (0  * 1.5))
210 *  ---------------------------------- = 248
        9.24 * .712 * (10 - (.152 * 1.5))

          10 * .774 * (10 -  (0  * 1.5))
219 *  ---------------------------------- = 253
        9.42 * .724 * (10 - (.11 * 1.5))
```

This would bring their total capacity up by only 3 points for the new sprint, and 5 for the one after that. This formula should bring the team to equilibrium, even when there are changes to the structure or capacity of the team.

