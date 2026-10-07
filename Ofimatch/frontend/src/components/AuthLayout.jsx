function AuthLayout({ children }) {
    return (
        <main className="auth-page">
            <div className="auth-background"></div>

            <section className="auth-card">
                {children}
            </section>
        </main>
    );
}

export default AuthLayout;