// Some parts of code below were taken from Professor Nat Tuck's scratch repository 

import { Row, Col, Card } from 'react-bootstrap';
import { connect } from 'react-redux';

function photo_path(post) {
  return post.photo_hash;
}

function Post({post}) {
  return (
    <Col>
      <Card>
        <Card.Img variant="top" src={photo_path(post)} />
        <Card.Text>
          Posted by {post.user.name}<br />
          {post.body}
        </Card.Text>
      </Card>
    </Col>
  );
}

function Feed({posts}) {
  let cards = posts.map((post) => <Post post={post} key={post.id} />);
  return (
    <Row>
      { cards }
    </Row>
  );
}

export default connect(({posts}) => ({posts}))(Feed);