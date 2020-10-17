db.createUser(
    {
        user: "wik_wak_app",
        pwd: "wik_wak_password",
        roles: [
            {
                role: "readWrite",
                db: "wik_wak_development"
            }
        ]
    }
)