-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_user labbr_user_id
-- Type: CONSTRAINT

-- Name: labbr_user labbr_user_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_user
    ADD CONSTRAINT labbr_user_id PRIMARY KEY (user_id);


--
