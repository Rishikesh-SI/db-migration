-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_user khi_user_id
-- Type: CONSTRAINT

-- Name: khi_user khi_user_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_user
    ADD CONSTRAINT khi_user_id PRIMARY KEY (user_id);


--
