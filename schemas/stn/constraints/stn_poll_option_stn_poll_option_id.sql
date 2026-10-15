-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_poll_option stn_poll_option_id
-- Type: CONSTRAINT

-- Name: stn_poll_option stn_poll_option_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_poll_option
    ADD CONSTRAINT stn_poll_option_id PRIMARY KEY (poll_option_id);


--
