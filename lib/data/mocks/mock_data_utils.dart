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
          "id": "1",
          "owner": "john_doe",
          "banner_img":
              "https://thehotelfactory.com/wp-content/uploads/2018/09/Camping-portada.jpeg",
          "name": "Summer Music Festival 2025",
          "description":
              "Join us for an amazing outdoor music festival featuring local and international artists. Food trucks, craft beer, and family-friendly activities will be available throughout the day.",
          "short_description":
              "Annual outdoor music festival with live bands and food",
          "event_date": "2025-07-15T18:00:00Z",
          "cost_type": "PAYED",
          "privacy_type": "PRIVATE",
          "price": "45.00",
          "amount": {"price": "45.00", "currency": "USD"},
          "place":
              "Central Park Amphitheater, 123 Park Avenue, New York, NY 10001",
          "location": {
            "latitud": "",
            "longitud": "",
            "country": "Panama",
            "city": "Panama",
            "place": "Amador"
          }
        },
        {
          "id": "2",
          "owner": "john_doe",
          "banner_img":
              "https://revistapanorama.com/storage/2023/01/carnaval-los-santos.jpg",
          "name": "Summer Music Festival 2025",
          "description":
              "Join us for an amazing outdoor music festival featuring local and international artists. Food trucks, craft beer, and family-friendly activities will be available throughout the day.",
          "short_description":
              "Annual outdoor music festival with live bands and food",
          "event_date": "2025-07-15T18:00:00Z",
          "cost_type": "FREE",
          "privacy_type": "PUBLIC",
          "price": "45.00",
          "amount": {"price": "45.00", "currency": "USD"},
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
      ]
    };
  }

  Map<String, dynamic> eventDetail() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": {
        "id": "2",
        "owner": "john_doe",
        "banner_img":
            "https://revistapanorama.com/storage/2023/01/carnaval-los-santos.jpg",
        "name": "Summer Music Festival 2025",
        "description":
            "Join us for an amazing outdoor music festival featuring local and international artists. Food trucks, craft beer, and family-friendly activities will be available throughout the day.",
        "short_description":
            "Annual outdoor music festival with live bands and food",
        "event_date": "2025-07-15T18:00:00Z",
        "cost_type": "FREE",
        "privacy_type": "PUBLIC",
        "price": "45.00",
        "amount": {"price": "45.00", "currency": "USD"},
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

  Map<String, dynamic> purchaseTicketResponse() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": {
        "ticket_id": "TKT-20260210-001",
        "event_id": "2",
        "quantity": 2,
        "total_amount": "90.00",
        "currency": "USD",
        "customer_name": "Jane Smith",
        "customer_email": "jane@example.com",
        "purchase_date": "2026-02-10T14:30:00Z",
        "status": "confirmed"
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

  Map<String, dynamic> promotionList() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": [
        {
          "id": "1",
          "event_id": "1",
          "event_name": "Summer Music Festival 2025",
          "banner_img":
              "https://content.presspage.com/uploads/685/d68d91ac-fad5-4103-aa04-7f6cf878dfe2/1920_conciertoscdmx.jpg",
          "code": "SUMMER25",
          "name": "Early Bird Discount",
          "description":
              "Get 25% off on all tickets purchased before June 1st. Limited availability!",
          "short_description": "25% off early bird tickets",
          "discount_type": "PERCENTAGE",
          "discount_value": "25.00",
          "original_price": "45.00",
          "final_price": "33.75",
          "currency": "USD",
          "start_date": "2025-05-01T00:00:00Z",
          "end_date": "2025-06-01T23:59:59Z",
          "max_uses": 100,
          "current_uses": 45,
          "is_active": true
        },
        {
          "id": "2",
          "event_id": "2",
          "event_name": "Carnaval Los Santos 2025",
          "banner_img":
              "https://www.valenfit.com/wp-content/uploads/2020/07/fit-combat-valenfit.jpg",
          "code": "CARNAVAL10",
          "name": "Group Discount",
          "description":
              "Bring your friends! Get \$10 off per ticket when purchasing 4 or more tickets.",
          "short_description": "\$10 off for groups of 4+",
          "discount_type": "FIXED",
          "discount_value": "10.00",
          "original_price": "45.00",
          "final_price": "35.00",
          "currency": "USD",
          "start_date": "2025-01-15T00:00:00Z",
          "end_date": "2025-02-28T23:59:59Z",
          "max_uses": 200,
          "current_uses": 78,
          "is_active": true
        }
      ]
    };
  }

  Map<String, dynamic> promotionDetail() {
    return {
      "status": {"code": 200, "msg": "exitoso!"},
      "body": {
        "id": "1",
        "event_id": "1",
        "event_name": "Summer Music Festival 2025",
        "banner_img":
            "https://content.presspage.com/uploads/685/d68d91ac-fad5-4103-aa04-7f6cf878dfe2/1920_conciertoscdmx.jpg",
        "code": "SUMMER25",
        "name": "Early Bird Discount",
        "description":
            "Get 25% off on all tickets purchased before June 1st. Limited availability! This exclusive offer is available for our loyal customers who want to secure their spot early.",
        "short_description": "25% off early bird tickets",
        "discount_type": "PERCENTAGE",
        "discount_value": "25.00",
        "original_price": "45.00",
        "final_price": "33.75",
        "currency": "USD",
        "start_date": "2025-05-01T00:00:00Z",
        "end_date": "2025-06-01T23:59:59Z",
        "max_uses": 100,
        "current_uses": 45,
        "is_active": true,
        "terms_conditions":
            "Valid for new purchases only. Cannot be combined with other offers. Non-transferable.",
        "event": {
          "id": "1",
          "owner": "john_doe",
          "banner_img":
              "https://thehotelfactory.com/wp-content/uploads/2018/09/Camping-portada.jpeg",
          "name": "Summer Music Festival 2025",
          "description":
              "Join us for an amazing outdoor music festival featuring local and international artists.",
          "short_description":
              "Annual outdoor music festival with live bands and food",
          "event_date": "2025-07-15T18:00:00Z",
          "cost_type": "PAYED",
          "privacy_type": "PRIVATE",
          "price": "45.00",
          "amount": {"price": "45.00", "currency": "USD"},
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
      }
    };
  }
}
