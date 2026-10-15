-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_poll_option ttmum_poll_option_id
-- Type: CONSTRAINT

-- Name: ttmum_poll_option ttmum_poll_option_id; Type: CONSTRAINT; Schema: ttmum; Owner: -
--

ALTER TABLE ONLY ttmum.ttmum_poll_option
    ADD CONSTRAINT ttmum_poll_option_id PRIMARY KEY (poll_option_id);


--
