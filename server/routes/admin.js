const express = require('express');
const router = express.Router();
const pool = require('../db'); // db.js exports your mysql2 pool

// Create User
router.post('/create-user', async (req, res) => {
    const { name, username, password, role } = req.body;

    if (!name || !username || !password || !role) {
        return res.status(400).json({ message: 'All fields are required' });
    }

    try {
        const [rows] = await pool.query('SELECT * FROM users WHERE username = ?', [username]);

        if (rows.length > 0) {
            return res.status(409).json({ message: 'Username already exists' });
        }

        await pool.query(
            'INSERT INTO users (name, username, password, role) VALUES (?, ?, ?, ?)',
            [name, username, password, role]
        );

        return res.status(201).json({ message: 'User created successfully.' });

    } catch (err) {
        console.error('Error in /create-user:', err);
        return res.status(500).json({ message: 'Server error while creating user' });
    }
});

// Edit User (name + contact)
router.put('/edit-user-name', async (req, res) => {
    const { username, newName, newContact } = req.body;
    try {
        const [users] = await pool.query('SELECT * FROM users WHERE username = ?', [username]);
        if (users.length === 0) return res.status(404).json({ message: 'User not found' });

        await pool.query('UPDATE users SET name = ?, contact = ? WHERE username = ?', [
            newName.trim(),
            newContact?.trim() || null,
            username,
        ]);
        res.json({ message: 'Name and contact updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error updating name and contact' });
    }
});

// Edit User (password) — no hashing
router.put('/edit-user-password', async (req, res) => {
    const { username, newPassword } = req.body;
    try {
        const [users] = await pool.query('SELECT * FROM users WHERE username = ?', [username]);
        if (users.length === 0) return res.status(404).json({ message: 'User not found' });

        await pool.query('UPDATE users SET password = ? WHERE username = ?', [newPassword.trim(), username]);
        res.json({ message: 'Password updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error updating password' });
    }
});

// Delete User
router.delete('/delete-user', async (req, res) => {
    const { username } = req.body;
    try {
        const [users] = await pool.query('SELECT * FROM users WHERE username = ?', [username]);
        if (users.length === 0) return res.status(404).json({ message: 'User not found' });

        await pool.query('DELETE FROM users WHERE username = ?', [username]);
        res.json({ message: 'User deleted successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error deleting user' });
    }
});

// Get user info by username
router.get('/get-user', async (req, res) => {
    const { username } = req.query;
    try {
        const [users] = await pool.query('SELECT username, name, contact FROM users WHERE username = ?', [username]);
        if (users.length === 0) return res.status(404).json({ message: 'User not found' });
        res.json(users[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error fetching user' });
    }
});


// Add this GET route to fetch user info by username for frontend search
router.get('/get-user', async (req, res) => {
    const { username } = req.query;
    try {
        const [users] = await pool.query('SELECT username, name, contact FROM users WHERE username = ?', [username]);
        if (users.length === 0) return res.status(404).json({ message: 'User not found' });
        res.json(users[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error fetching user' });
    }
});


// View All Appointments
router.get('/appointments', async (req, res) => {
    try {
        const [appointments] = await pool.query(
            'SELECT id, doctor_username, patient_username, appointment_date, appointment_time, status FROM appointments'
        );

        // Format the appointment date as yyyy-MM-dd for HTML input compatibility
        appointments.forEach(appointment => {
            const localDate = new Date(appointment.appointment_date);
            const formattedDate = localDate.getFullYear() + '-' +
                String(localDate.getMonth() + 1).padStart(2, '0') + '-' +
                String(localDate.getDate()).padStart(2, '0');
            appointment.appointment_date = formattedDate;
        });

        res.json(appointments);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error retrieving appointments' });
    }
});




// Edit Appointment
router.put('/edit-appointment', async (req, res) => {
    const { id, date, time, status } = req.body;
    try {
        const [current] = await pool.query('SELECT * FROM appointments WHERE id = ?', [id]);
        if (current.length === 0) return res.status(404).json({ message: 'Appointment not found' });

        await pool.query(
            'UPDATE appointments SET appointment_date = ?, appointment_time = ?, status = ? WHERE id = ?',
            [date, time, status, id]
        );

        res.json({ message: 'Appointment updated successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error updating appointment' });
    }
});

// Fetch Booked Slots
router.get('/booked-slots', async (req, res) => {
    const { date, doctor } = req.query;
    if (!date || !doctor) return res.status(400).json({ message: 'Missing date or doctor' });

    try {
        const [appointments] = await pool.query(
            'SELECT appointment_time FROM appointments WHERE appointment_date = ? AND doctor_username = ?',
            [date, doctor]
        );
        const bookedSlots = appointments.map(a => a.appointment_time.slice(0,5));
        res.json(bookedSlots);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error fetching booked slots' });
    }
});
// View all users
router.get('/allusers', async (req, res) => {
    try {
        const [users] = await pool.query('SELECT * FROM users');
        res.json(users);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Server error fetching users' });
    }
});

// Fetch admin profile by username
router.get('/profile', async (req, res) => {
    const username = req.query.username;

    if (!username) {
        return res.status(400).json({ message: 'Username is required' });
    }

    try {
        const [result] = await pool.query('SELECT name, contact FROM users WHERE username = ? AND role = ?', [username, "admin"]);

        if (result.length === 0) {
            return res.status(404).json({ message: 'Admin not found' });
        }

        res.json(result[0]);
    } catch (err) {
        console.error('Error fetching admin profile:', err);
        res.status(500).json({ message: 'Server error retrieving admin profile' });
    }
});



module.exports = router;
