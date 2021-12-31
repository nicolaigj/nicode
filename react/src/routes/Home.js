import { Link } from "react-router-dom";
import Main from "components/Main";

import "./home.css";

const Home = () => (
  <Main>
    <article className="home">
      <h1>Welcome to nicode</h1>

      <section>
        <p>We are a tiny consultancy firm focused on people as much as code</p>

        <p>
          <span>Contact us!</span>
          <span>
            <Link to="/Nicolai">Nicolai</Link>
            <Link to="/Hans">Hans</Link>
          </span>
        </p>
      </section>
    </article>
  </Main>
);

export default Home;
