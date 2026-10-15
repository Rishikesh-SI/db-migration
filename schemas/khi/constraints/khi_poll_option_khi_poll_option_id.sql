-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_poll_option khi_poll_option_id
-- Type: CONSTRAINT

-- Name: khi_poll_option khi_poll_option_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_poll_option
    ADD CONSTRAINT khi_poll_option_id PRIMARY KEY (poll_option_id);


--
