**Describe the bug**  
Demo seems to be down / broken, when I try to login to the demo I get an invalid username / password combination message. checked devtools, network request returns a 400 error saying the password is invalid. It seem related to [#1293](https://github.com/IceWhaleTech/CasaOS/issues/1293), not only does shutdown work in the demo, update username and password does too.  
**To Reproduce**

* Go to: <https://casaos.io/>
* Click on the demo button
* Try to login to the demo with the given credentials:
* `Username:casaos`
* `Password:casaos `
* An error message is produced
* or login first then change the password and user 2 can no longer login using demo credentials  
**Expected behavior**  
Demo works & demo user account & / or password is not allowed to be changed.

**Screenshots**  
[![image](https://proxy-prod.omnivore-image-cache.app/0x0,s0b14X_B3gpQe6xmUjbXWR0l6zBm10D4ka48n0-aF0lQ/https://private-user-images.githubusercontent.com/1348086/278873175-3d477f6b-be21-483c-bfb7-c13467a539d5.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTc4MTg0MjYsIm5iZiI6MTcxNzgxODEyNiwicGF0aCI6Ii8xMzQ4MDg2LzI3ODg3MzE3NS0zZDQ3N2Y2Yi1iZTIxLTQ4M2MtYmZiNy1jMTM0NjdhNTM5ZDUucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI0MDYwOCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNDA2MDhUMDM0MjA2WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YTRmZDMxOTAwYjM4NGFlOTNmNTdhOTE3N2VjODMxMzY1ZjA3ZDFkMThjMzEzZjUyNTM1ZDQyZDM3ZDA5NDU5ZiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QmYWN0b3JfaWQ9MCZrZXlfaWQ9MCZyZXBvX2lkPTAifQ.vU5-p7PmTC3W5KWBuhdqhHUoK95neQb0lh6swsGIyXI)](https://private-user-images.githubusercontent.com/1348086/278873175-3d477f6b-be21-483c-bfb7-c13467a539d5.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTc4MTg0MjYsIm5iZiI6MTcxNzgxODEyNiwicGF0aCI6Ii8xMzQ4MDg2LzI3ODg3MzE3NS0zZDQ3N2Y2Yi1iZTIxLTQ4M2MtYmZiNy1jMTM0NjdhNTM5ZDUucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI0MDYwOCUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNDA2MDhUMDM0MjA2WiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9YTRmZDMxOTAwYjM4NGFlOTNmNTdhOTE3N2VjODMxMzY1ZjA3ZDFkMThjMzEzZjUyNTM1ZDQyZDM3ZDA5NDU5ZiZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QmYWN0b3JfaWQ9MCZrZXlfaWQ9MCZyZXBvX2lkPTAifQ.vU5-p7PmTC3W5KWBuhdqhHUoK95neQb0lh6swsGIyXI)  
**Desktop (please complete the following information):**

```yaml
 - OS: Ubuntu 22.04.3 LTS x86_64 
 - Browser Chrome
 - Version 118.0.5993.117

```

**System Time**

```yaml
Local time: Sun 2023-10-29 09:21:33 EDT
           Universal time: Sun 2023-10-29 13:21:33 UTC
                 RTC time: Sun 2023-10-29 13:21:33
                Time zone: America/New_York (EDT, -0400)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no


```