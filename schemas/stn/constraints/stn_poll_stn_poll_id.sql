-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_poll stn_poll_id
-- Type: CONSTRAINT

-- Name: stn_poll stn_poll_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_poll
    ADD CONSTRAINT stn_poll_id PRIMARY KEY (poll_id);


--
