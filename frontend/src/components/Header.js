import React, { Component } from 'react';
import Hamburguer from './Hamburguer';

class Header extends Component {
  render() {
    return (
      <header>
        <button className="btn-back"></button>
        <h1 className="header-title">Cadastro</h1>
        <Hamburguer></Hamburguer>
      </header>
    );
  }
}

export default Header;
