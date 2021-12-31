import { Routes, Route } from "react-router-dom";
import Consultant from "routes/Consultant";
import Home from "routes/Home";

function App() {
  return (
    <div className="App">
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/:consultantName" element={<Consultant />} />
      </Routes>
    </div>
  );
}

export default App;
