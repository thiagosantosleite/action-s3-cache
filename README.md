# S3 Cache for GitHub Actions
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/leroy-merlin-br/action-s3-cache/Build%20and%20publish?style=flat-square) ![GitHub go.mod Go version](https://img.shields.io/github/go-mod/go-version/leroy-merlin-br/action-s3-cache?style=flat-square) ![Codacy grade](https://img.shields.io/codacy/grade/71fc49e81b654ddfa1379a2c50f6ea8a?style=flat-square)

GitHub Action that allows you to cache build artifacts to S3

It is a fork from [leroy-merlin-br/action-s3-cache]https://github.com/leroy-merlin-br/action-s3-cache.
Changes:
- Use tar and untar instead of zip
- Upgrade golang version

## Prerequisites
- An AWS account. [Sign up here](https://aws.amazon.com/pt/resources/create-account/).

## Usage


### Archiving artifacts

```yml
- name: Save cache
  uses: everest/action-s3-cache@v2
  with:
    action: put
    aws-region: us-east-1 # Or whatever region your bucket was created
    bucket: your-bucket
    key: ${{ hashFiles('yarn.lock') }}
    artifacts: |
      node_modules*
```

### Retrieving artifacts

```yml
- name: Retrieve cache
  uses: everest/action-s3-cache@v2
  with:
    action: get
    aws-region: us-east-1
    bucket: your-bucket
    key: ${{ hashFiles('yarn.lock') }}
```

### Clear cache

```yml
- name: Clear cache
  uses: everest/action-s3-cache@v2
  with:
    action: delete
    aws-region: us-east-1
    bucket: your-bucket
    key: ${{ hashFiles('yarn.lock') }}
```

## Example

The following example shows a simple pipeline using S3 Cache GitHub Action:


```yml
- name: Checkout
  uses: actions/checkout@v2

- name: Retrieve cache
  uses: everest/action-s3-cache@v2
  with:
    action: get
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-region: us-east-1
    bucket: your-bucket
    key: ${{ hashFiles('yarn.lock') }}

- name: Install dependencies
  run: yarn

- name: Save cache
  uses: everest/action-s3-cache@v2
  with:
    action: put
    aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
    aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    aws-region: us-east-1
    bucket: your-bucket
    s3-class: STANDARD_IA
    key: ${{ hashFiles('yarn.lock') }}
    artifacts: |
      node_modules/*
```

## Deploy a new version for linux

- Build the binary 
```
env GOOS=linux GOARCH=amd64 go build -o dist/linux
```

- Push the binary and changes to github

- Usually is required to update the branch or create a new branch

