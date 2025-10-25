# Airbnb Database Design Requirements

## Entities and Attributes

### User
- user_id (PK)
- name
- email
- password_hash
- phone_number
- profile_photo_url
- created_at

### Property
- property_id (PK)
- owner_id (FK → User)
- title
- description
- location
- price_per_night
- property_type
- max_guests
- created_at

### Booking
- booking_id (PK)
- user_id (FK → User)
- property_id (FK → Property)
- check_in_date
- check_out_date
- total_price
- status
- created_at

### Review
- review_id (PK)
- user_id (FK → User)
- property_id (FK → Property)
- rating
- comment
- created_at

### Payment
- payment_id (PK)
- booking_id (FK → Booking)
- amount
- payment_method
- payment_status
- paid_at

### Message
- message_id (PK)
- sender_id (FK → User)
- receiver_id (FK → User)
- property_id (FK → Property, optional)
- content
- sent_at

## Relationships

- A User can own multiple Properties
- A User can book multiple Properties
- A Property can have multiple Bookings
- A Booking has one Payment
- A User can leave multiple Reviews
- A Property can have multiple Reviews
- Users can exchange Messages
