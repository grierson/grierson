# Storage

## Simple Storage Service (S3)

Store file as object in buckets
Stores data across multiple availability zones
Access files by URL
Static web host

- Standard - Frequent access data
- Standard-Infrequent Access - Many AZs
- One Zone-Infrequent Access - One AZ (Cheaper)
- Intelligent tiering
  - Moves files between Standard and Infrequent Access (Cost saving)

Cons

- Fee for retrieval fee

## S3 Glacier

Cheaper files storage but longer read times

- 180 day minimum storage
- 23x cheaper than standard S3

## Elastic Block Store

Used for data backup

## Elastic File System

Fully managed Network File System which can be shared across multiple AZ's

## Snowball

Physical migrate petabytes of data from local data centre onto AWS server then
sent back to AWS to migrate it to S3

## Snowmobile

Snowball but a Shipping container and used for exabytes of data.
