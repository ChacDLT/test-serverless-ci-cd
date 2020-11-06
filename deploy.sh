#!/usr/bin/env bash

## Process arguments
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --accessKeyId)
            accessKeyId="$2"
            shift
            ;;
        --secretAccessKey)
            secretAccessKey="$2"
            shift
            ;;
        --stage)
            stage="$2"
            shift
            ;;
        --region)
            region="$2"
            shift
            ;;
        --awsProfile)
            awsProfile="$2"
            shift
            ;;
        *)
            ;;
    esac

    shift
done

#  Build Frontend
echo "Building Frontend"
yarn install

case $stage in
    testing|staging|production) yarn build:$stage;;
    *) yarn build;;
esac

# Deploy Build Site
echo "Deploying Frontend"
npx serverless client deploy --stage $stage --region $region `if [ -n "$awsProfile" ]; then echo "--aws-profile $awsProfile"; fi` --no-confirm