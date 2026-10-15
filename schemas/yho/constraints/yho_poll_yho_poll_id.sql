-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_poll yho_poll_id
-- Type: CONSTRAINT

-- Name: yho_poll yho_poll_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_poll
    ADD CONSTRAINT yho_poll_id PRIMARY KEY (poll_id);


--
