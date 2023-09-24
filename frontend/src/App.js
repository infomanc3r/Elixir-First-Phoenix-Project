import React, { useState } from 'react';
import logo from './logo.svg';
import './App.css';
import { Login } from './Login';
import { Register } from './Register';


function App() {
    const [currentForm, setCurrentForm] = useState('login');

    const toggleForm = (formName) => {
        setCurrentForm(formName);
    }

  return (
    <div className="App">
      {
        {
            'home': <Home onFormSwitch={toggleForm} />,
            'login': <Login onFormSwitch={toggleForm} />,
            'register': <Register onFormSwitch={toggleForm} />,
            'timeline': <Timeline onFormSwitch={toggleForm} />

        }[currentForm]
      }
    </div>
  );
}

export default App;
