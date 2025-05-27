*** Variables ***
${BASE_URL}            https://restful-booker.herokuapp.com
${AUTH_ENDPOINT}       /auth
${BOOKING_ENDPOINT}    /booking
${PING_ENDPOINT}=      /ping

${USERNAME}             admin
${PASSWORD}             password123

${HEADERS}              Content-Type=application/json

${AUTH_SCHEMA}          schemas/auth_schema.json
${BOOKING_SCHEMA}       schemas/booking_schema.json