import React, { useState } from "react";
import axios from 'axios';

export const Login = (props) => {
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");

    async function sendLoginRequest(event) {
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
            let response = await axios.post('http://localhost:4000/api/accounts/sign_in', body, { headers });
                if(response.status === 200) {
                    localStorage.setItem('token', response.data.token);
                    event.preventDefault();
                    props.onFormSwitch('loggedin');
                    return Promise.all([response.body, response.headers]);
                } else {
                    event.preventDefault();
                    return Promise.reject("Invalid Login Attempt!");
                }
        } catch(exception) {
            alert("Request failed with status code 401: UNAUTHORIZED");
        }
    }

    return (
        <div className="auth-form-container">
            <h2>Login</h2>
            <form className="login-form" onSubmit={(event) => sendLoginRequest(event)}>
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
                <button type="submit">Login</button>
            </form>
            <button className="link-button" onClick={() => props.onFormSwitch('register')}>Don't have an account? Register here.</button>
            <button className="home-button" onClick={() => props.onFormSwitch('home')}>Back to Home</button>
        </div>
    )
}