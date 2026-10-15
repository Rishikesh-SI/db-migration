-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_user_role upp_user_role_id
-- Type: CONSTRAINT

-- Name: upp_user_role upp_user_role_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_user_role
    ADD CONSTRAINT upp_user_role_id PRIMARY KEY (user_role_id);


--
