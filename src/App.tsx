import { useMemo, useState } from 'react';
import './styles.css';

const modules = ["Dashboard","Tables & Reservations","Menu & Modifiers","POS Orders","Kitchen Display","Bar Display","Recipes & Stock","Purchasing","Wastage","Shifts & Cash","Reports","Settings"];
const metrics = [["Today's sales","ZMW 0.00"],["Open orders","0"],["Tables occupied","0"],["Kitchen queue","0"]];

export default function App() {
  const [active, setActive] = useState('Dashboard');
  const [query, setQuery] = useState('');
  const filtered = useMemo(() => modules.filter(item => item.toLowerCase().includes(query.toLowerCase())), [query]);
  return <main className="shell">
    <header className="topbar"><a className="brand" href="#"><span className="brand-mark">S</span><span>SifoRestaurant<small> SIFONET TECHNOLOGIES</small></span></a><div className="top-actions"><span className="environment">DEMO WORKSPACE</span><button className="avatar" aria-label="User profile">PS</button></div></header>
    <section className="intro"><div><p className="eyebrow">Restaurant operations</p><h1>Good morning</h1><p className="muted">Your operations at a glance. Welcome to SifoRestaurant.</p></div><button className="primary" onClick={() => setActive(modules[1])}>＋ New record</button></section>
    <section className="metrics">{metrics.map(([label,value]) => <article className="metric" key={label}><span>{label}</span><strong>{value}</strong><small>Demo workspace</small></article>)}</section>
    <section className="workspace"><div className="section-heading"><div><p className="eyebrow">WORKSPACE</p><h2>Operations</h2></div><input value={query} onChange={e=>setQuery(e.target.value)} placeholder="Search modules…" aria-label="Search modules" /></div>
      <nav className="module-grid">{filtered.map((item,i)=><button key={item} onClick={()=>setActive(item)} className={active===item?'module active':'module'}><span className="module-icon">{String(i+1).padStart(2,'0')}</span><span>{item}</span><span className="chevron">↗</span></button>)}</nav>
      <article className="activity"><div><p className="eyebrow">CURRENT VIEW</p><h3>{active}</h3><p className="muted">This module is part of the SifoRestaurant foundation. Connect the independent database and implement validated workflows before recording live transactions.</p></div><span className="status">Foundation ready</span></article>
    </section>
    <footer>© {new Date().getFullYear()} Sifonet Technologies <span>Independent product · Zambia · ZMW</span></footer>
  </main>;
}
