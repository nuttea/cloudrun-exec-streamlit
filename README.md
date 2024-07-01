# cloud-run-exec

## Test and Deploy

Deploy to Cloud Run

```bash
PROJECT_ID=nuttee-lab-00
REGION=us-central1
_APP_NAME=cloud-run-exec
_ENV=dev

gcloud run deploy ${_APP_NAME}-${_ENV} \
  --source . \
  --project ${PROJECT_ID} \
  --region ${REGION} \
  --platform managed \
  --allow-unauthenticated
```