const express = require('express');
const stripe = require('stripe')("sk_test_51RMYMeRwiRrw4YRsAv64GMCCYtjJdIk1EABuZoMUaMlxy2KIWqXknRBtcOPvePwIqjXgl5dWCz1gYV2h7ehSdh5N00bIPPfGIm");
const { createClient } = require('@supabase/supabase-js');

const app = express();
app.use(express.json());

const cors = require('cors');
app.use(cors());

// Initialize Supabase client
const supabase = createClient('https://orbyufgotjazcyvuqslq.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9yYnl1ZmdvdGphemN5dnVxc2xxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU1MTU4ODUsImV4cCI6MjA2MTA5MTg4NX0.D5cCLX5b4aTRAcpAFzIBajNg9xX65cPKRsscd2V7P5k');

// Endpoint to create a Checkout Session
app.post('/create-checkout-session', async (req, res) => {
    try {
        const { amount, currency, successUrl, cancelUrl, title } = req.body;

        const session = await stripe.checkout.sessions.create({
            payment_method_types: ['card', 'paypal'],
            line_items: [
                {
                    price_data: {
                        currency: currency,
                        product_data: {
                            name: title, // Replace with your product name
                        },
                        unit_amount: amount, // Amount in the smallest currency unit (e.g., cents for USD)
                    },
                    quantity: 1,
                },
            ],
            mode: 'payment',
            success_url: successUrl, // Redirect here after successful payment
            cancel_url: cancelUrl, // Redirect here if the user cancels
            shipping_address_collection: {
                allowed_countries: ['GB'], // Restrict to UK
            },
            metadata: {
                foreignKey: req.body.metadata.foreignKey, // Only send foreignKey to Stripe
            },
        });

        // Save data to Supabase directly on checkout session creation
        try {
            const { error } = await supabase.from('cart_items').insert({
                foreign_key: req.body.metadata.foreignKey,
                name: req.body.metadata.name,
                email: req.body.metadata.email,
                interests: req.body.metadata.interests,
                age: req.body.metadata.age,
                gender: req.body.metadata.gender,
                conversation_history: req.body.metadata.conversationHistory,
                purchase_amount: amount / 100, // Convert from cents to main currency unit
            });

            if (error) {
                console.error('Error saving to Supabase:', error);
                return res.status(500).json({ error: 'Error saving to Supabase' });
            }

            console.log('Data saved to Supabase successfully');
        } catch (err) {
            console.error('Error processing Supabase insert:', err);
            return res.status(500).json({ error: 'Internal Server Error' });
        }

        res.json({ url: session.url });
    } catch (error) {
        console.error('Error creating checkout session:', error);
        res.status(500).json({ error: error.message });
    }
});

app.post('/create-payment-intent', async (req, res) => {
    try {
        const { amount, currency } = req.body;

        // Create a Payment Intent
        const paymentIntent = await stripe.paymentIntents.create({
            amount, // Amount in the smallest currency unit (e.g., cents for USD)
            currency,
            payment_method_types: ['card'],
        });

        res.json({ clientSecret: paymentIntent.client_secret });
    } catch (error) {
        console.error('Error creating payment intent:', error);
        res.status(500).json({ error: error.message });
    }
});

// Ensure raw body is used for the webhook endpoint
app.post('/webhook', express.raw({ type: 'application/json' }), async (req, res) => {
    const sig = req.headers['stripe-signature'];
    const endpointSecret = 'whsec_dc338df7c7f23e780d80f968a3e79c4f2d4e7c3e90924c09322c96fc0bb4fc06';

    let event;

    try {
        // Use the raw body for signature verification
        event = stripe.webhooks.constructEvent(req.body, sig, endpointSecret);
    } catch (err) {
        console.error('Webhook signature verification failed:', err.message);
        return res.status(400).send(`Webhook Error: ${err.message}`);
    }

    console.log('Received event:', event.type); // Log the event type
    console.log('Event data:', event.data.object); // Log the event data

    if (event.type === 'checkout.session.completed') {
        const session = event.data.object;

        // Extract metadata and email
        const { metadata, customer_details } = session;
        const email = customer_details.email;

        console.log('Processing checkout.session.completed event');
        console.log('Metadata:', metadata);
        console.log('Customer email:', email);

        try {
            // Save to Supabase
            const { error } = await supabase.from('cart_items').insert({
                foreign_key: metadata.foreignKey,
                name: metadata.name,
                email: email,
                interests: metadata.interests,
                age: metadata.age,
                gender: metadata.gender,
                conversation_history: metadata.conversationHistory,
                purchase_amount: session.amount_total / 100, // Convert from cents to main currency unit
            });

            if (error) {
                console.error('Error saving to Supabase:', error);
                return res.status(500).send('Error saving to Supabase');
            }

            console.log('Data saved to Supabase successfully');
            res.status(200).send('Webhook received and processed');
        } catch (err) {
            console.error('Error processing webhook:', err);
            res.status(500).send('Internal Server Error');
        }
    } else {
        console.log('Unhandled event type:', event.type);
        res.status(400).send('Unhandled event type');
    }
});

app.listen(4242, () => console.log('Server running on port 4242'));