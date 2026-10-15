-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_poll_option upy_poll_option_id
-- Type: CONSTRAINT

-- Name: upy_poll_option upy_poll_option_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_poll_option
    ADD CONSTRAINT upy_poll_option_id PRIMARY KEY (poll_option_id);


--
