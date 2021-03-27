// Some parts of code below were taken from Professor Nat Tuck's scratch repository 

import { Nav } from 'react-bootstrap';
import { NavLink } from 'react-router-dom';
import store from '../storage/store';


function Link({to, children}) {
  return (
    <Nav.Item>
      <NavLink to={to} exact className="nav-link" activeClassName="active">
        {children}
      </NavLink>
    </Nav.Item>
  );
}

function SessionInfo({session}) {
  function logout(ev) {
    ev.preventDefault();
    store.dispatch({ type: 'session/clear' });
  }

  return (
    <p>
      Logged in as {session.name}
      <Button onClick={logout}>Logout</Button>
    </p>
  );
}


function AppNav({error}) {
  let error_row = null;

  if (error) {
    error_row = (
      <Row>
        <Col>
          <Alert variant="danger">{error}</Alert>
        </Col>
      </Row>
    );
  }

  return (
    <div>
      <Row>
        <Col>
          <Nav variant="pills">
            <Link to="/">Feed</Link>
          <Link to="/users">Users</Link>
        </Nav>
        </Col>
        <Col>
          <LoginOrInfo />
        </Col>
      </Row>
      { error_row }
    </div>
  );
}

export default connect(({error})=>({error}))(AppNav);