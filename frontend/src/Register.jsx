import React, { useState } from "react";
import axios from 'axios';

export const Register = (props) => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [username, setUsername] = useState('');

    async function sendRegisterRequest(event) {
        event.preventDefault();
        const reqBody = {
            email: email,
            password: password,
        };
        const body = JSON.stringify(reqBody);
        const headers = {
            'Content-Type': 'application/json',
            };
        try {
            let response = await axios.post('http://localhost:4000/api/accounts/create', body, { headers });
                if(response.status === 200) {
                    localStorage.setItem('token', response.data.token);
                    event.preventDefault();
                    props.onFormSwitch('loggedin');
                    return Promise.all([response.body, response.headers]);
                } else {
                    event.preventDefault();
                    return Promise.reject("Invalid Registration Attempt!");
                }
        } catch(exception) {
            alert("Request failed with status code 401: UNAUTHORIZED");
        }
    }

    return (
        <div className="auth-form-container">
            <h2>Register</h2>
            <form className="register-form" onSubmit={(event) => sendRegisterRequest(event)}>
                <label htmlFor="email">Email: </label>
                    <input
                        value={email}
                        onChange={(event) => setEmail(event.target.value)}
                        type="email"
                        placeholder="Enter your email"
                        id="email"
                        name="email" />
                <label htmlFor="password">Password: </label>
                    <input
                        value={password}
                        onChange={(event) => setPassword(event.target.value)}
                        type="password"
                        placeholder="Enter your password"
                        id="password"
                        name="password" />
                <label htmlFor="username">Username: </label>
                                    <input
                                        value={username}
                                        onChange={(event) => setUsername(event.target.value)}
                                        name="username"
                                        id="username"
                                        placeholder="Enter your desired username:" />
                <button type="submit">Register</button>
            </form>
            <button className="link-button" onClick={() => props.onFormSwitch('login')}>Already have an account? Login here.</button>
            <button className="home-button" onClick={() => props.onFormSwitch('home')}>Back to Home</button>
        </div>
    )
}