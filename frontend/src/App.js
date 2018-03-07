import React, { Component } from 'react';
import Header from './components/Header'
import Form from './components/Form'
import './App.css';

class App extends Component {
  render() {
    return (
      <React.Fragment>
        <Header />
        <Form />
      </React.Fragment>
    );
  }
}

export default App;
