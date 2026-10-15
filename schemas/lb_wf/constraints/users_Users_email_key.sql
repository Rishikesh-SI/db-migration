-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: users Users_email_key
-- Type: CONSTRAINT

-- Name: users Users_email_key; Type: CONSTRAINT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.users
    ADD CONSTRAINT "Users_email_key" UNIQUE (email);


--
