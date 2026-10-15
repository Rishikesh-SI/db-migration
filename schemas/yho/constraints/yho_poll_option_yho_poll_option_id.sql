-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_poll_option yho_poll_option_id
-- Type: CONSTRAINT

-- Name: yho_poll_option yho_poll_option_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_poll_option
    ADD CONSTRAINT yho_poll_option_id PRIMARY KEY (poll_option_id);


--
