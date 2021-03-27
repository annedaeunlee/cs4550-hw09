// Some parts of code below were taken from Professor Nat Tuck's scratch repository 

import { Provider } from 'react-redux';
import store from './store';
import { load_defaults } from './api';
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import { BrowserRouter as Router } from 'react-router-dom';


ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <Router>
        <App />
      </Router>
    </Provider>
  </React.StrictMode>,
  document.getElementById('root')
);

load_defaults();
