$gcp_region = "europe-north1"
$gcp_project = "terraform-learn-401417"
$gcp_repo = "go-hello"


function Deploy {
    param (
        [Parameter(Mandatory=$true)]
        [string]$gcp_region,
        [Parameter(Mandatory=$true)]
        [string]$gcp_project,
        [Parameter(Mandatory=$true)]
        [string]$gcp_repo
    )
    Write-Output "Deploying to $gcp_region, $gcp_project, $gcp_repo"

    gcloud artifacts repositories create $gcp_repo --repository-format=docker --location=$gcp_region --description="Docker repository" 

    docker build -t ${gcp_region}-docker.pkg.dev/${gcp_project}/$gcp_repo/go-hello-app:v1 .

    gcloud services enable artifactregistry.googleapis.com

    gcloud auth configure-docker ${gcp_region}-docker.pkg.dev

    docker push ${gcp_region}-docker.pkg.dev/${gcp_project}/$gcp_repo/go-hello-app:v1
    
}

Deploy -gcp_region $gcp_region -gcp_project $gcp_project -gcp_repo $gcp_repo



