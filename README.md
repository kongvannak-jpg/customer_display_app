# Customer Display App (CDS)

This Flutter app is a Customer Display System (CDS) that shows real-time order information, promotions, and order status updates at a POS counter. It's designed to connect to a WebSocket server (e.g., a POS or backend service) and display live cart updates as cashier adds items, applies discounts, or completes transactions.

---

## Quick summary

- Purpose: Display live order details to customers during checkout.
- Platform: Flutter (mobile / desktop / web)
- Real-time: Uses WebSocket for instant updates
- Key screens: Login, Device Selection, Home Dashboard, Order Screen

---

## Features

- Real-time order and item updates
- Display discounts and final totals
- Rotating promo/"Today's Special" banner
- Device login (QR and email) and device selection
- Reusable UI components (buttons, text fields, select fields)

---

## Architecture overview

- POS Terminal (or backend) → WebSocket Server → CDS App (Flutter)
- Backend stores orders, promotions and handles WebSocket broadcast

---

## Project structure (important files)

- `lib/main.dart` - App entry point and theme
- `lib/screens/order/order_screen.dart` - Main order display
- `lib/widgets/order/your_order_widget.dart` - Live cart UI
- `lib/widgets/order/todays_special_widget.dart` - Banner/promo
- `lib/widgets/buttons/btn_secondary_widget.dart` - Reusable button

---

## Setup (developer)

1. Install Flutter and setup environment: https://flutter.dev/docs/get-started/install
2. From project root run:

```powershell
# Get packages
flutter pub get

# Run on connected device (Windows PowerShell)
flutter run -d windows
```

---

## WebSocket integration (how the app expects data)

The app expects JSON events over WebSocket. Example event types:

- `item_added` - item added to cart
- `order_updated` - totals/discounts changed
- `order_ready` - order ready for pickup
- `promotion_update` - change promotions

Example JSON for `item_added`:

```json
{
  "event": "item_added",
  "data": {
    "orderNumber": "A001",
    "items": [
      {
        "id": "item_001",
        "name": "Cappuccino",
        "price": 5.5,
        "quantity": 1,
        "image": "https://..."
      }
    ],
    "orderTotal": 5.5,
    "timestamp": "2025-10-20T10:00:00Z"
  }
}
```

### Simple Node.js WebSocket server example

```js
// server.js
const http = require("http");
const WebSocket = require("ws");
const server = http.createServer();
const wss = new WebSocket.Server({ server });

wss.on("connection", function connection(ws) {
  console.log("Client connected");
  ws.on("message", function incoming(message) {
    // Broadcast incoming messages to all clients
    wss.clients.forEach(function each(client) {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message);
      }
    });
  });
});

server.listen(8080, () => console.log("WebSocket server running on :8080"));
```

Run server (PowerShell):

```powershell
node server.js
```

---

## How to test locally

1. Start Node server (see above)
2. Run Flutter app
3. Use `wscat` or a small script to send `item_added` or `order_updated` events

Example using `wscat`:

```powershell
# install if needed
npm install -g wscat

# connect
wscat -c ws://localhost:8080

# send an event
{ "event":"item_added","data":{"orderNumber":"A001","items":[{"name":"Cappuccino","price":5.5,"quantity":1}]}}
```

---

## Notes for the team

- UI components are modular — reuse `BtnSecondaryWidget` and other widgets across screens.
- The app assumes the backend will broadcast events as JSON objects with `event` and `data` fields.
- Theme and colors are centralized in `main.dart`.
- Use `lib/widgets/order/` to add or modify order-related UI.

---

## Troubleshooting

- If images fail to load, check network and image URLs.
- If WebSocket disconnects, check server logs and network connectivity.
- Check Flutter doctor if the app fails to run.

---

## Next steps (suggested)

- Add automated tests for parsing WebSocket messages
- Add offline caching for orders
- Add analytics (order counts, average wait times)

---

## System Architecture

```
+----------------CUSTOMER DISPLAY SYSTEM (CDS)----------------+
|                                                           |
|  +-----------+          +-----------+          +----------+|
|  |POS TERMINAL|         |BACKEND SRV|          |CUSTOMER  ||
|  |           |         |           |          |DISPLAY   ||
|  | +-------+ |         | +-------+ |          |+-------+ ||
|  | |Cashier| |         | |WebSock| |          ||Flutter| ||
|  | |Interface|         | |Server | |          ||App    | ||
|  | +-------+ |         | +-------+ |          |+-------+ ||
|  |           |         |           |          |         ||
|  | +-------+ | WebSock | +-------+ | WebSock  |+-------+ ||
|  | |Item   |<--------->|Database |<--------->||Login  | ||
|  | |Scanner| |         |Handler | |          ||Screen | ||
|  | +-------+ |         +-------+ |          |+-------+ ||
|  |           |         |           |          |         ||
|  | +-------+ |         | +-------+ |          |+-------+ ||
|  | |Payment| |         | |RealTime| |          ||Home   | ||
|  | |Process| |         | |Data    | |          ||Dashboard||
|  | +-------+ |         | +-------+ |          |+-------+ ||
|  +-----------+         +-----------+          +----------+|
+-----------------------------------------------------------+

+-----------------DATA FLOW BLOCKS----------------------+
|                                                      |
| +-------+     +--------+     +--------+    +--------+|
| |ITEM   |---->|WEBSOCK |---->|DISPLAY |---->|CUSTOMER||
| |SCAN   |     |MESSAGE |     |UPDATE  |    |VIEW    ||
| +-------+     +--------+     +--------+    +--------+|
|                                                      |
| +-------+     +--------+     +--------+    +--------+|
| |DISCOUNT|---->|PROMO   |---->|LIVE    |---->|CUSTOMER||
| |APP    |     |ENGINE  |     |CART    |    |CONFIRM ||
| +-------+     +--------+     +--------+    +--------+|
+------------------------------------------------------+
```
