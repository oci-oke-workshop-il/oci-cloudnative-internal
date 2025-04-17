###  LAB 9 – Create Alarms to Detect Unscheduled Pods

---

####  Task 1: Create an OCI Topic & Subscription for Email Notifications

1. Go to the **OCI Console** >> Search for **Notifications**

- Click on **Notifications** under the **Application Integration** section
- Create a **Topic** to handle alarm communications
- Add a **Subscription** using your email address to receive alerts

![Public Key Added](./../../images/screenshot/Lab9/1.png)

2.	Click Create topic and name it – **EmailsTopic** 

![Public Key Added](./../../images/screenshot/Lab9/2.png)

3.	Click on the created **topic > Select Create Subscription > Protocol Email > Email {Your-Email-Address} > Click Create**

![Public Key Added](./../../images/screenshot/Lab9/3.png)

4.	Go to your email inbox > Confirm the subscription.

![Public Key Added](./../../images/screenshot/Lab9/4.png)

5.	Validate Created Subscription in Active state

![Public Key Added](./../../images/screenshot/Lab9/5.png)

---

#### Task 2: Configure Alarm rule

 # The following alarm will generate a notification when the number of Kubernetes Nodes will be less than 3 Nodes which indicates a non-stable environment!

1.	Search for Alarm > click of Alarm Definitions under Monitoring

![Public Key Added](./../../images/screenshot/Lab9/6.png)

2.	Click Create Alarm: 

![Public Key Added](./../../images/screenshot/Lab9/7.png)

3.	Enter the following information:

- 	Alarm Name: `NODECONDITION`

![Public Key Added](./../../images/screenshot/Lab9/8.png)

- 	Metric Description:

  -    Compartment: `<Your-Compartment>` 
  -    Metric Namespace: `oci_oke`
  -    Metric name: `KubernetesNodeCondition`

  ![Public Key Added](./../../images/screenshot/Lab9/9.png)

- 	Metric dimensions:

  -	   Dimension name: `clustereId`
  -    Dimension value: `<OKE-Cluster-OCID>`
  -    NodePoolId: `leave blank`

  ![Public Key Added](./../../images/screenshot/Lab9/10.png)


- 	Trigger rule 1 Values:

   -    Operator: `Less than`
   -    Value: `3`
   -    Trigger `delay minutes: 1(default)`
   -    Alarm `severity: Critical`


 ![Public Key Added](./../../images/screenshot/Lab9/11.png)

-     Destination:
   -    Destination Service: `Notifications` 
   -    Compartment: `<Your-Compartment>`
   -    Topic: `EmailsTopic`

    ![Public Key Added](./../../images/screenshot/Lab9/12.png)

- **Click Save alarm**



---

#### Task 3: Trigger Alarm manually by stopping one of the nodes in the pool

1.	Navigate to Developer Services > Kubernetes Clusters (OKE) > Click Node Pools

![Public Key Added](./../../images/screenshot/Lab9/13.png)

2.	Click Pool Name  

![Public Key Added](./../../images/screenshot/Lab9/14.png)

3.	Click on one of the nodes > Click Stop   

![Public Key Added](./../../images/screenshot/Lab9/15.png)

4.	Go back to Alarm view to validate the system identify the false Node and trigger and Alarm 

![Public Key Added](./../../images/screenshot/Lab9/16.png)

5.	Validate Email notification service works correctly 

>> Go to the Email and validate the following email received:

   
![Public Key Added](./../../images/screenshot/Lab9/17.png)

