-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_user labbsc_user_id
-- Type: CONSTRAINT

-- Name: labbsc_user labbsc_user_id; Type: CONSTRAINT; Schema: labbsc_old; Owner: -
--

ALTER TABLE ONLY labbsc_old.labbsc_user
    ADD CONSTRAINT labbsc_user_id PRIMARY KEY (user_id);


--
