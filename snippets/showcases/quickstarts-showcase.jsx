export const QuickstartsShowcase = () => {
  const [tabIdx, setTabIdx] = useState(0);

  const ICON = {
    wallet: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 12V7H5a2 2 0 0 1 0-4h14v4 M3 5v14a2 2 0 0 0 2 2h16v-5 M18 12a2 2 0 0 0-2 2v0a2 2 0 0 0 2 2h4v-4z"/></svg>,
    coin: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 6v12 M15.5 9.5H10a2.5 2.5 0 0 0 0 5h4a2.5 2.5 0 0 1 0 5H8.5"/></svg>,
    contract: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z M14 2v6h6 M16 13H8 M16 17H8"/></svg>,
    chat: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>,
    bot: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="11" width="18" height="10" rx="2"/><circle cx="12" cy="5" r="2"/><path d="M12 7v4 M8 16h.01 M16 16h.01"/></svg>,
    flask: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M10 2v6L4 18a2 2 0 0 0 2 3h12a2 2 0 0 0 2-3l-6-10V2 M10 2h4"/></svg>,
    sparkle: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 2l2.4 5.6L20 9l-4.2 3.6L17 18l-5-3-5 3 1.2-5.4L4 9l5.6-1.4z"/></svg>,
    cpu: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="4" y="4" width="16" height="16" rx="2"/><rect x="9" y="9" width="6" height="6"/><path d="M9 1v3 M15 1v3 M9 20v3 M15 20v3 M20 9h3 M20 14h3 M1 9h3 M1 14h3"/></svg>,
    wrench: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg>,
    play: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 3l14 9-14 9z"/></svg>,
    fox: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M3 3l3 6 3-3 3 3 3-3 3 3 3-6v9a8 8 0 0 1-9 8 8 8 0 0 1-9-8z"/></svg>,
    image: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"/><circle cx="8.5" cy="8.5" r="1.5"/><path d="M21 15l-5-5L5 21"/></svg>,
    bldg: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18 M9 21V9"/></svg>
  };

  const TABS = [
    {
      label: 'Quickstarts',
      items: [
        { icon: ICON.play, title: 'Getting started', desc: 'Set up an account, get testnet HBAR, and run your first transaction.', href: '/learn/getting-started/index' },
        { icon: ICON.coin, title: 'Testnet faucet', desc: 'Fund your testnet account with free HBAR to start building.', href: '/learn/getting-started/testnet-faucet' },
        { icon: ICON.wrench, title: 'Choose your path', desc: 'EVM vs native SDK: pick the right starting point for what you’re building.', href: '/learn/getting-started/choose-your-path' },
        { icon: ICON.coin, title: 'Quickstart', desc: 'Install the JavaScript SDK and submit your first transaction.', href: '/native/quickstart/javascript' },
        { icon: ICON.fox, title: 'MetaMask setup', desc: 'Connect MetaMask to the Hedera EVM JSON-RPC relay.', href: '/evm/quickstart/setup-metamask' }
      ]
    }
  ];

  const chip = (active) => ({
    padding: '6px 14px',
    borderRadius: '999px',
    fontSize: '13px',
    fontWeight: 400,
    lineHeight: 1.4,
    cursor: 'pointer',
    border: '1px solid var(--landing-border)',
    background: active ? 'var(--landing-pill-bg)' : 'transparent',
    color: active ? 'var(--landing-pill-fg)' : 'var(--landing-fg-secondary)',
    transition: 'background-color 0.15s ease, color 0.15s ease, border-color 0.15s ease',
    whiteSpace: 'nowrap'
  });

  return (
    <div>
      {/* Tab chips — hidden when there's only one tab */}
      {TABS.length > 1 && (
        <div role="tablist" aria-label="Quickstart categories" style={{ display: 'flex', gap: '8px', flexWrap: 'wrap', margin: '0 0 24px' }}>
          {TABS.map((t, i) => (
            <button
              key={t.label}
              role="tab"
              aria-selected={i === tabIdx}
              onClick={() => setTabIdx(i)}
              style={chip(i === tabIdx)}
            >
              {t.label}
            </button>
          ))}
        </div>
      )}

      {/* Cards grid — fixed 2 columns */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(2, minmax(0, 1fr))',
        gap: '12px'
      }}>
        {TABS[tabIdx].items.map((it) => (
          <a
            key={it.title}
            href={it.href}
            style={{
              display: 'flex',
              alignItems: 'flex-start',
              gap: '14px',
              padding: '18px',
              borderRadius: '10px',
              border: '1px solid var(--landing-border)',
              textDecoration: 'none',
              backgroundColor: 'var(--landing-card-bg)',
              transition: 'border-color 0.15s ease'
            }}
          >
            <div style={{
              width: '36px', height: '36px', borderRadius: '8px',
              background: 'var(--landing-card-icon-bg)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              flexShrink: 0
            }}>
              {it.icon}
            </div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ fontWeight: 500, fontSize: '0.875rem', color: 'var(--landing-fg-primary)', marginBottom: '4px' }}>
                {it.title}
              </div>
              <div style={{ fontSize: '0.8125rem', color: 'var(--landing-fg-tertiary)', lineHeight: 1.45 }}>
                {it.desc}
              </div>
            </div>
          </a>
        ))}
      </div>
    </div>
  );
};
