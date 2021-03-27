// Some parts of code below were taken from Professor Nat Tuck's scratch repository 

import "./App.scss";

import { Container } from 'react-bootstrap';
import { Switch, Route } from 'react-router-dom';

import Nav from "./components/Nav";
import Feed from "./components/Feed";
//import Users from "./Users";
import UsersList from './Users/List';
import UsersNew from './Users/New';


function App() {
  return (
    <Container>
      <Nav />
      <Switch>
        <Route path="/" exact>
          <Feed />
        </Route>
        <Route path="/users" exact>
          <UsersList />
        </Route>
        <Route path="/users/new">
          <UsersNew />
        </Route>
      </Switch>
    </Container>
  );
}

export default App;
