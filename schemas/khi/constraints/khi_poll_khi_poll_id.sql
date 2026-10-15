-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_poll khi_poll_id
-- Type: CONSTRAINT

-- Name: khi_poll khi_poll_id; Type: CONSTRAINT; Schema: khi; Owner: -
--

ALTER TABLE ONLY khi.khi_poll
    ADD CONSTRAINT khi_poll_id PRIMARY KEY (poll_id);


--
