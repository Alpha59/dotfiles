# Very-High-Level Effort Breakdown Template

**Project Name: [Insert Project Name]**
**Project Sizing: [XXS/XS/S/M/L/XL/XXL]**

|Summary of Estimate	|SDE Weeks	|
|---	|---	|
|Project Specific Items	|230	|
|Standard Project Items	|167	|
|Assumptions Estimate if proven wrong	|120.5	|
|Total SDE Weeks	|518	|
|Head Count Normalized for 1 Year	|11	|
|Total Time to Complete (Weeks)	|155	|

## **Overview**

* **Objective:** [Brief description of the project’s goals and expected outcomes.]
* **Timeline:** [Estimated start and end dates, considering the project size.]
* **Primary Team:** ADRL Tech
* **Additional Resources:** [Any external teams or additional resources that might be needed.]


This table assumes each project is done separate from the other projects, creating a heftier overall effort:

|	|	|	|	|
|---	|---	|---	|---	|
|EPIC Level	|#ERROR!	|#ERROR!	|#ERROR!	|
|Standard Project Items SDE (Weeks)	|#ERROR!	|#ERROR!	|#ERROR!	|
|Project Specific Items SDE (Weeks)	|#ERROR!	|#ERROR!	|#ERROR!	|
|Total SDE (Weeks)	|#ERROR!	|#ERROR!	|#ERROR!	|
|Post Deployment SDE Weeks	|#ERROR!	|#ERROR!	|#ERROR!	|

## **Documentation Requirements**

* **Required Documents:**
* [List any required documents such as PR/FAQ, Business Requirements, High-Level Design (HLD), Low-Level Design (LLD), etc.]
* **Estimated Time for Documentation:** [Time allocated for the creation and review of required documents.]

## **Design Requirements**

* **High-Level Design:**
* [Specify if HLD is required and the number of phases involved.]
* **Low-Level Design:**
* [Specify if LLD is required and the complexity or detail needed.]
* **Estimated Design Time:** [Time allocated for design work.]

## **Infrastructure Requirements**

* **Existing Systems:**
* [Specify any small or moderate changes needed.]
* **New Infrastructure:**
* [Detail if new services or significant updates to infrastructure are required.]
* **Estimated Time for Infrastructure Work:** [Time allocated for infrastructure-related tasks.]

## **Dependencies**

* **Internal Dependencies:**
* [List any dependencies within the immediate organization.]
* **External Dependencies:**
* [List any dependencies outside the immediate organization, if applicable.]
* **Dependency Management Plan:** [How dependencies will be tracked and managed.]

## **Security Considerations**

* **Security Reviews:**
* [Detail if any security reviews are required, including internal and external audits.]
* **Compliance Requirements:**
* [Mention any compliance standards or external audits that must be considered.]
* **Estimated Time for Security Work:** [Time allocated for security considerations.]

## **Risk Assessment**

* **Identified Risks:**
* [List potential risks associated with the project.]
* **Mitigation Strategies:**
* [Outline strategies to mitigate identified risks.]

## **Milestones and Deliverables**

* **Key Milestones:**
* [List major milestones and their expected completion dates.]
* **Deliverables:**
* [List specific deliverables that will be produced throughout the project.]

These estimates are specific to Code Changes only:

|- Code Changes	|SDE Weeks	|Implementation	|Unit Testing	|Integration Testing	|Functional Testing	|
|---	|---	|---	|---	|---	|---	|
|	|	|0	|0	|0	|0	|
|	|	|0	|0	|0	|0	|
|	|	|0	|0	|0	|0	|
|	|	|0	|0	|0	|0	|
|	|	|0	|0	|0	|0	|
|	|	|0	|0	|0	|0	|
|	|	|0	|0	|0	|0	|
|	|	|0	|0	|0	|0	|
|Total SDE (Weeks)	|0	|0	|0	|0	|0	|

## **Approval:**

* **Project Lead:** [Name]
* **Stakeholders:** [Names of key stakeholders for approval]

# Appendix

### Open Questions

|Open Questions	|
|---	|
|	|
|	|
|	|
|	|
|	|

### Project Assumptions

|Risks	|SDE Weeks	|Min	|Max	|
|---	|---	|---	|---	|
|Change In Requirements	|12.5	|5	|20	|
|Integration issues	|15	|10	|20	|
|Technical Debt Causing Delays	|17.5	|10	|25	|
|Scalability Challenges	|12.5	|10	|15	|
|Tooling Challenges	|7.5	|5	|10	|
|Data Decoding/Access Issues	|7.5	|5	|10	|
|API Contract Misalignment	|7.5	|5	|10	|
|Third-Party Service changes	|7.5	|5	|10	|
|Data Migration Issues	|7.5	|5	|10	|
|Authentication or Authorization Failures	|3.5	|2	|5	|
|Dependency on Deprecated Libraries	|3.5	|2	|5	|
|Performance Bottleneck	|3.5	|2	|5	|
|Environment Configuration and Deployment Failures	|7.5	|5	|10	|
|Insufficient Existing Test Coverage	|7.5	|5	|10	|
|Total SDE Wks	|120.5	|40	|90	|

## Estimates Breakdown

HeadCount breakdown by Month:

|	|Q1	|Q2	|Q3	|Q4	|
|---	|---	|---	|---	|---	|
|	|January	|Febuary	|March	|April	|May	|June	|July	|August	|September	|October	|November	|December	|
|2026	|1	|1	|1	|2	|2	|3	|3	|2	|2	|2	|2	|2	|


This table assumes a 2 Pizza team working in sprints to complete the work.

|6	|Step	|SDE Weeks	|Project Total	|XS	|S	|M	|L	|XL	|XXL	|XXXL	|
|---	|---	|---	|---	|---	|---	|---	|---	|---	|---	|---	|
|17%	|PR	|3	|3	|0	|1	|2	|2	|2	|4	|6	|
|17%	|FAQ	|2	|2	|0	|0	|2	|2	|4	|6	|8	|
|17%	|HLD	|4	|4	|0	|2	|2	|2	|4	|6	|12	|
|17%	|OP1	|	|6	|0	|2	|4	|8	|16	|16	|16	|
|	|Service	|Team	|Component	|Notes	|SDE Weeks	|Cross-Functional Team Alignment	|3	|3	|0	|1	|2	|4	|4	|4	|4	|
|	|	|	|	|	|6	|Cross-Functional team Joint Application Design 	|0	|0	|0	|0	|0	|0	|8	|8	|8	|
|	|Cross-Functional Team Approval	|3	|3	|0	|1	|2	|4	|4	|4	|4	|
|33%	|LLD	|16	|8	|2	|2	|4	|4	|6	|6	|8	|
|0.66667	|Infrastructure 	|	|	|0	|2	|4	|6	|8	|10	|14	|
|	|	|	|	|	|	|Pipeline Set-up	|8	|2	|0	|0	|2	|2	|2	|2	|2	|
|	|	|	|	|	|Environment Set-up	|16	|4	|0	|2	|2	|2	|4	|6	|8	|
|	|	|	|	|	|Monitoring and Alertning Set-up	|0	|0	|0	|0	|0	|2	|2	|2	|4	|
|	|Code Changes	|	|	|6	|18	|20	|34	|36	|50	|86	|
|	|	|100%	|	|	|	|New Feature Implementation	|60	|10	|2	|4	|4	|8	|8	|16	|32	|
|	|50%	|	|	|	|Refactoring Existing Code	|6	|2	|0	|0	|2	|2	|4	|4	|8	|
|	|50%	|	|	|	|Schema Updates	|12	|4	|0	|2	|2	|4	|4	|4	|6	|
|	|50%	|	|	|	|Data Migration Scripts	|12	|4	|0	|2	|2	|4	|4	|4	|4	|
|	|33%	|	|	|	|API Development	|8	|4	|0	|2	|2	|2	|2	|2	|2	|
|	|100%	|	|	|	|Dependency Updates	|24	|4	|0	|2	|2	|4	|4	|4	|4	|
|	|33%	|	|	|	|Feature Flag Implementation	|12	|6	|2	|2	|2	|2	|2	|2	|2	|
|	|100%	|	|	|	|Unit Testing	|12	|2	|0	|1	|1	|2	|2	|3	|7	|
|	|100%	|	|	|	|Integration Testing	|24	|4	|1	|1	|2	|3	|4	|7	|13	|
|	|100%	|	|	|	|End-to-end Functional Testing	|12	|2	|0	|1	|1	|2	|2	|3	|7	|
|50%	|Related Systems	|24	|8	|2	|2	|4	|8	|16	|22	|30	|
|33%	|Security	|	|12	|0	|6	|6	|6	|10	|10	|14	|
|	|	|	|	|	|	|Amazon Security Review	|8	|4	|0	|2	|2	|2	|4	|4	|6	|
|	|	|	|	|	|Disaster Recovery Planning / Implementation	|8	|4	|0	|2	|2	|2	|4	|4	|6	|
|	|	|	|	|	|Auth Implemetation	|8	|4	|0	|2	|2	|2	|2	|2	|2	|
|33%	|Feature Testing	|12	|6	|0	|2	|4	|4	|4	|6	|8	|
|33%	|Integrate with Existing Systems	|12	|6	|2	|2	|2	|2	|2	|4	|4	|
|67%	|UAT	|32	|8	|2	|2	|4	|4	|4	|4	|6	|
|67%	|P-UAT	|24	|6	|2	|2	|2	|2	|4	|6	|6	|
|33%	|ORR / Go-No Go	|12	|6	|0	|2	|4	|4	|4	|4	|6	|
|67%	|Deploy	|20	|5	|1	|2	|2	|2	|2	|4	|4	|
|33%	|Hypercare	|12	|6	|0	|2	|4	|4	|4	|4	|6	|
|17%	|Post Deployment Monitoring	|24	|24	|0	|8	|16	|16	|16	|16	|24	|
|17%	|Project RetroSpective / Lesson Learned	|3	|3	|1	|1	|1	|1	|1	|1	|1	|
|TTC (Weeks)	|	|155	|17	|57	|87	|110	|143	|178	|258	|
|TTC (Years)	|	|3	|0.5	|1.25	|1.75	|2.25	|2.75	|3.5	|5	|
|Standard Project Items SDE (Weeks)	|167	|167	|28	|57	|82	|86	|118	|148	|186	|
|Specific Project Items SDE (Weeks)	|230	|230	|30	|86	|114	|198	|244	|350	|584	|
|Total SDE (Weeks)	|397	|397	|58	|71	|110	|134	|198	|254	|332	|
|Post Deployment SDE Weeks	|39	|39	|1	|13	|25	|25	|25	|25	|37	|

Estimates in this table are based on the assumptions above.

## Main Project Estimates

|6	|Step	|XS	|S	|M	|L	|XL	|XXL	|XXXL	|
|---	|---	|---	|---	|---	|---	|---	|---	|---	|
|17%	|PR	|0	|0	|0	|0	|1	|2	|4	|
|17%	|FAQ	|0	|0	|0	|0	|0	|2	|6	|
|17%	|HLD	|0	|0	|0	|1	|2	|2	|6	|
|17%	|OP1	|0	|0	|0	|2	|2	|8	|16	|
|	|Service	|Team	|Component	|Notes	|SDE Weeks	|Cross-Functional Team Alignment	|0	|0	|0	|0	|1	|4	|4	|
|	|	|	|	|	|0	|Cross-Functional team Joint Application Design 	|0	|0	|0	|0	|0	|0	|8	|
|	|Cross-Functional Team Approval	|0	|0	|0	|1	|1	|4	|4	|
|33%	|LLD	|0	|1	|2	|2	|2	|4	|6	|
|67%	|Infrastructure 	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|Pipeline Set-up	|0	|0	|0	|0	|0	|2	|2	|
|	|	|	|	|	|Environment Set-up	|0	|0	|0	|1	|2	|2	|6	|
|	|	|	|	|	|Monitoring and Alertning Set-up	|0	|0	|0	|0	|0	|2	|2	|
|100%	|Code Changes	|	|	|	|	|	|	|	|
|	|	|100%	|	|	|	|New Feature Implementation	|2	|2	|2	|3	|4	|8	|24	|
|	|50%	|	|	|	|Refactoring Existing Code	|0	|0	|0	|1	|2	|2	|6	|
|	|50%	|	|	|	|Schema Updates	|0	|0	|0	|1	|2	|4	|6	|
|	|50%	|	|	|	|Data Migration Scripts	|0	|0	|0	|1	|2	|4	|6	|
|	|33%	|	|	|	|API Development	|0	|0	|0	|0	|2	|2	|4	|
|	|100%	|	|	|	|Dependency Updates	|0	|0	|0	|0	|2	|4	|6	|
|	|33%	|	|	|	|Feature Flag Implementation	|0	|0	|2	|1	|2	|2	|4	|
|	|100%	|	|	|	|Unit Testing	|0	|0	|0	|1	|1	|2	|5	|
|	|100%	|	|	|	|Integration Testing	|1	|1	|1	|1	|2	|3	|10	|
|	|100%	|	|	|	|End-to-end Functional Testing	|0	|0	|0	|1	|1	|2	|5	|
|50%	|Related Systems	|2	|2	|2	|2	|2	|8	|22	|
|33%	|Security	|0	|0	|0	|4	|6	|6	|10	|
|	|	|	|	|	|	|Amazon Security Review	|0	|0	|0	|0	|2	|2	|4	|
|	|	|	|	|	|Disaster Recovery Planning / Implementation	|0	|0	|0	|2	|2	|2	|4	|
|	|	|	|	|	|Auth Implemetation	|0	|0	|0	|2	|2	|2	|2	|
|33%	|Feature Testing	|0	|0	|0	|1	|2	|4	|6	|
|33%	|Integrate with Existing Systems	|0	|0	|2	|2	|2	|2	|4	|
|67%	|UAT	|0	|1	|2	|2	|2	|4	|4	|
|67%	|P-UAT	|1	|1	|2	|2	|2	|2	|6	|
|33%	|ORR / Go-No Go	|0	|0	|0	|1	|2	|4	|4	|
|67%	|Deploy	|0	|0	|1	|1	|2	|2	|4	|
|33%	|Hypercare	|0	|0	|0	|1	|2	|4	|4	|
|17%	|Post Deployment Monitoring	|0	|0	|0	|4	|8	|16	|16	|
|17%	|Project RetroSpective / Lesson Learned	|0	|0	|1	|1	|1	|1	|1	|
|TTC (Weeks)	|6	|8	|17	|36	|58	|104	|195	|
|TTC (Years)	|0.25	|0.25	|0.5	|0.75	|1.25	|2	|3.75	|
|Standard Project Items SDE (Weeks)	|4	|10	|28	|43	|57	|86	|148	|
|Project Specific Items SDE (Weeks)	|26	|26	|30	|55	|100	|198	|476	|
|Total SDE (Weeks)	|30	|36	|58	|98	|157	|284	|624	|
|Post Deployment SDE Weeks	|0	|0	|1	|7	|13	|25	|25	|
|	|	|	|	|	|	|	|24	|36	|72	|144	|288	|396	|576	|
|	|	|	|	|	|	|	|6	|0	|-14	|-46	|-131	|-112	|48	|
|	|	|	|	|	|	|	|3	|6	|12	|24	|48	|96	|192	|

## Epic Estimates

|6	|Step	|XS	|S	|M	|L	|XL	|XXL	|XXXL	|
|---	|---	|---	|---	|---	|---	|---	|---	|---	|
|17%	|PR	|0	|0	|1	|2	|2	|2	|4	|
|17%	|FAQ	|0	|0	|0	|2	|2	|4	|6	|
|17%	|HLD	|0	|0	|2	|2	|2	|4	|6	|
|17%	|OP1	|0	|0	|2	|4	|8	|16	|16	|
|	|Service	|Team	|Component	|Notes	|SDE Weeks	|Cross-Functional Team Alignment	|0	|0	|1	|2	|4	|4	|4	|
|	|	|	|	|	|0	|Cross-Functional team Joint Application Design 	|0	|0	|0	|0	|0	|8	|8	|
|	|Cross-Functional Team Approval	|0	|0	|1	|2	|4	|4	|4	|
|33%	|LLD	|	|	|	|	|	|	|	|
|67%	|Infrastructure 	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|Pipeline Set-up	|1	|2	|2	|2	|4	|4	|4	|
|	|	|	|	|	|Environment Set-up	|	|	|	|	|1	|2	|2	|
|	|	|	|	|	|Monitoring and Alertning Set-up	|1	|2	|2	|2	|4	|4	|4	|
|100%	|Code Changes	|	|	|	|	|	|	|	|
|	|	|100%	|	|	|	|New Feature Implementation	|	|	|	|	|4	|8	|10	|
|	|50%	|	|	|	|Refactoring Existing Code	|	|	|	|	|2	|4	|6	|
|	|50%	|	|	|	|Schema Updates	|	|	|	|	|	|	|	|
|	|50%	|	|	|	|Data Migration Scripts	|	|	|	|	|	|	|	|
|	|33%	|	|	|	|API Development	|	|	|	|	|	|	|	|
|	|100%	|	|	|	|Dependency Updates	|	|	|	|	|2	|4	|6	|
|	|33%	|	|	|	|Feature Flag Implementation	|	|	|	|	|2	|4	|6	|
|	|100%	|	|	|	|Unit Testing	|	|	|	|	|2	|4	|6	|
|	|100%	|	|	|	|Integration Testing	|	|	|	|	|2	|4	|5	|
|	|100%	|	|	|	|End-to-end Functional Testing	|	|	|	|	|2	|4	|6	|
|50%	|Related Systems	|1	|2	|2	|3	|4	|8	|10	|
|33%	|Security	|	|	|	|2	|4	|6	|6	|
|	|	|	|	|	|	|Amazon Security Review	|	|	|	|0	|1	|2	|2	|
|	|	|	|	|	|Disaster Recovery Planning / Implementation	|	|	|	|1	|1	|2	|2	|
|	|	|	|	|	|Auth Implemetation	|	|	|	|0	|1	|2	|2	|
|33%	|Feature Testing	|	|	|	|	|	|2	|2	|
|33%	|Integrate with Existing Systems	|	|	|	|	|	|	|	|
|67%	|UAT	|	|	|	|	|	|	|	|
|67%	|P-UAT	|	|	|	|	|	|	|	|
|33%	|ORR / Go-No Go	|	|	|	|	|	|	|	|
|67%	|Deploy	|	|	|	|	|	|	|	|
|33%	|Hypercare	|	|	|	|	|	|	|	|
|17%	|Post Deployment Monitoring	|	|	|	|	|	|	|	|
|17%	|Project RetroSpective / Lesson Learned	|1	|1	|1	|1	|1	|1	|1	|
|TTC (Weeks)	|2	|3	|8	|16	|39	|75	|96	|
|TTC (Years)	|0.25	|0.25	|0.25	|0.5	|0.75	|1.5	|2	|
|Standard Project Items SDE (Weeks)	|0	|0	|5	|14	|22	|42	|48	|
|Project Specific Items SDE (Weeks)	|11	|22	|22	|25	|130	|228	|300	|
|Total SDE (Weeks)	|11	|22	|27	|39	|152	|270	|348	|
|Post Deployment SDE Weeks	|1	|1	|1	|1	|1	|1	|1	|

## Sub Project Estimates

|6	|Step	|XS	|S	|M	|L	|XL	|XXL	|XXXL	|
|---	|---	|---	|---	|---	|---	|---	|---	|---	|
|	|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|	|	|	|
|33%	|LLD	|0	|1	|2	|2	|2	|4	|6	|
|67%	|Infrastructure 	|	|	|	|	|	|	|	|
|	|	|	|	|	|	|Pipeline Set-up	|	|	|	|	|	|	|	|
|	|	|	|	|	|Environment Set-up	|0	|0	|0	|1	|2	|2	|6	|
|	|	|	|	|	|Monitoring and Alerting Set-up	|0	|0	|0	|0	|0	|2	|2	|
|100%	|Code Changes	|	|	|	|	|	|	|	|
|	|	|100%	|	|	|	|New Feature Implementation	|2	|2	|2	|3	|4	|8	|24	|
|	|50%	|	|	|	|Refactoring Existing Code	|0	|0	|0	|1	|2	|2	|6	|
|	|50%	|	|	|	|Schema Updates	|0	|0	|0	|1	|2	|4	|6	|
|	|50%	|	|	|	|Data Migration Scripts	|0	|0	|0	|1	|2	|4	|6	|
|	|33%	|	|	|	|API Development	|0	|0	|0	|0	|2	|2	|4	|
|	|100%	|	|	|	|Dependency Updates	|0	|0	|0	|0	|2	|4	|6	|
|	|33%	|	|	|	|Feature Flag Implementation	|0	|0	|2	|1	|2	|2	|4	|
|	|100%	|	|	|	|Unit Testing	|0	|0	|0	|1	|1	|2	|5	|
|	|100%	|	|	|	|Integration Testing	|1	|1	|1	|1	|2	|3	|10	|
|	|100%	|	|	|	|End-to-end Functional Testing	|0	|0	|0	|1	|1	|2	|5	|
|50%	|Related Systems	|2	|2	|2	|2	|2	|8	|22	|
|33%	|Security	|0	|0	|0	|2	|2	|2	|4	|
|	|	|	|	|	|	|	|	|	|	|	|	|	|	|
|	|	|	|	|	|Disaster Recovery Planning / Implementation	|0	|0	|0	|2	|2	|2	|4	|
|	|	|	|	|	|	|	|	|	|	|	|	|	|
|33%	|Feature Testing	|0	|0	|0	|1	|2	|4	|6	|
|33%	|Integrate with Existing Systems	|0	|0	|2	|2	|2	|2	|4	|
|67%	|UAT	|0	|1	|2	|2	|2	|4	|4	|
|67%	|P-UAT	|1	|1	|2	|2	|2	|2	|6	|
|33%	|ORR / Go-No Go	|0	|0	|0	|1	|2	|4	|4	|
|67%	|Deploy	|0	|0	|1	|1	|2	|2	|4	|
|33%	|Hypercare	|0	|0	|0	|1	|2	|4	|4	|
|17%	|Post Deployment Monitoring	|0	|0	|0	|4	|8	|16	|16	|
|	|	|	|	|	|	|	|	|	|
|TTC (Weeks)	|6	|8	|16	|30	|48	|85	|156	|
|TTC (Years)	|0.25	|0.25	|0.5	|0.75	|1	|1.75	|3	|
|Standard Project Items SDE (Weeks)	|4	|10	|28	|36	|44	|64	|104	|
|Project Specific Items SDE (Weeks)	|26	|26	|30	|55	|100	|190	|468	|
|Total SDE (Weeks)	|30	|36	|58	|91	|144	|254	|572	|
|Post Deployment SDE Weeks	|0	|0	|0	|6	|12	|24	|24	|
|	|	|	|	|	|	|	|24	|36	|72	|144	|288	|396	|576	|
|	|	|	|	|	|	|	|6	|0	|-14	|-53	|-144	|-142	|-4	|
|	|	|	|	|	|	|	|3	|6	|12	|24	|48	|96	|192	|

# Line Item Definitions

## **PR (Press Release)**

Press releases are typically a specific format and style, following established guidelines and standard practices for communication within Amazon. The PR includes key details such as the headline, dateline, introductory paragraph, body content, quotes from relevant individuals, and contact information for additional inquiries.

The purpose of a press release is to generate a specific vision that all teams and stakeholders align on. The PR will inform the decisions and guidelines for making decisions as the project progresses. This alignment may occur before the BRD, or before project development.

## **FAQ (Frequently Asked Questions)**

FAQ stands for "Frequently Asked Questions," and refers to a compiled list of common questions and their corresponding answers related to a specific product, service, topic, or organization.

FAQs are designed to provide users, customers, or stakeholders with access to information regarding common questions, features, processes, or concerns. They serve as a resource, allowing individuals to find answers to their questions without the need for direct assistance or support.

Well-crafted FAQs improve stakeholder satisfaction by addressing common pain points or inquiries upfront, reducing the workload on support teams and facilitating early problem-solving. Additionally, FAQs help onboard new users or customers by providing comprehensive information regarding the product or service in a concise and accessible format.

## **HLD**

HLD stands for "High-Level Design," which is a comprehensive overview of the architecture, components, and interactions within a software system or application.

The reason an HLD is needed is to provide a clear understanding of the system's structure, design principles, and key components before diving into the detailed implementation. An HLD serves as a blueprint for the development team, ensuring that everyone is aligned on the system's architecture and design decisions.

The benefit of having an HLD is that it facilitates communication and collaboration among stakeholders, developers, and architects. The HLD helps identify potential issues or risks early in the development process, allowing for timely adjustments or refinements to the design.


## **OP1**

OP1 typically stands for "Operational Readiness Phase 1," which is a stage in the project lifecycle where the focus is on preparing the operational processes, getting alignment from stakeholders, and getting approval from dependencies. The OP1 cycle is necessary for the successful deployment and operation of the software system.

The benefit of having an OP1 phase is a reduction in the likelihood of operational issues or downtime during the initial development, deployment, and subsequent maintenance phases. The OP1 planning helps identify and address potential bottlenecks or limitations in the infrastructure or operational processes before they escalate to blocking issues.

### **Cross-Functional Team Alignment**

Cross-Functional Team Alignment refers to the process of ensuring that all teams involved in a project, such as development, operations, security, and business stakeholders, are aligned on the project goals, requirements, and priorities.

The reason Cross-Functional Team Alignment is needed is to facilitate collaboration and communication among different teams with diverse expertise and responsibilities. This portion of the OP1 planning helps ensure that everyone is working towards the same objectives and that potential conflicts or misunderstandings are addressed early on.

The benefit of Cross-Functional Team Alignment is promoting a shared understanding of the project's requirements, reduces silos, and fosters a collaborative environment. This leads to better decision-making, faster issue resolution, and improved overall project outcomes. Cross-Functional teams include Away teams, Code-bases in which Away Team work is completed, or dependencies. Clarifying that all Cross-Functional Teams are aligned before starting work on a project prevents future discrepancies.

### **Cross-Functional Team Joint Application Design**

Cross-Functional Team Joint Application Design (JAD) is a structured process where representatives from different teams (e.g., development, operations, security, business) collaborate to design and refine the application's architecture, features, and requirements.

The reason JAD is needed is to ensure that the application design considers the perspectives and requirements of all stakeholders involved. The JAD helps identify potential issues, constraints, or dependencies early in the design phase, allowing for timely adjustments or refinements.

The benefit of Cross-Functional Team JAD is that promoting a holistic and comprehensive approach to application design, considering diverse perspectives and expertise. This leads to a robust and well-rounded design that addresses the needs of different stakeholders, reducing the likelihood of issues or rework later in the project.


### **Cross-Functional Team Approval**

Cross-Functional Team Approval refers to the process of obtaining formal approval or sign-off from representatives of different teams involved in the project, such as development, operations, security, and business stakeholders.

The reason Cross-Functional Team Approval is needed is to ensure that all teams have reviewed and agreed upon the project's requirements, design, or implementation plans before proceeding to the next phase. This helps mitigate risks and ensures that potential concerns or issues are addressed before beginning the process.

The benefit of Cross-Functional Team Approval is promoting accountability and shared ownership among the teams involved. Cross-Functional Team Approval helps ensure that the project aligns with the organization's policies, standards, and practices across different domains, reducing the likelihood of issues or rework later in the project.

## **Infrastructure**

Infrastructure refers to the underlying hardware, software, and network components that support the deployment and operation of a software system or application.

The reason infrastructure is needed is to provide the necessary computing resources, storage, networking, and other services required for the application to run and be accessible to users or customers.

The benefit of having a well-designed and scalable infrastructure is an insurance of the application to handle the expected load, provide dependable performance, and meet the required availability and security standards. Additionally, a robust infrastructure facilitates maintenance, updates, and future growth or scaling of the application.

Components of the EPIC or HLD Infrastructure can be found here: [High-Level Design Initial Code Outline Tasks Template](https://quip-amazon.com/aMXxAXZzx6A2)
Components of the LLD Infrastructure can be found here: [Low-Level Design Coding Tasks Template](https://quip-amazon.com/DskSAalPPXU4)

### **Pipeline Set-up**

Pipeline Set-up refers to the process of configuring and implementing a continuous integration and continuous deployment (CI/CD) pipeline for the software project.

The reason a pipeline is needed is to automate the build, testing, and deployment processes, ensuring consistent delivery of the application. A well-configured pipeline reduces manual effort, minimize human errors, and allows faster and more frequent deployments.

The benefit of having a properly set-up pipeline is streamlining the software delivery process, improves code quality through automated testing, and enables rapid feedback and iteration. Additionally, a pipeline facilitates rollbacks and rollouts, reducing the risk and downtime associated with deployments.

### **Environment Set-up**

Environment Set-up refers to the process of provisioning and configuring the various environments (development, testing, staging, production) required for the software project.

The reason environment set-up is needed is to provide isolated and controlled environments for different stages of the development and testing process. This helps ensure that changes or experiments in one environment do not impact other environments, reducing the risk of issues or conflicts.

The benefit of having properly set-up environments is allowing parallel development and testing activities, facilitating debugging and troubleshooting, and helping maintain separation of concerns between different stages of the software delivery process. Additionally, proper environment set-up allows for realistic testing and validation of the application in environments that closely resemble the production environment.

### **Monitoring and Alerting Set-up**

Monitoring and Alerting Set-up refers to the process of implementing tools and processes for monitoring the performance, health, and availability of the software system or application, and configuring alerts to notify the appropriate teams or individuals when issues or anomalies are detected.

The reason monitoring and alerting set-up is needed is to ensure that the application's performance, security, and reliability are continuously monitored, and any issues or incidents are promptly detected and addressed. Effective monitoring and alerting helps prevent or mitigate potential outages, performance degradation, or security breaches.

The benefit of having a well-configured monitoring and alerting system is providing visibility into the application's behavior and health, allowing proactive issue resolution and reducing the mean time to detect and resolve incidents. Additionally, monitoring data provides valuable insights for capacity planning, performance optimization, and identifying potential bottlenecks or areas for improvement.


## **Code Changes**

Code Changes refer to modifications or additions to the codebase of the software project, typically to implement new features, fix bugs, or refactor existing code.

Code changes are an essential part of the software development lifecycle, as they allow the application to evolve and adapt to changing requirements, user needs, or technological advancements. Additionally, well-documented and tested code changes improve code maintainability and reduce the risk of introducing new bugs or regressions.

### **New Feature Implementation**

New Feature Implementation refers to the process of designing, developing, and integrating new functionality or capabilities into the existing software application.


### **Refactoring Existing Code**

Refactoring Existing Code refers to the process of restructuring or reorganizing existing code without changing its external behavior or functionality.

The reason refactoring is needed is to improve the code's internal structure, readability, maintainability, and performance. Over time, as new features are added or changes are made, code becomes complex, duplicated, or difficult to understand, which hinders future development efforts and increases the risk of introducing bugs.

The benefit of refactoring existing code is that it improves code quality, reduces technical debt, and makes the codebase extensible and easier to work with. Additionally, refactoring facilitates integration of new features, improving performance, and reducing the likelihood of introducing bugs or regressions when making future changes.

### **Schema Updates**

Schema Updates refer to changes to the structure or definition of the database schema used by the software application.

The reason schema updates are needed is to accommodate new or modified data requirements, such as adding new tables, columns, or relationships, or modifying existing data types or constraints. Schema updates are necessary when introducing new features or changing the application's data model.

The benefit of properly managing and running schema updates is ensuring data integrity and consistency, minimizing the risk of data loss or corruption, and facilitating seamless migration of existing data to the new schema structure. Additionally, well-planned and tested schema updates improve database performance, scalability, and maintainability.

### **Data Migration Scripts**

Data Migration Scripts refer to the scripts or programs used to transfer or transform data from one system or format to another, typically during the process of upgrading or migrating to a new software application or database schema.

The reason data migration scripts are needed is to ensure that existing data is properly migrated and preserved when transitioning to a new system or schema. Data migration is an essential step in software upgrades or migrations, as this step ensures that valuable data is not lost and that the new system operate with the existing data.

The benefit of having well-designed and tested data migration scripts is the minimization of data loss, ensure data integrity and consistency, and facilitating a smooth transition to the new system or schema. Additionally, automated data migration scripts reduce manual effort, improve accuracy, and allow repeatable and consistent data migrations across different environments or instances.

### **API Development**

API Development refers to the process of designing, implementing, and exposing Application Programming Interfaces (APIs) that allow different software systems or applications to communicate and exchange data with each other.

The reason API development is needed is to facilitate integration and interoperability between different systems, services, or applications. APIs provide a standardized and controlled way for external systems or clients to interact with the application's functionality or data, allowing a modular and scalable architecture.

The benefit of well-designed and documented APIs is that they promote reusability, allowing integrations or ecosystem development, and facilitating maintenance and evolution of the application. Additionally, APIs help decouple different components or services, improving flexibility and allowing independent scaling or deployment of different parts of the system.

### **Dependency Updates**

Dependency Updates refer to the process of updating or upgrading the third-party libraries, frameworks, or packages that the software application depends on or utilizes.

The reason dependency updates are needed is to ensure that the application benefits from the latest bug fixes, security patches, performance improvements, or new features provided by the upstream dependencies. Keeping dependencies up-to-date is important for maintaining the security, stability, and compatibility of the application.

The benefit of regularly updating dependencies is improving the application's security posture by addressing foreseeable vulnerabilities, enhancing performance and efficiency by taking benefit from optimizations or improvements in the dependencies, and allowing access to new features or capabilities that are required for future development or enhancements.

### **Feature Flag Implementation**

Feature Flag Implementation refers to the practice of introducing new features or functionality in the codebase in a controlled and selective manner, using feature flags or toggles.

The reason feature flag implementation is needed is to allow gradual rollouts, canary releases, or A/B testing of new features without impacting the user base or application. Feature flags allow new functionality to be selectively allowed or removed for specific users, environments, or scenarios, reducing the risk of widespread issues or outages.

The benefit of using feature flags is that they provide control and flexibility in the release and deployment process, allowing safer, controlled rollouts of new features. Feature flags facilitate rollbacks or removal of problematic features, and allow experimentation and data-driven decision-making based on user feedback or metrics.

### **Unit Testing**

Unit Testing refers to the process of writing and running automated tests that verify the correctness and behavior of individual units or components of the software application, such as functions, methods, or classes.

The reason unit testing is needed is to ensure that individual units of code work as expected and meet the specified requirements or specifications. Unit tests help catch bugs or regressions early in the development process, before they propagate to larger components of the application.

The benefit of having comprehensive and well-designed unit tests is that they improve code quality, reduce the likelihood of introducing bugs or regressions, and facilitate refactoring or maintenance of the codebase. Additionally, unit tests serve as documentation and examples of how individual units of code will behave, aiding in knowledge transfer and onboarding of new team members.

### **Integration Testing**

Integration Testing refers to the process of testing the interactions and communication between different components, dependencies, or subsystems of the software application to ensure they work together correctly and as expected.

The reason integration testing is needed is to verify that the individual components or units of the application are successfully integrated and function correctly when combined or interacting with each other. Integration testing helps identify issues or incompatibilities that arise due to dependencies, interfaces, or data flows between different parts of the system.

The benefit of performing thorough integration testing is that catching integration-related issues or defects that are not apparent when testing individual components in isolation. Additionally, integration testing helps ensure that the application meets end-to-end functional requirements and handles real-world scenarios involving multiple components or subsystems working together.

### **End-to-end Functional Testing**

End-to-end Functional Testing refers to the process of testing the software application from start to finish, simulating real-world user scenarios and verifying that the application meets the specified functional requirements and behaves as expected.

The reason end-to-end functional testing is needed is to ensure that the application works correctly and provides the intended functionality when all components and subsystems are integrated and working together. This type of testing helps identify issues or defects that arise due to interactions, data flows, or dependencies across the application.

The benefit of conducting end-to-end functional testing is providing a comprehensive validation of the application's functionality, usability, and overall user experience. End-to-end testing helps uncover issues related to performance, scalability, or compatibility that are not apparent when testing individual components or subsystems in isolation.

## **Related Systems**

Related Systems refer to other software applications, services, or systems that the application being developed or deployed needs to interact with or integrate with.

The reason related systems are taken into consideration is to ensure that the application successfully communicates, exchanges data, or coordinates with these external systems as required. Failure to account for related systems leads to integration issues, data inconsistencies, or functionality gaps in the application.

The benefit of properly identifying and accounting for related systems is allowing a comprehensive and holistic approach to application design, development, and testing. By considering related systems early in the project, potential integration challenges or dependencies are addressed proactively, reducing the risk of issues or delays during deployment or operation.

## **Security**

Security refers to the measures, controls, and practices implemented to protect the software application, its data, and the underlying infrastructure from unauthorized access, misuse, or malicious attacks.

The reason security is needed is to ensure the confidentiality, integrity, and availability of the application and its data, and to comply with relevant security standards, regulations, or industry standard practices. Failure to properly address security exposes the application and its users to risks, such as data breaches, system compromises, or denial-of-service attacks.

The benefit of implementing robust security measures is protecting the application and its users from potential threats, maintaining user trust and confidence, and helping avoid data breaches or security incidents. Additionally, strong security practices enhance the application's reputation, facilitate compliance with regulatory requirements, and reduce the risk of legal or financial liabilities.

### **Amazon Security Review**

An Amazon Security Review refers to the process of having the security posture, controls, and practices of a software application or system reviewed and assessed by Amazon's security teams or experts.

The reason an Amazon Security Review is needed is to ensure that applications or systems hosted on Amazon Web Services (AWS) meet the required security standards and standard practices at Amazon. This review helps identify potential security vulnerabilities, misconfigurations, or areas for improvement in the application's security posture.


### **Disaster Recovery Planning / Implementation**


Disaster Recovery Planning and Implementation refer to the processes and measures in place to ensure the continuity of business operations and the recovery of critical systems, applications, and data in the event of a disaster or disruptive event, cyber-attacks, or system failures.

The reason disaster-recovery planning and implementation are needed is to minimize the potential impact of disruptive events on the organization's operations, protect against data loss, and ensure that systems and applications are restored and online within acceptable timeframes.

Items including Recovery point objective (RPO) and recovery time objective (RTO) are metrics that help organizations plan for disaster recovery and business continuity. RPO and RTO are important for understanding how much data can be lost and how long that data will take to recover.

### **Auth Implementation**

Auth Implementation refers to the process of implementing authentication and authorization mechanisms within a software application to control and manage user access, permissions, and privileges.

The reason auth implementation is needed is to ensure that authorized users or systems access the application's resources and functionality, and that their actions are restricted based on their assigned roles or permissions. Proper authentication and authorization are crucial for maintaining the security and integrity of the application and its data.

The benefit of implementing robust authentication and authorization mechanisms is preventing unauthorized access, protecting sensitive data and functionality, and ensure that users or systems have access to the resources they are authorized to access. Additionally, proper auth implementation facilitates compliance with security standards, regulations, or industry standard practices related to access control and data protection.


## **Feature Testing**

Feature Testing refers to the process of testing and validating the functionality and behavior of specific features or components within a software application.

The reason feature testing is needed is to ensure that individual features or components meet the specified requirements, function correctly, and provide the intended user experience. Feature testing helps identify defects, issues, or inconsistencies related to the implementation or integration of specific features before they are released or deployed to production.

The benefit of conducting thorough feature testing is improving the overall quality and reliability of the application by catching and resolving issues related to individual features early in the development process. Additionally, feature testing provides valuable feedback and insights for refining or enhancing the functionality and user experience of specific features.


## **Integrate with Existing Systems**

Integrating with Existing Systems refers to the process of allowing the software application being developed or deployed to communicate, exchange data, or interact with other existing systems or applications within the organization or ecosystem.

The reason integration with existing systems is needed is to ensure that the new application seamlessly operates and shares data or functionality with other systems that are in use. Failure to properly integrate with existing systems leads to data silos, redundant efforts, or functionality gaps within the organization's overall technology landscape.

The benefit of successfully integrating with existing systems is that promoting data consistency, allowing end-to-end business processes, and facilitating collaboration and information sharing across different systems and teams. Additionally, integration helps take benefit from existing investments in technology and infrastructure, reducing the need for redundant or duplicated systems.

## **UAT**

UAT stands for User Acceptance Testing, which is a type of testing performed by end-users or representatives of the business stakeholders to validate that the software application meets the specified requirements and functions as expected from a user perspective.

The reason UAT is needed is to ensure that the application is fit for purpose and meets the actual needs and expectations of the end-users or stakeholders. UAT provides an opportunity for users to test the application in a realistic environment and provide feedback on its usability, functionality, and overall user experience.

The benefit of conducting thorough UAT is to identify any remaining issues, gaps, or misalignment between the application and the user requirements before the application is released or deployed to production. Additionally, UAT helps build user confidence and acceptance of the application, and facilitate user training and documentation efforts.

## **P-UAT** **(Post UAT Bug Fixes)**

P-UAT stands for "Post User Acceptance Testing Bug Fixes," and refers to the process of addressing and resolving any defects, issues, or bugs that are identified during the User Acceptance Testing (UAT) phase of a software development project.

User Acceptance Testing (UAT) is a crucial step in the software development lifecycle, where end-users or representatives of the business stakeholders validate that the application meets the specified requirements and functions as expected from a user perspective.

During UAT, testers uncover bugs, defects, or inconsistencies in the application's functionality, usability, or behavior. These identified issues are addressed and fixed before the application is ready for deployment or release.

The P-UAT phase involves developers or quality assurance teams working to resolve the reported bugs or issues, ensuring that the application meets the acceptance criteria and is fully functional. This phase is essential to ensure that the product delivered to end-users or customers is of high quality and meets the expected standards.

## **ORR / Go-No Go**

ORR stands for Operational Readiness Review, and Go-No Go refers to the decision-making process of determining whether the software application is ready for deployment to production or if actions or remediation are required.

The reason an ORR and Go-No Go process are needed is to ensure that all checks, and validations have completed before deploying the application to a production environment. This includes verifying that the application meets functional, non-functional, and operational requirements, and ensuring that the necessary infrastructure, monitoring, and support processes are in place.

The benefit of conducting an ORR and Go-No Go process is helping to mitigate the risk of deploying an application that is not fully ready for production, which leads to outages, performance issues, or other operational problems. Additionally, the ORR and Go-No Go process provides a structured and documented approach to deployment decision-making, promoting accountability and transparency among stakeholders.

## **Deploy**

Deploy refers to the process of releasing and making the software application available in a production environment, accessed and used by end-users or customers.

The reason deployment is needed is to make the application's functionality and features available to the intended users or customers, allowing them to derive value from the application and achieve their desired outcomes or objectives.

The benefit of a well-planned and run deployment process is minimized downtime, reduced risk of issues or disruptions, and ensuring a smooth transition from the development or staging environments to production. Additionally, a structured deployment process facilitates rollbacks or rollouts, allowing phased or canary releases, and providing visibility and control over the deployment activities.

## **Hypercare**

Hypercare refers to an intensive support and monitoring period immediately following the deployment of a software application to a production environment.

The reason hypercare is needed is to ensure that the application is closely monitored and any issues or incidents that arise during the initial production rollout are promptly detected and addressed. Hypercare helps mitigate the risk of prolonged outages, performance degradation, or other operational problems that impact end-users or customers.

The benefit of implementing a hypercare period is providing dedicated resources and heightened vigilance during the critical initial phase of production deployment, when the application is vulnerable to unforeseen issues or unexpected behavior. Hypercare helps build confidence in the application's stability and reliability, and facilitate knowledge transfer and handover to the ongoing support and operations teams.

## **Post Deployment Monitoring**

Post Deployment Monitoring refers to the ongoing monitoring and observation of the software application's performance, behavior, and health after deployment to a production environment.

The reason post deployment monitoring is needed is to ensure that the application continues to function as expected, meets performance and availability requirements, and any issues or anomalies are promptly detected and addressed. Continuous monitoring is crucial for maintaining the application's stability, reliability, and overall user experience.

The benefit of implementing robust post deployment monitoring is helping identify potential issues or bottlenecks before they escalate into major incidents or outages, allowing proactive remediation and minimizing the impact on end-users or customers. Monitoring data and insights informs capacity planning, performance optimization, and future application enhancements or upgrades.

## **Project Retrospective / Lesson Learned**

A Project Retrospective, or a Lessons Learned session, is a structured review and reflection process conducted at the end of a project or major milestone to identify areas of success, challenges faced, and opportunities for improvement.

The reason project retrospectives and lessons learned sessions are needed is to capture and document the experiences, insights, and knowledge gained during the project, allowing continuous learning and improvement for future projects or initiatives.

The benefit of conducting project retrospectives and lessons learned sessions is that they help teams and organizations identify standard practices, areas for process optimization, and potential areas of risk that will be addressed in future projects. Additionally, these sessions foster a culture of continuous improvement, knowledge sharing, and accountability, ultimately leading to efficient and successful project delivery.

# Standard Project Risks

1. Change in Requirements: Stakeholders may request significant changes to the product's features or functionality after development has already begun, necessitating rework and potentially delaying the project timeline.
2. Integration Issues: Challenges may arise when integrating the new system or components with existing systems, third-party services, or legacy code, leading to compatibility problems and potential delays.
3. Technical Debt Causing Delays: Accumulated technical debt, such as poorly written code, lack of documentation, or architectural flaws, may slow down development progress and hinder the team's ability to deliver new features or enhancements efficiently.
4. Scalability Challenges: As the user base or data volume grows, the system may face performance issues or fail to scale effectively, requiring architectural changes or additional infrastructure investment.
5. Tooling Challenges: Difficulties in setting up, configuring, or using the required development tools, build systems, or deployment pipelines may cause delays and frustration among the team members.
6. Data Decoding/Access Issues: Challenges in decoding or accessing data from legacy systems, databases, or external sources may arise, hindering data migration or integration efforts and potentially delaying project milestones.
7. API Contract Misalignment: Inconsistencies or misunderstandings between the expected and actual behavior of external APIs or services may lead to integration issues, requiring rework or workarounds.
8. Third-Party Service Changes: Changes or updates to third-party services or APIs that the system relies on may necessitate code modifications, testing, and potential delays to ensure compatibility.
9. Data Migration Issues: Challenges in migrating data from legacy systems or databases to the new system may arise, such as data quality issues, format incompatibilities, or performance bottlenecks, potentially delaying the project's completion.
10. Authentication or Authorization Failures: Inadequate or flawed implementation of authentication and authorization mechanisms may lead to security vulnerabilities, compliance issues, or system access problems, requiring rework and potentially delaying the project.
11. Dependency on Deprecated Libraries: Reliance on outdated or deprecated third-party libraries or frameworks may introduce security risks, compatibility issues, or lack of support, necessitating library upgrades or replacements, which can be time-consuming and disruptive.
12. Performance Bottleneck: Inefficient code, inadequate hardware resources, or architectural flaws may lead to performance issues, such as slow response times or system bottlenecks, requiring optimization efforts or infrastructure upgrades.
13. Environment Configuration and Deployment Failures: Challenges in setting up and configuring development, testing, or production environments, or issues with the deployment process, may cause delays and frustration among team members.
14. Insufficient Existing Test Coverage: Lack of comprehensive test suites or inadequate testing practices for existing code or systems may hinder the team's ability to confidently make changes or additions, potentially leading to regressions, bugs, or delays.

# Project Sizing Rubric

#### **XXS (Extra Extra Small)**

* **Documentation Requirements:** None
* **Design Requirements:** None
* **Infrastructure Requirements:** None
* **Dependencies:** None
* **Security Concerns:** None

#### **XS (Extra Small)**

Time to Complete (2 pizza team) = .5y
SDE-Weeks = 70
Tasks: 133
HC (normalized for 1 year) = 1.5

* **Documentation Requirements:** None (No PR/FAQ)
* **Design Requirements:** None (No High-Level Design, No Low-Level Design)
* **Infrastructure Requirements:** None
* **Dependencies:** None
* **Security Concerns:** None

#### **S (Small)**

Time to Complete (2 pizza team) = 1.5y
SDE-Weeks = 179
Tasks: 340
HC (normalized for 1 year) = 3.5

* **Documentation Requirements:** None (No PR/FAQ)
* **Design Requirements:** Low-Level Design required
* **Infrastructure Requirements:** Small changes to existing systems
* **Dependencies:** Limited to existing systems with minor changes
* **Security Concerns:** None

#### **M (Medium)**

Time to Complete (2 pizza team) = 2.5y
SDE-Weeks = 230
Tasks: 437
HC (normalized for 1 year) = 4.5

* **Documentation Requirements:** PR/FAQ required
* **Design Requirements:** High-Level Design and Low-Level Design required for at least 2 phases
* **Infrastructure Requirements:** Moderate changes to existing systems
* **Dependencies:** Some dependencies within the immediate organization
* **Security Concerns:** Standard security considerations

#### **L (Large)**

Time to Complete (2 pizza team) = 3.25y
SDE-Weeks = 338
Tasks: 642
HC (normalized for 1 year) = 6.5

* **Documentation Requirements:** PR/FAQ required
* **Design Requirements:** High-Level Design and detailed Low-Level Design for multiple phases
* **Infrastructure Requirements:** Extensive infrastructure updates, possibly creation of a new service
* **Dependencies:** Limited external dependencies within the immediate organization
* **Security Concerns:** Comprehensive security reviews required

#### **XL (Extra Large)**

Time to Complete (2 pizza team) = 4.25y
SDE-Weeks = 414
Tasks: 787
HC (normalized for 1 year) = 8

* **Documentation Requirements:** Extensive Business Requirements, PR/FAQ required
* **Design Requirements:** High-Level Design and detailed Low-Level Design for all phases
* **Infrastructure Requirements:** Extensive infrastructure updates, including a new service
* **Dependencies:** Dependencies may extend outside the immediate organization
* **Security Concerns:** Extensive security considerations, including external audits

#### **XXL (Extra Extra Large)**

Time to Complete (2 pizza team) = 5.25
SDE-Weeks = 554
Tasks: 1053
HC (normalized for 1 year) = 11

* **Documentation Requirements:** Comprehensive Business Requirements, PR/FAQ required
* **Design Requirements:** High-Level Design and detailed Low-Level Design for all phases
* **Infrastructure Requirements:** Extensive infrastructure updates, creation of multiple new services
* **Dependencies:** Dependencies extend outside the immediate organization, possibly across multiple organizations
* **Security Concerns:** Extensive security considerations, including external audits and compliance requirements

## Project Timelines and Goals

Once per project:

1. PR:
    1. Finalization of Project Scope
    2. Deliverables: List of potential features and design concepts.
    3. Risks: Lack of consensus among stakeholders, unclear project objectives.
2. Research and Planning (FAQ):
    1. Completion of requirements gathering
    2. Finalization of project plan.
    3. Deliverables: Comprehensive project plan, including timelines, budgets, and resource allocation.
    4. Communication Plan: Regular updates to stakeholders on research findings and planning progress.
    5. Risks: Inaccurate estimation of resources or timelines, changing market conditions.
3. High Level Design: [min 175 pts → 700 hrs → 3 sprints]
    1. Completion of architectural diagrams
    2. Finalization of wireframes.
    3. Deliverables: High-level design (HLD) document, including architectural diagrams and wireframes.
    4. Communication Plan: Design review meetings with stakeholders for feedback and validation.
    5. Risks: Inadequate understanding of requirements, design mismatches with project objectives.
4. OP1/ticket requests, Security Review: 0-16w
    1. Submission of applications
    2. Receipt of approvals.
    3. Deliverables: Approved OP1 requests, intake requests, and documentation from relevant authorities.
    4. Communication Plan: Regular updates to stakeholders on OP1 application status.
    5. Risks: Delays in permit processing, unforeseen regulatory hurdles.

Once per phase:


1. Low Level Design:
2. Initial Code Outline and Infrastructure Development:
    1. Completion of codebase setup
    2. Database schema finalized.
    3. Deliverables: Initial codebase setup, database schema, and core infrastructure components.
    4. Goals: Establish the foundational structure of the software project.
    5. Risks: Incomplete understanding of system requirements, technical challenges.
3. Coding the actual features:
    1. Goals: Develop the core functionality of the software application.
    2. Risks: Scope creep, integration issues with external systems.
4. Modifying related systems to integrate properly:
    1. Goals: Ensure proper integration and functionality of related systems.
5. Security and Error Handling:
    1. Goals: Enhance the security and robustness of the software application.
6. Feature Testing and Bug Fixes:
    1. Risks: Undiscovered bugs, user dissatisfaction with features.
7. Integrate with Related Systems:
    1. Risks: API changes, data format inconsistencies.
8. UAT Testing:
    1. Communication Plan: Daily UAT progress updates to stakeholders.
    2. Risks: Undiscovered defects, lack of user involvement in testing.
9. Post-UAT Bug Fixes:
    1. Closure of all UAT-reported issues
    2. Final sign-off from stakeholders.
    3. Goals: Address any remaining bugs or issues identified during UAT testing.
    4. Communication Plan: Regular updates on bug fix progress to stakeholders.
    5. Risks: Scope creep, regression of previously fixed issues.
10. Deploy / Report Blue in MTR:
    1. Goals: Formalize project closure and document lessons learned for future reference.
11. **Post-Deployment Clean-up and OE**


Number of Tasks = 1.9*SDE Weeks
