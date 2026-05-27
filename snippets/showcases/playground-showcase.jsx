export const PlaygroundShowcase = () => {
  const [tabIdx, setTabIdx] = useState(0);
  const [itemIdx, setItemIdx] = useState(0);

  const ICON = {
    bot: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="11" width="18" height="10" rx="2"/><circle cx="12" cy="5" r="2"/><path d="M12 7v4 M8 16h.01 M16 16h.01"/></svg>,
    coin: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 6v12 M15.5 9.5H10a2.5 2.5 0 0 0 0 5h4a2.5 2.5 0 0 1 0 5H8.5"/></svg>,
    chat: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>,
    contract: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z M14 2v6h6 M16 13H8 M16 17H8"/></svg>,
    sparkle: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M12 2l2.4 5.6L20 9l-4.2 3.6L17 18l-5-3-5 3 1.2-5.4L4 9l5.6-1.4z"/></svg>,
    flask: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M10 2v6L4 18a2 2 0 0 0 2 3h12a2 2 0 0 0 2-3l-6-10V2 M10 2h4"/></svg>,
    cpu: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="4" y="4" width="16" height="16" rx="2"/><rect x="9" y="9" width="6" height="6"/><path d="M9 1v3 M15 1v3 M9 20v3 M15 20v3 M20 9h3 M20 14h3 M1 9h3 M1 14h3"/></svg>,
    image: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"/><circle cx="8.5" cy="8.5" r="1.5"/><path d="M21 15l-5-5L5 21"/></svg>,
    bldg: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18 M9 21V9"/></svg>,
    wrench: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg>,
    code: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M16 18l6-6-6-6 M8 6l-6 6 6 6"/></svg>,
    play: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M5 3l14 9-14 9z"/></svg>,
    globe: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10"/><path d="M2 12h20 M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 M12 2a15.3 15.3 0 0 0-4 10 15.3 15.3 0 0 0 4 10"/></svg>,
    cube: <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"/></svg>
  };


  const TABS = [
    {
      label: 'Try it live',
      items: [
        {
          icon: 'play', title: 'Developer Playground',
          desc: 'Run real Hedera transactions in your browser, no setup.',
          href: 'https://portal.hedera.com/playground',
          preview: { kind: 'embed', url: 'https://portal.hedera.com/playground', label: 'portal.hedera.com/playground' }
        },
        {
          icon: 'contract', title: 'Contract Builder',
          desc: 'Scaffold and deploy Solidity contracts from the browser.',
          href: 'https://portal.hedera.com/contract-builder',
          preview: { kind: 'embed', url: 'https://portal.hedera.com/contract-builder?minimal=1', label: 'portal.hedera.com/contract-builder' }
        },
        {
          icon: 'flask', title: 'Agent Lab',
          desc: 'Visual playground to build, test, and demo AI agents on Hedera.',
          href: 'https://portal.hedera.com/agent-lab',
          preview: { kind: 'embed', url: 'https://portal.hedera.com/agent-lab', label: 'portal.hedera.com/agent-lab' }
        },
      ]
    }
  ];

  const tab = TABS[tabIdx];
  const item = tab.items[itemIdx];

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

  // ── PreviewPane: switches on preview.kind to render chat / code / result ────
  const ChatBubble = ({ msg }) => {
    const isUser = msg.from === 'user';
    const statusColor = msg.status === 'success' ? '#16a34a' : msg.status === 'pending' ? '#d97706' : null;
    return (
      <div style={{ display: 'flex', justifyContent: isUser ? 'flex-end' : 'flex-start', marginBottom: '10px' }}>
        <div style={{
          maxWidth: '85%',
          padding: '10px 14px',
          borderRadius: '14px',
          background: isUser ? 'rgba(130,89,239,0.18)' : 'rgba(17,21,29,0.55)',
          color: '#fff',
          fontSize: '0.8125rem',
          lineHeight: 1.45,
          border: '1px solid rgba(255,255,255,0.06)'
        }}>
          {msg.status && (
            <div style={{ display: 'inline-flex', alignItems: 'center', gap: '6px', fontSize: '0.6875rem', color: statusColor, fontWeight: 500, marginBottom: '4px' }}>
              {msg.status === 'success' && (
                <svg aria-hidden="true" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke={statusColor} strokeWidth="3" strokeLinecap="round" strokeLinejoin="round"><circle cx="12" cy="12" r="10" stroke={statusColor} strokeWidth="2" fill="none"/><path d="M8 12l3 3 5-6"/></svg>
              )}
              {msg.status === 'pending' && (
                <svg aria-hidden="true" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke={statusColor} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><path d="M21 12a9 9 0 1 1-6.219-8.56"/></svg>
              )}
              <span style={{ textTransform: 'uppercase', letterSpacing: '0.04em' }}>{msg.status}</span>
            </div>
          )}
          <div>{msg.text}</div>
          {msg.action && (
            <div style={{ marginTop: '8px', padding: '6px 12px', borderRadius: '8px', background: 'rgba(255,255,255,0.08)', fontSize: '0.6875rem', display: 'inline-block' }}>
              {msg.action.label} · <span style={{ fontFamily: 'monospace' }}>{msg.action.tx}</span>
            </div>
          )}
        </div>
      </div>
    );
  };

  const PreviewPane = ({ preview }) => {
    if (!preview) return null;
    const isEmbed = preview.kind === 'embed';
    const shell = {
      borderRadius: '12px',
      border: '1px solid var(--landing-border)',
      overflow: 'hidden',
      background: 'linear-gradient(180deg, #0c1226 0%, #11151D 100%)',
      height: isEmbed ? (preview.height || '575px') : '420px',
      display: 'grid',
      gridTemplateRows: 'auto 1fr'
    };

    if (preview.kind === 'chat') {
      return (
        <div style={shell}>
          <div style={{ padding: '14px 18px', borderBottom: '1px solid rgba(255,255,255,0.06)', display: 'flex', alignItems: 'center', gap: '8px' }}>
            <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: '#16a34a' }} />
            <div style={{ fontSize: '0.75rem', color: 'rgba(255,255,255,0.55)', fontFamily: 'monospace' }}>hedera-agent · testnet</div>
          </div>
          <div style={{ flex: 1, padding: '18px', overflowY: 'auto' }}>
            {preview.messages.map((m, i) => <ChatBubble key={i} msg={m} />)}
          </div>
        </div>
      );
    }

    if (preview.kind === 'code') {
      return (
        <div style={shell}>
          <div style={{ padding: '10px 14px', borderBottom: '1px solid rgba(255,255,255,0.06)', display: 'flex', alignItems: 'center', gap: '8px' }}>
            <div style={{ display: 'flex', gap: '6px' }}>
              <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#ff5f57' }} />
              <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#febc2e' }} />
              <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#28c840' }} />
            </div>
            <div style={{ fontSize: '0.6875rem', color: 'rgba(255,255,255,0.5)', fontFamily: 'monospace', marginLeft: '8px', textTransform: 'uppercase', letterSpacing: '0.06em' }}>{preview.lang}</div>
          </div>
          <pre style={{
            flex: 1,
            margin: 0,
            padding: '18px',
            overflow: 'auto',
            fontFamily: 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, monospace',
            fontSize: '0.75rem',
            lineHeight: 1.55,
            color: 'rgba(255,255,255,0.88)',
            whiteSpace: 'pre',
            background: 'transparent'
          }}><code>{preview.code}</code></pre>
        </div>
      );
    }

    if (preview.kind === 'result') {
      return (
        <div style={shell}>
          <div style={{ padding: '14px 18px', borderBottom: '1px solid rgba(255,255,255,0.06)', display: 'flex', alignItems: 'center', gap: '10px' }}>
            {preview.status === 'success' && (
              <div style={{ width: '24px', height: '24px', borderRadius: '50%', background: 'rgba(22,163,74,0.18)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <svg aria-hidden="true" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#16a34a" strokeWidth="3" strokeLinecap="round" strokeLinejoin="round"><path d="M5 12l5 5L20 7"/></svg>
              </div>
            )}
            <div style={{ fontSize: '0.875rem', fontWeight: 500, color: '#fff' }}>{preview.title}</div>
          </div>
          <div style={{ flex: 1, padding: '18px', overflow: 'auto' }}>
            <div style={{ display: 'grid', gridTemplateColumns: '120px 1fr', gap: '8px 16px' }}>
              {preview.rows.flatMap(([k, v], i) => [
                <div key={'k' + i} style={{ fontSize: '0.75rem', color: 'rgba(255,255,255,0.5)', textTransform: 'uppercase', letterSpacing: '0.04em' }}>{k}</div>,
                <div key={'v' + i} style={{ fontSize: '0.8125rem', color: 'rgba(255,255,255,0.92)', fontFamily: /^[0-9.\-]/.test(String(v)) || String(v).startsWith('0x') || String(v).startsWith('{') ? 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, monospace' : 'inherit', wordBreak: 'break-all' }}>{v}</div>
              ])}
            </div>
          </div>
        </div>
      );
    }

    if (preview.kind === 'embed') {
      return (
        <div style={shell}>
          <div style={{ padding: '10px 14px', borderBottom: '1px solid rgba(255,255,255,0.06)', display: 'flex', alignItems: 'center', gap: '8px' }}>
            <div style={{ display: 'flex', gap: '6px' }}>
              <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#ff5f57' }} />
              <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#febc2e' }} />
              <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#28c840' }} />
            </div>
            <div style={{ fontSize: '0.6875rem', color: 'rgba(255,255,255,0.5)', fontFamily: 'monospace', marginLeft: '8px' }}>{preview.label || preview.url}</div>
          </div>
          <iframe
            src={preview.url}
            title={preview.label || 'Embedded preview'}
            style={{ flex: 1, width: '100%', border: 0, background: '#fff', display: 'block' }}
            loading="lazy"
            sandbox="allow-scripts allow-same-origin allow-forms allow-popups allow-popups-to-escape-sandbox"
          />
        </div>
      );
    }

    return null;
  };

  return (
    <div>
      {/* Tab chips — hidden when there's only one tab */}
      {TABS.length > 1 && (
        <div role="tablist" aria-label="Showcase categories" style={{ display: 'flex', gap: '8px', flexWrap: 'wrap', margin: '0 0 16px' }}>
          {TABS.map((t, i) => (
            <button
              key={t.label}
              role="tab"
              aria-selected={i === tabIdx}
              onClick={() => { setTabIdx(i); setItemIdx(0); }}
              style={chip(i === tabIdx)}
            >
              {t.label}
            </button>
          ))}
        </div>
      )}

      {/* Two-column body — left list fixed-ish, right preview takes the rest */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'minmax(280px, 380px) minmax(0, 1fr)',
        gap: '16px',
        alignItems: 'start'
      }}>
        {/* Left: item list */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
          {tab.items.map((it, i) => {
            const active = i === itemIdx;
            return (
              <button
                key={it.title}
                onClick={() => setItemIdx(i)}
                style={{
                  display: 'flex',
                  alignItems: 'flex-start',
                  gap: '14px',
                  padding: '16px',
                  borderRadius: '10px',
                  border: '1px solid ' + (active ? '#8259EF' : 'var(--landing-border)'),
                  background: active ? 'var(--landing-card-bg)' : 'transparent',
                  textAlign: 'left',
                  cursor: 'pointer',
                  width: '100%',
                  transition: 'background-color 0.15s ease, border-color 0.15s ease',
                  font: 'inherit',
                  color: 'inherit'
                }}
              >
                <div style={{ width: '36px', height: '36px', borderRadius: '8px', background: 'var(--landing-card-icon-bg)', display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                  {ICON[it.icon]}
                </div>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div style={{ fontWeight: 500, fontSize: '0.875rem', color: 'var(--landing-fg-primary)', marginBottom: '4px' }}>{it.title}</div>
                  <div style={{ fontSize: '0.8125rem', color: 'var(--landing-fg-tertiary)', lineHeight: 1.45 }}>{it.desc}</div>
                </div>
                <svg aria-hidden="true" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--landing-fg-tertiary)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ flexShrink: 0, marginTop: '10px' }}><path d="M9 18l6-6-6-6"/></svg>
              </button>
            );
          })}

          <a
            href={item.href}
            style={{
              alignSelf: 'flex-start',
              marginTop: '8px',
              padding: '8px 16px',
              borderRadius: '999px',
              backgroundColor: '#8259EF',
              color: '#fff',
              fontSize: '0.8125rem',
              fontWeight: 500,
              textDecoration: 'none'
            }}
          >
            Open {item.title} →
          </a>
        </div>

        {/* Right: per-item preview pane (chat / code / result mockup) */}
        <PreviewPane preview={item.preview} />
      </div>
    </div>
  );
};
