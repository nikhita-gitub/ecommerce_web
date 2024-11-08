<%-- 
    Document   : main
    Created on : 08-Nov-2024, 10:06:58 am
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gift Shop - Home</title>
    <style>
        /* General Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            background-color: #f3f4f6;
            color: #333;
        }

        /* Header */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #ffdde1; /* Softer pink for a warm tone */
            padding: 10px 20px;
            color: #333;
        }
        .header .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: #ff6f61; /* Slightly darker shade for contrast */
        }
        .header input[type="text"] {
            width: 40%;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ffc2c2; /* Light border */
            color: #333;
        }
        .header .icons {
            display: flex;
            align-items: center;
        }
        .header .icon, .header select {
            margin-left: 10px;
            background-color: #ff6f61; /* Unified color */
            padding: 8px 12px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
            cursor: pointer;
            transition: background 0.3s;
            border: none;
            font-size: 0.9rem;
        }
        .header .icon:hover, .header select:hover {
            background-color: #ff8367; /* Softer hover effect */
        }

        /* Dropdown for Category Selection */
        .header select {
            appearance: none;
            color: white;
            font-size: 0.9rem;
        }

               /* Welcome Section */
               .welcome-section {
                position: relative;
                text-align: center;
                color: white;
                background-color: #ff8367;
                padding: 50px 0;
            }
            .welcome-section img {
                width: 100%;
                max-height: 500px;
                object-fit: cover;
                opacity: 0.8;
                border-radius: 8px;
            }
            .welcome-section .overlay-text {
                position: absolute;
                top: 20%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-size: 2rem;
                font-weight: bold;
                color: #fff;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
            }
    

        /* Gift Grid */
        .gift-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            padding: 20px;
        }
        .gift-item {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s;
        }
        .gift-item:hover {
            transform: scale(1.05);
        }
        .gift-item img {
            width: 100%;
            height: auto;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .gift-item h4 {
            margin: 10px 0;
            font-size: 1rem;
            color: #333;
        }
        .gift-item .price {
            color: #ff6f61;
            font-weight: bold;
            margin: 10px 0;
        }
        /* View More Gifts */
        .view-more {
            text-align: center;
            margin: 20px 0;
        }
        .view-more button {
            background-color: #ff6f61;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .view-more button:hover {
            background-color: #ff6f61;
        }
        

        /* Footer Styles */
        .footer {
            text-align: center;
            padding: 20px;
            background-color: #ffdde1; /* Matching footer color */
            color: #333;
            width: 100%;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="logo">GiftShop</div>
        <input type="text" placeholder="Search best gift for ur best ones">
        <div class="icons">
            <a href="#" class="icon">❤ Like</a>
            <select>
                <option value="all">Select Category</option>
                <option value="men">Best Men Gifts</option>
                <option value="women">Best Women Gifts</option>
                <option value="couple">Best Couple Gifts</option>
                <option value="kids">Best Kids Gifts</option>
                <option value="family">Best Family Gifts</option>
            </select>
            <a href="#" class="icon">🛒 Add to Cart</a>
            <a href="#" class="icon">📦 Ordered Items</a>
            <a href="#" class="icon">🔑 Login</a>
        </div>
    </div>

    <div class="welcome-section">
        <img src="https://img.freepik.com/premium-photo/minimalist-brown-gift-box-aesthetic-with-ribbon-flower-background-ai-generated_326414-1475.jpg" alt="Welcome to Gift Shop">
        <div class="overlay-text">Discover the Perfect Gift for Every Occasion!</div>
    </div>
    <!-- Gift Grid Section -->
    <div class="gift-grid">
        <!-- Sample Gift Items -->
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 1">
            <h4>Men’s Wallet</h4>
            <p class="price">$25.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <div class="gift-item">
            <img src="https://via.placeholder.com/150" alt="Gift Image 4">
            <h4>Couple’s Mug Set</h4>
            <p class="price">$30.00</p>
            <div class="button-group">
                <button>❤ Like</button>
                <button>🛒 Add to Cart</button>
            </div>
        </div>
        <!-- More gift items here... -->
        
    </div>
    <div class="view-more">
        <button>View More Gifts</button>
    </div>
     <!-- View More Gifts Section -->
     

    <!-- Footer Section -->
    <div class="footer">
        <p>&copy; 2024 Gift Shop. All Rights Reserved.</p>
        <p>Follow us on <a href="#" style="color: #ff6f61; text-decoration: underline;">Social Media</a></p>
        <p>Contact us: support@giftshop.com | 123-456-7890</p>
    </div>
</body>
</html>
