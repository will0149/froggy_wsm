class MockDataUtils {
  Map<String, dynamic> authResponse() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": {
        "token":
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwMTMyODk3LCJpYXQiOjE3NTAxMjkyOTcsImp0aSI6ImJiNDI0ZDc5ZmQ2NDQ0NjNiYWY4MjgwMzY1NmFlNjMwIiwidXNlcl9pZCI6MX0.361ot8bEEl26IxK5NeOk-8D-OX8YpNRZlYJ3y5zheRWNyOLXwmC_NwE-0rh8slQlIik6XFr6HSz4Ubf6QOUFxg",
        "refresh_token":
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDczNDA5NywiaWF0IjoxNzUwMTI5Mjk3LCJqdGkiOiIzZWE4ZGE0OGNkNDc0NzM5OTRmN2EwNzZhMzhiNzI4ZiIsInVzZXJfaWQiOjF9.df82c7P54XCwa19R3-yMIXmwMaIQvSMTYyxvt0WzwWmQyhC9GmEuj_5pi0tt5PqrwHg42wwes-MhHLoNGRN4hQ"
      }
    };
  }

  Map<String, dynamic> refreshTokenResponse() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": {
        "refresh":
            "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDczNDA5NywiaWF0IjoxNzUwMTI5Mjk3LCJqdGkiOiIzZWE4ZGE0OGNkNDc0NzM5OTRmN2EwNzZhMzhiNzI4ZiIsInVzZXJfaWQiOjF9.df82c7P54XCwa19R3-yMIXmwMaIQvSMTYyxvt0WzwWmQyhC9GmEuj_5pi0tt5PqrwHg42wwes-MhHLoNGRN4hQ"
      }
    };
  }

  Map<String, dynamic> logoutResponse() {
    return {
      "status": {"code": 200, "msg": "exitoso!"}
    };
  }

  Map<String, dynamic> eventList() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": [
        {
          "id": 1,
          "owner": "john_doe",
          "banner_img":
              "https://numwo-media.s3.amazonaws.com/events/1/banner.jpg",
          "name": "Summer Music Festival 2025",
          "description":
              "Join us for an amazing outdoor music festival featuring local and international artists. Food trucks, craft beer, and family-friendly activities will be available throughout the day.",
          "short_description":
              "Annual outdoor music festival with live bands and food",
          "event_date": "2025-07-15T18:00:00Z",
          "cost_type": 1,
          "price": "45.00",
          "place":
              "Central Park Amphitheater, 123 Park Avenue, New York, NY 10001"
        }
      ]
    };
  }

  Map<String, dynamic> eventDetail() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": {
        "id": 1,
        "owner": "john_doe",
        "banner_img":
            "https://numwo-media.s3.amazonaws.com/events/1/banner.jpg",
        "name": "Summer Music Festival 2025",
        "description":
            "Join us for an amazing outdoor music festival featuring local and international artists. Food trucks, craft beer, and family-friendly activities will be available throughout the day.",
        "short_description":
            "Annual outdoor music festival with live bands and food",
        "event_date": "2025-07-15T18:00:00Z",
        "cost_type": 1,
        "price": "45.00",
        "amount": {
          "price": "45.00",
          "currency": "USD"
        },
        "place":
            "Central Park Amphitheater, 123 Park Avenue, New York, NY 10001",
        "location": {
          "latitud": "",
          "longitud": "",
          "country": "Panama",
          "city": "Panama",
          "place": "Amador"
        }
      }
    };
  }

  Map<String, dynamic> userProfile() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": {
        "username": "josedominguez",
        "email": "will0149@yahoo.com",
        "first_name": "Jose",
        "last_name": "Dominguez",
        "avatar":
            "https://numwo-media.s3.amazonaws.com/profiles/moneda-antigua-50.jpg",
        "bio": "Dedicated Entrepreneur",
        "link": "https://www.example.com.pa/",
        "user_type": 0
      }
    };
  }

  Map<String, dynamic> ticketList() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": [
        {
          "id": 1,
          "customer": {
            "username": "jane_smith",
            "first_name": "Jane",
            "last_name": "Smith"
          },
          "event": {
            "id": 1,
            "owner": "john_doe",
            "banner_img":
                "https://numwo-media.s3.amazonaws.com/events/1/banner.jpg",
            "name": "Summer Music Festival 2025",
            "description": "Join us for an amazing outdoor music festival",
            "short_description": "Annual outdoor music festival",
            "event_date": "2025-07-15T18:00:00Z",
            "cost_type": 1,
            "price": "45.00",
            "place": "Central Park Amphitheater"
          },
          "date_purchased": "2025-06-10T14:30:00Z",
          "created": "2025-06-10T14:30:00Z",
          "updated": "2025-06-10T14:30:00Z"
        }
      ]
    };
  }
}
