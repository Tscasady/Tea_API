# Tea API

## Project Description
   
#### Overview

This project is a simple RESTful BackEnd for a hypothetical Tea Shop, where customers can subscribe to a tea and recieve regular shipments of that product. It exposes three endpoints, allowing a user to update a customer's subscripitions, change the status of those subscriptions, and retrieve a list of all subscriptions that customer has.

The goal of this project was to demonstrate an ability to quickly complete a 'take-home' style assignment, focusing on project presentation, organization and completion in a timely manner, rather producing a technically rigorous project. 

   
   
## Getting Started

### Installation
   
1. Fork the Repo from the [Repository](https://github.com/Tscasady/Tea_API)
2. Clone the repo
   ```sh
   git@github.com:Tscasady/Tea_API.git
   ```
3. Install packages
   ```sh
   bundle install
   ```
4. Set up the database
   ```sh
   rails db:{create, migrate, seed} 
5. Start up the server
   ```sh
   rails server
   ```
   
# RESTful Endpoints
A collection of endpoints exposed on this API with example requests and responses.

### POST a Subscription


```http
POST /api/v1/customers/:customer_id/subscriptions
```

<details>
<summary>Example</summary>
<br>
    

| Code | Description |
| :--- | :--- |
| 201 | `Created` |

Example Request Body: 
   
```json
{
    "tea_id": 1,
    "title": "Green Tea Subscription",
    "price": 5.00,
    "frequency": 2
}
```   
   
Example Response:   

```json

{
    "data": {
        "id": "9",
        "type": "subscription",
        "attributes": {
            "tea_id": 1,
            "customer_id": 1,
            "title": "Green Tea Subscription",
            "price": 5,
            "status": "active",
            "frequency": 2
        }
    }
}
```

</details>

---   

### Get All of a Customer's Subscriptions


```http
GET /api/v1/customers/:customer_id/subscriptions
```

<details>
<summary>Example</summary>
<br>
    

| Code | Description |
| :--- | :--- |
| 200 | `Ok` |

 
Example Response:   

```json
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "tea_id": 1,
                "customer_id": 1,
                "title": null,
                "price": 5,
                "status": "active",
                "frequency": 1
            }
        },
        {
            "id": "9",
            "type": "subscription",
            "attributes": {
                "tea_id": 1,
                "customer_id": 1,
                "title": "Green Tea Subscription",
                "price": 5,
                "status": "active",
                "frequency": 2
            }
        }
    ]
}
```

</details>

---
   ### Cancel a Subscription


```http
PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id
```

<details>
<summary>Example</summary>
<br>
    

| Code | Description |
| :--- | :--- |
| 200 | `Ok` |
   
Example Response:   

```json

{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "tea_id": 1,
            "customer_id": 1,
            "title": null,
            "price": 5,
            "status": "cancelled",
            "frequency": 1
        }
    }
}
```

</details>

---

### Error Example

```http
GET /api/v1/customers/123123123/subscriptions
```

<details>
<summary>Example</summary>
<br>
    

| Code | Description |
| :--- | :--- |
| 404 | `Not Found` |

   
Example Response:   

```json

{
    "message": "Record not Found",
    "errors": [
        {
            "detail": "Couldn't find Customer with 'id'=123123123",
            "status": "not_found"
        }
    ]
}
```

</details>

---
    
<br>
<br>
