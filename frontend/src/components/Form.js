import React, { Component } from 'react';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';

class Form extends Component {
  render() {
    return (
      <Tabs>
        <TabList>
          <Tab>Seu Cadastro</Tab>
          <Tab>Sua Empresa</Tab>
        </TabList>

        <TabPanel>
        <form>
          <span>Cadastre seu usuário e faça parte da RN</span>
          <label>Seu nome:
            <input type="text" />
          </label>

          <label>Seu email:
            <input type="text" />
          </label>

          <input type="submit" value="Salvar" />
        </form>
        </TabPanel>

        <TabPanel>
          <form>
            <span>Edite sua empresa cadastrada na RN</span>
            <label>Seu empresa:
              <input type="text" />
            </label>

            <label>Setor onde atua a empresa:
              <select>
                <option value="industria">Indústria</option>
                <option value="comercio">Comércio</option>
                <option value="tecnologia">Tecnologia</option>
              </select>
            </label>

            <input type="submit" value="Salvar" />
          </form>
        </TabPanel>
      </Tabs>
    );
  }
}

export default Form;